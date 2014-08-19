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

<h3>Documentos</h3>


<jsp:useBean 
	id="customDocumentsViewerBean" 
	class="com.inercy.liferay.portlets.documents.logic.CustomDocumentsViewerBean" 
	scope="request" />

<div class="folders-container">

	<ul class="folders">
		
		<c:forEach items="${customDocumentsViewerBean.folders}" var="folder" >
			<li class="folder"><c:out value="${folder.name}" /> 
				<c:if test="${not empty folder.files}">
					<ul class="files">
						<c:forEach items="${folder.files}" var="file">
							<li class="file">
								<a href="<c:out value="${ file.url }" />">
									<c:out value="${ file.name }" />
								</a>
							</li>
						</c:forEach>
					</ul>
				</c:if>
			</li>

			<%-- <c:if test="${not empty folder.subFolders}">
				<c:set var="subfolders" value="${folder.subFolders}" scope="request"/>
				<jsp:include page="node.jsp"/>
			</c:if> --%>
		</c:forEach>
	</ul>
</div>
<!-- Include jQuery and jQuery UI -->
 <script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" type="text/javascript"></script>
 <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js" type="text/javascript"></script>
 <!-- Include Fancytree skin and library -->
 <link href="${pageContext.request.contextPath}/fancytree/skin-lion/ui.fancytree.min.css" rel="stylesheet" type="text/css">
 <script src="${pageContext.request.contextPath}/fancytree/jquery.fancytree-custom.min.js" type="text/javascript"></script>
<script>
	$(".folders-container").fancytree({
	    activeVisible: true, // Make sure, active nodes are visible (expanded).
	    aria: false, // Enable WAI-ARIA support.
	    autoActivate: true, // Automatically activate a node when it is focused (using keys).
	    autoCollapse: false, // Automatically collapse all siblings, when a node is expanded.
	    autoScroll: false, // Automatically scroll nodes into visible area.
	    clickFolderMode: 3, // 1:activate, 2:expand, 3:activate and expand, 4:activate (dblclick expands)
	    checkbox: false, // Show checkboxes.
	    debugLevel: 2, // 0:quiet, 1:normal, 2:debug
	    disabled: false, // Disable control
	    generateIds: false, // Generate id attributes like <span id='fancytree-id-KEY'>
	    idPrefix: "ft_", // Used to generate node id´s like <span id='fancytree-id-<key>'>.
	    icons: true, // Display node icons.
	    keyboard: false, // Support keyboard navigation.
	    keyPathSeparator: "/", // Used by node.getKeyPath() and tree.loadKeyPath().
	    minExpandLevel: 1, // 1: root node is not collapsible
	    selectMode: 2, // 1:single, 2:multi, 3:multi-hier
	    tabbable: true, // Whole tree behaves as one single control
	    titlesTabbable: false, // Node titles can receive keyboard focus
	   	expanded : true
	});
</script>
