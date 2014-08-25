<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<%-- <%@page import="com.inercy.liferay.portlets.documents.logic.CustomDocumentsViewerBean"%> --%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.context.ExternalContext"%>


<%@page import="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@page import="com.liferay.portal.kernel.repository.model.FileEntry"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.service.DLAppServiceUtil"%>
<%@page import="com.liferay.portal.kernel.exception.PortalException"%>
<%@page import="com.liferay.portal.kernel.exception.SystemException"%>

<%@page import="com.inercy.liferay.portlets.documents.entity.File"%>
<%@page import="com.inercy.liferay.portlets.documents.entity.Folder"%>

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


<%-- <jsp:useBean 
	id="customDocumentsViewerBean" 
	class="com.inercy.liferay.portlets.documents.logic.CustomDocumentsViewerBean" 
	scope="request" /> --%>
	
<%

List<DLFolder> dlFolders;
List<Folder> folders = new ArrayList<Folder>();
List<Folder> subFolders = new ArrayList<Folder>();

FacesContext facesContext = 
		FacesContext.getCurrentInstance();

ExternalContext externalContext = 
		facesContext.getExternalContext();
//
//PortletRequest portletRequest = 
//		(PortletRequest) externalContext.getRequest();
//
//PortletResponse portletResponse = 
//		(PortletResponse) externalContext.getResponse();

try {

	dlFolders = DLFolderLocalServiceUtil.getDLFolders(0,
			DLFolderLocalServiceUtil.getDLFoldersCount());


	List<FileEntry> dlFiles;
	List<File> files;

	Folder folder;

	// Iteramos por los folders y subfolders del sitio
	for (DLFolder dlFolder : dlFolders) {

		dlFiles = DLAppServiceUtil.getFileEntries(
				dlFolder.getRepositoryId(), dlFolder.getFolderId());
		files = new ArrayList<File>();

		// Le agregamos los archivos a cada folder y un arraylist vacio
		// de subfolders
		folder = new Folder(dlFolder.getFolderId(), dlFolder.getName(),
				dlFolder.getParentFolderId(), new ArrayList<Folder>(),
				null, dlFolder.getGroupId());

		// Iteramos por los archivos que contiene cada folder
		for (FileEntry fileEntry : dlFiles) {
			files.add(new File(folder, fileEntry.getFolderId(),
					fileEntry.getTitle(), fileEntry.getExtension(),
					fileEntry.getSize()));
		}

		folder.setFiles(files);

		// Mandamos el folder a la lista de folders o subfolders
		if (folder.getParentFolderId() == 0) {
			if (!dlFolder.isHidden()){
				folders.add(folder);
			}
		} else {
			subFolders.add(folder);
		}

	}

	// Asignamos los subfolders a los folders papá
	for (Folder subFolder : subFolders) {
		for (Folder folder2 : folders) {
			folder2.tryAddSubFolder(subFolder);
		}
	}
	
	pageContext.setAttribute("folders", folders);

} catch (SystemException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (PortalException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

%>

<ul class="folders">

	
	<c:forEach items="${folders}" var="folder" >
		
		<li class="folder">
			<i class="fa fa-plus"></i> 
			<i class="fa fa-folder"></i>
			<c:out value="${folder.name}" />
			
			<c:if test="${not empty folder.files}">
				<ul class="files">
					<c:forEach items="${folder.files}" var="file">
						<li class="file">
							<a href="<c:out value="${ file.url }" />" target="_blank" class="link">
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

	var folders = $(".folder");

	$("li.folder")
		.css("cursor", "pointer")
		.on("click", function(e){
		
			$this = $(this);
			console.log($this);
			$this.find("ul.files,ul.folders").toggle(200);

			return false;
	});	

	$("li.file>a").unbind("click");

	
</script>
