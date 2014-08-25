package com.inercy.liferay.portlets.documents.configuration;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

public class ConfigurationActionImpl implements ConfigurationAction {

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
		System.out.println("Render");
		return "/configuration.jsp";
	}

}
