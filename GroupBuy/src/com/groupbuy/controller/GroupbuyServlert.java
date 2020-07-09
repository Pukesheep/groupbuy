package com.groupbuy.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import com.groupbuy.model.*;

@WebServlet("/GroupbuyServlert")
public class GroupbuyServlert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String from = req.getParameter("from");
		
		String front = 				"/front-end";
		String back = 				"/back-end";
		String select_page = 		"/groupbuy/select_page.jsp";
		String listOneGroupbuy = 	"/groupbuy/listOneGroupbuy.jsp";
		String listAllGroupbuy = 	"/groupbuy/listAllgroupbuy.jsp";
		
		if ("getOne_For_Display".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			if (from.contains("front")) {
				select_page = 		front + select_page;
				listOneGroupbuy = 	front + listOneGroupbuy;
			} else {
				select_page = 		back + select_page;
				listOneGroupbuy = 	back + listOneGroupbuy;
			}
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("gro_id");
				String strReg = "^G[(0-9)]{6}$";
				if (str == null || (str.trim().length()) == 0) {
					errorMsgs.add("團購案編號： 請輸入團購案編號");
				} else if (!str.matches(strReg)) {
					errorMsgs.add("團購案編號： 請輸入正確格式");
				}
				
				String gro_id = str;
				/***************************2.開始查詢資料*****************************************/
				GroupbuyService groupbuySvc = new GroupbuyService();
				GroupbuyVO groupbuyVO = groupbuySvc.getOneGroupbuy(gro_id);
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(select_page);
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupbuyVO", groupbuyVO);
				RequestDispatcher successView = req.getRequestDispatcher(listOneGroupbuy);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
				
			} catch (Exception e) {
				errorMsgs.add("無法取得資料： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(select_page);
				failureView.forward(req, res);
			}
			
			
			
		}
		
		
	}

}
