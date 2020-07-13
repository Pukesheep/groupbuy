package com.gro_order.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import com.gro_order.model.*;

@WebServlet("/Gro_orderServlet")
public class Gro_orderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String from = req.getParameter("from");
		
		String front = 				"/front-end/protected";
		String back = 				"/back-end/protected";
		
		String select_page = 		"/groupbuy/select_page.jsp";
		String listOneGro_order = 	"/groupbuy/listOneGro_order.jsp";
		String listAllGro_order = 	"/groupbuy/listAllGro_order.jsp";
		
		if (from.contains("front")) {
			select_page = 		front + select_page;
			listOneGro_order = 	front + listOneGro_order;
			listAllGro_order = 	front + listAllGro_order;
		} else {
			select_page = 		back + select_page;
			listOneGro_order = 	back + listOneGro_order;
			listAllGro_order = 	back + listAllGro_order;
		}
		
		// 前台會員修改訂單資料
		if ("update".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			List<String> successMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			req.setAttribute("successMsgs", successMsgs);
			
			Gro_orderVO gro_orderVO = null;
			
			try {
				/***************************1.接收請求參數****************************************/
				String ord_id = req.getParameter("ord_id");
				String ordstat_id = req.getParameter("ordstat_id");
				
				/***************************2.開始修改資料***************************************/
				Gro_orderService gro_orderSvc = new Gro_orderService();
				gro_orderVO = gro_orderSvc.getOneGro_order(ord_id);
				Timestamp ord_date = gro_orderVO.getOrd_date();
				String mem_id = gro_orderVO.getMem_id();
				String gro_id = gro_orderVO.getGro_id();
				Integer ord_price = gro_orderVO.getOrd_price();
				String receive_name = gro_orderVO.getReceive_name();
				String address = gro_orderVO.getAddress();
				String phone = gro_orderVO.getPhone();
				gro_orderVO.setOrdstat_id(ordstat_id);
				
				gro_orderSvc.updateGro_order(ord_id, gro_id, mem_id, ordstat_id, ord_price, ord_date, receive_name, address, phone);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("gro_orderVO", gro_orderVO);
				successMsgs.add("修改成功");
				RequestDispatcher successView = req.getRequestDispatcher(listOneGro_order);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/

			} catch (Exception e) {
				errorMsgs.add("修改資料失敗： " + e.getMessage());
				req.setAttribute("gro_orderVO", gro_orderVO);
				RequestDispatcher failureView = req.getRequestDispatcher(listOneGro_order);
				failureView.forward(req, res);
			}
		}
		
		// 後台管理員修改訂單資料
		if ("manage".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			List<String> successMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			req.setAttribute("successMsgs", successMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String ord_id = req.getParameter("ord_id");
				String ordstat_id = req.getParameter("ordstat_id");
				
				/***************************2.開始修改資料****************************************/
				Gro_orderService gro_orderSvc = new Gro_orderService();
				Gro_orderVO gro_orderVO = gro_orderSvc.getOneGro_order(ord_id);
				
				gro_orderSvc.updateGro_order(ord_id, gro_orderVO.getGro_id(), gro_orderVO.getMem_id(), ordstat_id, gro_orderVO.getOrd_price(), gro_orderVO.getOrd_date(),
						gro_orderVO.getReceive_name(), gro_orderVO.getAddress(), gro_orderVO.getPhone());
				/***************************4.新增完成,準備轉交(Send the Success view)*************/
				successMsgs.add("修改成功");
				RequestDispatcher successView = req.getRequestDispatcher(listAllGro_order);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/

			} catch (Exception e) {
				errorMsgs.add("修改資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listAllGro_order);
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Display".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			List<String> successMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			req.setAttribute("successMsgs", successMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("ord_id");
				String strReg = "^GO[(0-9]{6}$";
				if (str == null || (str.trim().length()) == 0) {
					errorMsgs.add("訂單編號： 請輸入訂單編號");
				} else if (!str.matches(strReg)) {
					errorMsgs.add("訂單編號： 請輸入正確格式");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(listAllGro_order);
					failureView.forward(req, res);
					return;
				}
				
				String ord_id = str;
				/***************************2.開始查詢資料*****************************************/
				Gro_orderService gro_orderSvc = new Gro_orderService();
				Gro_orderVO gro_orderVO = gro_orderSvc.getOneGro_order(ord_id);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("gro_orderVO", gro_orderVO);
				RequestDispatcher successView = req.getRequestDispatcher(listOneGro_order);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
				
			} catch (Exception e) {
				errorMsgs.add("無法取得資料： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listAllGro_order);
				failureView.forward(req, res);
			}
			
		}
		
		if ("payment".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			List<String> successMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			req.setAttribute("successMsgs", successMsgs);
			
			Gro_orderVO gro_orderVO = null;
			
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String ord_id = req.getParameter("ord_id");
				String receive_name = req.getParameter("receive_name");
				
				
				
				
				
				String address = req.getParameter("address");
				String phone = req.getParameter("phone");
				
				
				
				
				
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listOneGro_order);
				failureView.forward(req, res);
			}
			
		}
		
		
		
	}

}
