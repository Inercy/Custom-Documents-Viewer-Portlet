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
	scope="session" />

<ul class="folders">
	
	<c:forEach items="${customDocumentsViewerBean.folders}" var="folder" >
			<li><c:out value="${folder.name}" /> </li>
				
				<c:if test="${not empty folder.subFolders}">
					<ul>
						<c:forEach items="${folder.subFolders}" var="subFolder">
							<li><c:out value="${ subFolder.name }" /></li>
							
							<c:if test="${not empty subFolder.files}">
							<ul>
								<c:forEach items="${subFolder.files}" var="subFile">
									<li>
										<a href="<c:out value="${ subFile.url }" />">
											<c:out value="${ subFile.name }" />
										</a>
									</li>
								</c:forEach>
							</ul>
							</c:if>
							
						</c:forEach>
					</ul>
				</c:if>
				
				<c:if test="${not empty folder.files}">
					<ul>
						<c:forEach items="${folder.files}" var="file">
							<li>
								<a href="<c:out value="${ file.url }" />">
									<c:out value="${ file.name }" />
								</a>
							</li>
						</c:forEach>
					</ul>
				</c:if>
				
	</c:forEach>
	 
</ul>
