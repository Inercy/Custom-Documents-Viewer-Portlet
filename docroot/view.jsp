<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<%@page import="com.inercy.liferay.portlets.documents.logic.CustomDocumentsViewerBean"%>
<%
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<portlet:defineObjects />
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<h3>Documentos</h3>


<jsp:useBean 
	id="customDocumentsViewerBean" 
	class="com.inercy.liferay.portlets.documents.logic.CustomDocumentsViewerBean" 
	scope="request" />

<ul class="folders">
	
	<c:forEach items="${customDocumentsViewerBean.folders}" var="folder" >
			<li class="folder ">
				<i class="fa fa-plus"></i> 
				<i class="fa fa-folder"></i>
				<c:out value="${folder.name}" />
				
				
				

				<c:if test="${not empty folder.files}">
					<ul class="files">
						<c:forEach items="${folder.files}" var="file">
							<li class="file">
								
									<a href="<c:out value="${ file.url }" />">
										<i class="fa fa-file"></i>
										<c:out value="${ file.name }" />
									</a>
								
							</li>
						</c:forEach>
					</ul>
				</c:if>
				
				<c:if test="${not empty folder.subFolders}">
					<c:set var="subfolders" value="${folder.subFolders}" scope="request"/>
					<jsp:include page="node.jsp"/>
				</c:if>
				
			</li>	
	</c:forEach>
	 
</ul>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>

	var folders = $(".folders");

	folders.find(".subfolders").hide();
	folders.find(".files").hide();

	$(".folders .folder").css("cursor", "pointer").on("click", function(){
		$(this).find("ul.subfolders").toggle(200);
		$(this).find("ul.files").toggle(200);
	});
	
</script>
