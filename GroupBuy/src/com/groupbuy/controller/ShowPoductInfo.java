package com.groupbuy.controller;

import java.io.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import com.product.model.*;

@WebServlet("/ShowPoductInfo")
public class ShowPoductInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Connection con;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		try {
			String p_id = req.getParameter("p_id");
			ProService productSvc = new ProService();
			ProVO proVO = productSvc.getOnePro(p_id);
			String p_info = proVO.getP_info();
			out.print(p_info);
			
		} catch (Exception e) {
			out.print("未有商品描述");
		}
		
	}

	public void init() throws ServletException {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
			con = ds.getConnection();
		} catch (NamingException ne) {
			ne.printStackTrace(System.err);
		} catch (SQLException se) {
			se.printStackTrace(System.err);
		}
	}
	
	public void destroy() {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException se) {
			se.printStackTrace(System.err);
		}
	}
	
	
}
