package net.java_school.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharacterEncodingFilter implements Filter {
	
	private String characterSet;

	public void init(FilterConfig config) throws ServletException {
		this.characterSet = config.getInitParameter("characterSet");
	}
	
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		if (req.getCharacterEncoding() == null) {
			req.setCharacterEncoding(characterSet);
			chain.doFilter(req, resp);
		}

	}

	public void destroy() {}
	
}
