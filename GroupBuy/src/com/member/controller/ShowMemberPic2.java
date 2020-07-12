package com.member.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;

//@WebServlet("/ShowMemberPic")
public class ShowMemberPic2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	java.sql.Connection con;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		res.setContentType("image/gif");
		javax.servlet.ServletOutputStream out = res.getOutputStream();
		
		try {
			String sql = "SELECT mem_icon FROM member WHERE mem_id = ?";
			java.sql.PreparedStatement pstmt = con.prepareStatement(sql);
			String mem_id = req.getParameter("mem_id");
			pstmt.setString(1, mem_id);
			
			java.sql.ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				java.io.BufferedInputStream in = new java.io.BufferedInputStream(rs.getBinaryStream("mem_icon"));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				java.io.InputStream in = getServletContext().getResourceAsStream("/NoData/none.jpg");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			}
			
		} catch (Exception e) {
			java.io.InputStream in = getServletContext().getResourceAsStream("/NoData/none.jpg");
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
