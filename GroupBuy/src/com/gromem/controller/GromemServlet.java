package com.gromem.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import com.gromem.model.*;
import com.groupbuy.model.*;

@WebServlet("/GromemServlet")
public class GromemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String from = req.getParameter("from");
		
		String front = 					"/front-end";
		String back = 					"/back-end/protected";
		
		String select_page = 			"/groupbuy/select_page.jsp";
		String listOneGroupbuy = 		"/groupbuy/listOneGroupbuy.jsp";
		String listAllGroupbuy = 		"/groupbuy/listAllGroupbuy.jsp";
		String update_groupbuy_input = 	"/groupbuy/update_groupbuy_input.jsp";
		String addGroupbuy = 			"/groupbuy/addGroupbuy.jsp";
		
		if (from.contains("front")) {
			select_page = 			front + select_page;
			listOneGroupbuy = 		front + listOneGroupbuy;
			listAllGroupbuy = 		front + listAllGroupbuy;
			update_groupbuy_input = front + update_groupbuy_input;
			addGroupbuy = 			front + addGroupbuy;
		} else {
			select_page = 			back + select_page;
			listOneGroupbuy = 		back + listOneGroupbuy;
			listAllGroupbuy = 		back + listAllGroupbuy;
			update_groupbuy_input = back + update_groupbuy_input;
			addGroupbuy = 			back + addGroupbuy;
		}
		
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			GroupbuyService groupbuySvc = new GroupbuyService();
			GroupbuyVO groupbuyVO = null;
			
			try {
				/***************************1.接收請求參數****************************************/
				String mem_id = req.getParameter("mem_id");
				String gro_id = req.getParameter("gro_id");
				
				/***************************2.開始新增資料***************************************/
				GromemService gromemSvc = new GromemService();
				gromemSvc.addGromem(mem_id, gro_id);
				
				/***************************3.新增完成,準備轉交(Send the Success view)*************/
				groupbuyVO = groupbuySvc.getOneGroupbuy(gro_id);
				req.setAttribute("groupbuyVO", groupbuyVO);
				RequestDispatcher successView = req.getRequestDispatcher(listOneGroupbuy);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/

			} catch (Exception e) {
				req.setAttribute("groupbuyVO", groupbuyVO);
				errorMsgs.add("新增資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listOneGroupbuy);
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			GroupbuyService groupbuySvc = new GroupbuyService();
			GroupbuyVO groupbuyVO = null;
			
			try {
				/***************************1.接收請求參數***************************************/
				String mem_id = req.getParameter("mem_id");
				String gro_id = req.getParameter("gro_id");
				
				/***************************2.開始刪除資料***************************************/
				GromemService gromemSvc = new GromemService();
				gromemSvc.deleteGromem(mem_id, gro_id);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				groupbuyVO = groupbuySvc.getOneGroupbuy(gro_id);
				req.setAttribute("groupbuyVO", groupbuyVO);
				RequestDispatcher successView = req.getRequestDispatcher(listOneGroupbuy);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/

			} catch (Exception e) {
				req.setAttribute("groupbuyVO", groupbuyVO);
				errorMsgs.add("刪除資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listOneGroupbuy);
				failureView.forward(req, res);
			}
			
		}
		
		
	}

}
