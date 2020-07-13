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
		
		if ("join".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			List<String> successMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			req.setAttribute("successMsgs", successMsgs);
			
			GromemService gromemSvc = new GromemService();
			GroupbuyService groupbuySvc = new GroupbuyService();
			GroupbuyVO groupbuyVO = null;
			
			try {
				/***************************1.接收請求參數****************************************/
				String mem_id = req.getParameter("mem_id");
				String gro_id = req.getParameter("gro_id");
				
				/***************************2.開始驗證資料***************************************/
				groupbuyVO = groupbuySvc.getOneGroupbuy(gro_id);
				Integer people = groupbuyVO.getPeople();
				Integer amount = groupbuyVO.getAmount();
				
				GromemVO gromemVO1 = gromemSvc.getOneGromem(mem_id, gro_id);
				
				if (gromemVO1 != null) {
					req.setAttribute("groupbuyVO", groupbuyVO);
					errorMsgs.add("已加入團購, 操作失敗");
					RequestDispatcher failureView = req.getRequestDispatcher(listOneGroupbuy);
					failureView.forward(req, res);
					return;
				}
				
				if (people == amount) {
					req.setAttribute("groupbuyVO", groupbuyVO);
					errorMsgs.add("團購人數已滿, 加入失敗");
					RequestDispatcher failureView = req.getRequestDispatcher(listOneGroupbuy);
					failureView.forward(req, res);
					return;
				} else {
					// 驗證成功
					/***************************3.開始新增資料***************************************/

					GromemVO gromemVO = new GromemVO();
					gromemVO.setMem_id(mem_id);
					gromemVO.setGro_id(gro_id);
					
					gromemSvc.join(gromemVO, ++people);
					groupbuyVO.setPeople(people);
				}
				
				/***************************4.新增完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupbuyVO", groupbuyVO);
				successMsgs.add("加入成功");
				RequestDispatcher successView = req.getRequestDispatcher(listOneGroupbuy);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/

			} catch (Exception e) {
				errorMsgs.add("新增資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listOneGroupbuy);
				failureView.forward(req, res);
			}
		}
		
		if ("quit".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			List<String> successMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			req.setAttribute("successMsgs", successMsgs);
			
			GroupbuyService groupbuySvc = new GroupbuyService();
			GroupbuyVO groupbuyVO = null;
			
			try {
				/***************************1.接收請求參數***************************************/
				String mem_id = req.getParameter("mem_id");
				String gro_id = req.getParameter("gro_id");
				
				/***************************2.開始驗證資料***************************************/
				GromemService gromemSvc = new GromemService();
				GromemVO gromemVO = gromemSvc.getOneGromem(mem_id, gro_id);
				groupbuyVO = groupbuySvc.getOneGroupbuy(gro_id);
				
				if (gromemVO  == null) {
					errorMsgs.add("查無資料, 操作失敗");
					req.setAttribute("groupbuyVO", groupbuyVO);
					RequestDispatcher failureView = req.getRequestDispatcher(listOneGroupbuy);
					failureView.forward(req, res);
					return;
				} else {
					// 驗證成功
					/***************************3.開始刪除資料***************************************/
					
					Integer people = groupbuyVO.getPeople();
					gromemSvc.quit(gromemVO, --people);
					groupbuyVO.setPeople(people);
				}
				
				/***************************4.刪除完成,準備轉交(Send the Success view)***********/
				req.setAttribute("groupbuyVO", groupbuyVO);
				successMsgs.add("退出成功");
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
