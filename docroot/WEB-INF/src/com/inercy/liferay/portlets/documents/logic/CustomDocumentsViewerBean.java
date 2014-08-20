package com.inercy.liferay.portlets.documents.logic;

import java.util.ArrayList;
import java.util.List;

import com.inercy.liferay.portlets.documents.entity.File;
import com.inercy.liferay.portlets.documents.entity.Folder;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portlet.documentlibrary.model.DLFolder;
import com.liferay.portlet.documentlibrary.service.DLAppServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

/**
 * Portlet implementation class CustomDocumentsViewerPortlet
 */
public class CustomDocumentsViewerBean extends MVCPortlet {

	public List<Folder> folders;

	public CustomDocumentsViewerBean() {
		init();
	}

	public void init() {

		List<DLFolder> dlFolders;
		folders = new ArrayList<Folder>();
		List<Folder> subFolders = new ArrayList<Folder>();

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
					 folders.add(folder);
				 } else {
					 subFolders.add(folder);
				 }

			}

			// Asignamos los subfolders a los folders papá
			for(Folder subFolder : subFolders){
				for(Folder folder2 : folders){
					folder2.tryAddSubFolder(subFolder);
				}
			}
			

		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (PortalException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public List<Folder> getFolders() {
		return folders;
	}

	public void setFolders(List<Folder> folders) {
		this.folders = folders;
	}

}
