package com.inercy.liferay.portlets.documents.logic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.inercy.liferay.portlets.documents.entity.File;
import com.inercy.liferay.portlets.documents.entity.Folder;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.liferay.portlet.documentlibrary.model.DLFolder;
import com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

/**
 * Portlet implementation class CustomDocumentsViewerPortlet
 */
public class CustomDocumentsViewerBean extends MVCPortlet {

	public List<Folder> folders;
	public Folder defaultFolder;
	private Long folderId;

	public CustomDocumentsViewerBean() {
		LoadFolders();
	}

	public void LoadFolders() {
		
	}

	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)
		    throws IOException, PortletException {
		try{
			
		// System.out.println("Do View");
		
		PortletPreferences prefs = renderRequest.getPreferences();
		try{
			folderId = Long.valueOf(prefs.getValue("folderId", ""));
		} catch(NumberFormatException ex){
			folderId = (long)0;
		}
		
		// System.out.println("Folder Id: " + folderId);
		// System.out.println("Load Folders " + folderId);
		
		List<DLFolder> dlFolders;
		folders = new ArrayList<Folder>();
		List<Folder> subFolders = new ArrayList<Folder>();
		
			dlFolders = DLFolderLocalServiceUtil.getDLFolders(0,
					DLFolderLocalServiceUtil.getDLFoldersCount());

			// System.out.println(prefs.getValue("folderId", null));

			List<DLFileEntry> dlFiles;
			List<File> files;

			Folder folder;

			// Iteramos por los folders y subfolders del sitio
			for (DLFolder dlFolder : dlFolders) {

				dlFiles = DLFileEntryLocalServiceUtil.getFileEntries(
						dlFolder.getRepositoryId(), dlFolder.getFolderId());
				files = new ArrayList<File>();

				// Le agregamos los archivos a cada folder y un arraylist vacio
				// de subfolders
				folder = new Folder(dlFolder.getFolderId(), dlFolder.getName(),
						dlFolder.getParentFolderId(), new ArrayList<Folder>(),
						null, dlFolder.getGroupId());

				// Iteramos por los archivos que contiene cada folder
				for (DLFileEntry fileEntry : dlFiles) {
					if(!fileEntry.getTitle().startsWith("/")){
						files.add(new File(folder, fileEntry.getFolderId(),
								fileEntry.getTitle(), fileEntry.getExtension(),
								fileEntry.getSize()));
					}
				}

				folder.setFiles(files);

				// Mandamos el folder a la lista de folders o subfolders
				if (folder.getParentFolderId() == 0) {
					if (!dlFolder.isHidden())
						folders.add(folder);
				} else {
					if(!folder.getName().startsWith("/"))
						subFolders.add(folder);
				}

			}

			// Asignamos los subfolders a los folders papá
			for (Folder subFolder : subFolders) {
				for (Folder folder2 : folders) {
					folder2.tryAddSubFolder(subFolder);
					
					if(folder2.getFolderId() == folderId){
						defaultFolder = folder2;
					}
					
				}
			}
			
			renderRequest.setAttribute("folders", folders);
			renderRequest.setAttribute("folder", defaultFolder);

		} catch (SystemException e) {
			e.printStackTrace();
		} finally {
			super.doView(renderRequest, renderResponse);
		}
		
	}
	
	
	public List<Folder> getFolders() {
		return folders;
	}

	public void setFolders(List<Folder> folders) {
		this.folders = folders;
	}

	
	public Long getFolderId() {
		return folderId;
	}

	
	public void setFolderId(Long folderId) {
		this.folderId = folderId;
	}
}
