package com.sitewhere.web.i18n.filter;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class I18nFilter implements Filter {
	/** Property source path */
	private String SOURCE = "i18n.sitewhere";
	/** Default Locale is US */
	private Locale DEFAULT_LOCALE = Locale.US;
	/** Init default rb */
	private ResourceBundle rb = ResourceBundle.getBundle(SOURCE,DEFAULT_LOCALE);
	/**  Source name */
	private String RESOURCE_NAME = "rb";
	/**  Custom US value */
	private String CUDTOM_US_VALUE = "US";
	/**  Custom China value */
	private String CUDTOM_CHINA_VALUE = "CHINA";
	public void destroy() {
	}
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		ResourceBundle rb_tem;
		/** Set custom language to session */
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		String i18n_language = request.getParameter("i18n_language");
		HttpSession session = request.getSession();
		if(i18n_language != null && !"".equals(i18n_language)){
			if(CUDTOM_CHINA_VALUE.equals(i18n_language)){
				rb_tem = ResourceBundle.getBundle(SOURCE,Locale.CHINA);
			}else{
				rb_tem = ResourceBundle.getBundle(SOURCE,Locale.US);
			}
			session.setAttribute(RESOURCE_NAME, rb_tem);
			String refererUrl = getRefererUrl(request);
			response.sendRedirect(refererUrl);
		}else{
			/** Set default language to session */
			if(session != null && session.getAttribute(RESOURCE_NAME) == null){
				rb_tem = ResourceBundle.getBundle(SOURCE,request.getLocale());
				session.setAttribute(RESOURCE_NAME, rb_tem);
			}
			chain.doFilter(request, response);
		}
		
	}
	private String getRefererUrl(HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		String contextPath = request.getContextPath();
		return contextPath+referer.split(contextPath)[1];
	}
	public void init(FilterConfig arg0) throws ServletException {
		/** Set default rb to application */
		arg0.getServletContext().setAttribute(RESOURCE_NAME, rb);
	}
}