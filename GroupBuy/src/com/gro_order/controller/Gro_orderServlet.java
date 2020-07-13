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
		String listOneGro_order = 	"/gro_order/listOneGro_order.jsp";
		String listAllGro_order = 	"/gro_order/listAllGro_order.jsp";
		
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
			
			Gro_orderServier gro_orderSvc = new Gro_orderServier();
			Gro_orderVO gro_orderVO = null;
			
			try {
				/***************************1.接收請求參數****************************************/
				String ord_id = req.getParameter("ord_id");
				String gro_id = req.getParameter("gro_id");
				String mem_id = req.getParameter("mem_id");
				String ordstat_id = req.getParameter("ordstat_id");
				
				/***************************2.開始修改資料***************************************/
				gro_orderVO = gro_orderSvc.getOneGro_order(ord_id);
				Timestamp ord_date = gro_orderVO.getOrd_date();
				gro_orderVO.setGro_id(gro_id);
				gro_orderVO.setMem_id(mem_id);
				gro_orderVO.setOrdstat_id(ordstat_id);
				
				gro_orderSvc.updateGro_order(ord_id, gro_id, mem_id, ordstat_id, ord_date);
				
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
				
				
				
				
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listAllGro_order);
				failureView.forward(req, res);
			}
			
		}
		
		
		
	}

}
