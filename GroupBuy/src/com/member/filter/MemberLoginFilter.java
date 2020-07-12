package com.member.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.member.model.*;

//@WebFilter("/LoginFilter")
public class MemberLoginFilter implements Filter {
	
	private FilterConfig config;
	
	public void init(FilterConfig config) {
		this.config = config;
	}
	
	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		javax.servlet.http.HttpServletRequest req = (HttpServletRequest) request;
		javax.servlet.http.HttpServletResponse res = (HttpServletResponse) response;
		
		// 取得 session
		javax.servlet.http.HttpSession session = req.getSession();
		
		// 從 seesion 判斷此 user 是否登入過
		MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
		
//		if (memberVO == null && admVO == null) {
//			session.setAttribute("location", req.getRequestURI());
//			res.sendRedirect(req.getContextPath() + "/front-end/member/login.jsp");
//			return;
//		} else if (memberVO != null || admVO != null) {
//			chain.doFilter(request, response);
//		}
		
		if (memberVO == null) {
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath() + "/front-end/member/login.jsp");
			return;
		} else {
			chain.doFilter(request, response);
		}
		
	}
}
