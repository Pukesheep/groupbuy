package com.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.member.model.MemberService;
import com.member.model.MemberVO;

//@WebServlet("/CheckServlet")
public class CheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("application/json;charset=utf-8");
		String action = req.getParameter("action");
		
		if ("check".equals(action)) {
			// 註冊時檢查電子郵件是否已被註冊
			String mem_email = req.getParameter("mem_email");
			org.json.JSONObject oo = new org.json.JSONObject();
			
			try {
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.loginByEmail(mem_email);
				
				oo.put("isUsed", false);
				if (memberVO.getMem_id() != null) {
					// 電子郵件已被註冊, 把 isUsed 改成 true
					oo.put("isUsed", true);
				}
				
				PrintWriter out = res.getWriter();
				out.println(oo);
				out.flush();
				out.close();
				
			} catch (Exception e) {
				e.printStackTrace(System.err);
			}
		}
	}

}
