package com.inercy.liferay.portlets.documents.configuration;

import java.util.ArrayList;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.inercy.liferay.portlets.documents.entity.File;
import com.inercy.liferay.portlets.documents.entity.Folder;
import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.liferay.portlet.documentlibrary.model.DLFolder;
import com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil;

public class ConfigurationActionImpl implements ConfigurationAction {

	public List<Folder> folders;
	public Folder defaultFolder;
	private Long folderId;
	
	@Override
	public void processAction(PortletConfig config,
			ActionRequest actionRequest, ActionResponse actionResponse)
			throws Exception {

		String folderId = actionRequest.getParameter("folderId");

		String portletResource = ParamUtil.getString(actionRequest,
				"portletResource");

		PortletPreferences prefs = PortletPreferencesFactoryUtil
				.getPortletSetup(actionRequest, portletResource);

		prefs.setValue("folderId", folderId);
		prefs.store();

		SessionMessages.add(actionRequest, config.getPortletName()
				+ ".doConfigure");

	}

	@Override
	public String render(PortletConfig arg0, RenderRequest arg1,
			RenderResponse arg2) throws Exception {
		// TODO Auto-generated method stub
		PortletPreferences prefs = arg1.getPreferences();
		try{
			folderId = Long.valueOf(prefs.getValue("folderId", ""));
		} catch(NumberFormatException ex){
			folderId = (long)0;
		}

		System.out.println("Folder Id: " + folderId);

		System.out.println("Load Folders " + folderId);
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
				files.add(new File(folder, fileEntry.getFolderId(), fileEntry
						.getTitle(), fileEntry.getExtension(), fileEntry
						.getSize()));
			}

			folder.setFiles(files);

			// Mandamos el folder a la lista de folders o subfolders
			if (folder.getParentFolderId() == 0) {
				if (!dlFolder.isHidden())
					folders.add(folder);
			} else {
				subFolders.add(folder);
			}

		}

		arg1.setAttribute("folders", folders);
		return "/configuration.jsp";
	}

}
