package com.inercy.liferay.portlets.documents.configuration;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.portlet.ConfigurationAction;

public class ConfigurationActionImpl implements ConfigurationAction {

	@Override
	public void processAction(PortletConfig arg0, ActionRequest arg1,
			ActionResponse arg2) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("process action");
		
	}

	@Override
	public String render(PortletConfig arg0, RenderRequest arg1,
			RenderResponse arg2) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("Render");
		return "/configuration.jsp";
	}

}