package com.member.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;
import com.member.model.*;

//@WebServlet("/ShowMemberPic")
public class ShowMemberPic extends HttpServlet {
	private static final long serialVersionUID = 1L;

	java.sql.Connection con;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		res.setContentType("image/gif");
		javax.servlet.ServletOutputStream out = res.getOutputStream();
		
		try {
			String mem_id = req.getParameter("mem_id");
			MemberService memberSvc = new MemberService();
			MemberVO memberVO = memberSvc.getOneMember(mem_id);
			byte[] mem_icon = memberVO.getMem_icon();
			out.write(mem_icon);
			
		} catch (Exception e) {
			java.io.InputStream in = getServletContext().getResourceAsStream("/NoData/null2.jpg");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
		
	}

	public void init() throws ServletException {
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
			con = ds.getConnection();
		} catch (javax.naming.NamingException ne) {
			ne.printStackTrace(System.err);
		} catch (java.sql.SQLException se) {
			se.printStackTrace(System.err);
		}
	}
	
	public void destroy() {
		try {
			if (con != null) {
				con.close();
			}
		} catch (java.sql.SQLException se) {
			se.printStackTrace(System.err);
		}
	}
	
}
