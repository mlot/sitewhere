/*
 * CommandHtmlHelper.java 
 * --------------------------------------------------------------------------------------
 * Copyright (c) Reveal Technologies, LLC. All rights reserved. http://www.reveal-tech.com
 *
 * The software in this package is published under the terms of the CPAL v1.0
 * license, a copy of which has been included with this distribution in the
 * LICENSE.txt file.
 */
package com.sitewhere.web.helper;

import com.sitewhere.rest.model.device.command.DeviceCommand;
import com.sitewhere.rest.model.device.event.DeviceCommandInvocation;
import com.sitewhere.spi.SiteWhereException;
import com.sitewhere.spi.device.command.ICommandParameter;

/**
 * Helper class that creates an HTML version of a command for display in the user
 * interface.
 * 
 * @author Derek
 */
public class CommandHtmlHelper {

	/**
	 * Get an HTML version of a command invocation that can be shown in the UI.
	 * 
	 * @param invocation
	 * @return
	 * @throws SiteWhereException
	 */
	public static String getHtml(DeviceCommandInvocation invocation) throws SiteWhereException {
		DeviceCommand command = invocation.getCommand();
		if (command == null) {
			throw new SiteWhereException("Command information must be populated to generate HTML.");
		}
		String html = "";
		html += "<span class='sw-spec-command-name'>" + command.getName() + "</span>(";
		int i = 0;
		for (ICommandParameter param : command.getParameters()) {
			String value = invocation.getParameterValues().get(param.getName());
			if (param.isRequired()) {
				html += "<span class='sw-spec-command-param-required'>";
			}
			if (i++ > 0) {
				html += ", ";
			}
			html += " <span class='sw-spec-command-param-name'>" + param.getName() + "</span>";
			if (value != null) {
				html +=
						":<span class='sw-spec-command-param-type' title='" + param.getType() + "'>" + value
								+ "</span> ";
			}
			if (param.isRequired()) {
				html += "</span>";
			}
		}
		html += ")";
		return html;
	}
}