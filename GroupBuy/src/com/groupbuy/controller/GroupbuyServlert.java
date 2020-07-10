package com.groupbuy.controller;

import java.io.*;
import java.sql.*;
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
		String update_groupbuy_input = 	"/groupbuy/update_groupbuy_input.jsp";
		
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
		
		
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				
				String gro_id = req.getParameter("gro_id");
				String p_id = req.getParameter("p_id");
				String reb1_no = req.getParameter("reb1_no");
				String reb2_no = req.getParameter("reb2_no");
				String reb3_no = req.getParameter("reb3_no");
				
				Integer status = null;
				try {
					status = new Integer(req.getParameter("status"));
				} catch (NumberFormatException e) {
					errorMsgs.add("團購案狀態： 請輸入正確的數字格式");
				}
				
				Integer people = null;
				try {
					people = new Integer(req.getParameter("people"));
				} catch (NumberFormatException e) {
					errorMsgs.add("參加人數： 請輸入正確的格式");
				}
				
				Double money = null;
				try {
					money = new Double(req.getParameter("money"));
				} catch (NumberFormatException e) {
					errorMsgs.add("商品金額： 請輸入正確的格式");
				}
				
				Timestamp start_date = null;
				try {
					start_date = Timestamp.valueOf(req.getParameter("start_date").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.add("開始時間： 請輸入正確的時間格式");
				}
				
				Integer grotime = null;
				try {
					grotime = new Integer(req.getParameter("grotime"));
				} catch (NumberFormatException e) {
					errorMsgs.add("團購期間： 請輸入正確的數字格式");
				}
				
				Timestamp end_date = null;
				try {
					end_date = Timestamp.valueOf(req.getParameter("end_date"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("結束時間： 請輸入正確的時間格式");
				}
				
				GroupbuyVO groupbuyVO = new GroupbuyVO();
				groupbuyVO.setGro_id(gro_id);
				groupbuyVO.setP_id(p_id);
				groupbuyVO.setStart_date(start_date);
				groupbuyVO.setGrotime(grotime);
				groupbuyVO.setEnd_date(end_date);
				groupbuyVO.setStatus(status);
				groupbuyVO.setPeople(people);
				groupbuyVO.setMoney(money);
				groupbuyVO.setReb1_no(reb1_no);
				groupbuyVO.setReb2_no(reb2_no);
				groupbuyVO.setReb3_no(reb3_no);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("groupbuyVO", groupbuyVO);
					RequestDispatcher failureView = req.getRequestDispatcher(listAllGroupbuy);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料***************************************/
				GroupbuyService groupbuySvc = new GroupbuyService();
				groupbuyVO = groupbuySvc.updateGroupbuy(gro_id, p_id, start_date, end_date, grotime,
						reb1_no, reb2_no, reb3_no, people, money);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupbuyVO", groupbuyVO);
				RequestDispatcher successView = req.getRequestDispatcher(listAllGroupbuy);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
				
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listAllGroupbuy);
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String gro_id = req.getParameter("gro_id");
				
				/***************************2.開始查詢資料****************************************/
				GroupbuyService groupbuySvc = new GroupbuyService();
				GroupbuyVO groupbuyVO = groupbuySvc.getOneGroupbuy(gro_id);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				
				req.setAttribute("groupbuyVO", groupbuyVO);
				RequestDispatcher successView = req.getRequestDispatcher(update_groupbuy_input);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
				
			} catch (Exception e) {
				errorMsgs.add("無法取得資料： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listOneGroupbuy);
				failureView.forward(req, res);
			}
		}
		
		
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				
				String p_id = req.getParameter("p_id");
				String reb1_no = req.getParameter("reb1_no");
				String reb2_no = req.getParameter("reb2_no");
				String reb3_no = req.getParameter("reb3_no");
				
				
				Integer status = null;
				try {
					status = new Integer(req.getParameter("status"));
				} catch (NumberFormatException e) {
					errorMsgs.add("團購案狀態： 請輸入正確的數字格式");
				}
				
				Integer people = null;
				try {
					people = new Integer(req.getParameter("people"));
				} catch (NumberFormatException e) {
					errorMsgs.add("參加人數： 請輸入正確的格式");
				}
				
				Double money = null;
				try {
					money = new Double(req.getParameter("money"));
				} catch (NumberFormatException e) {
					errorMsgs.add("商品金額： 請輸入正確的格式");
				}
				
				Timestamp start_date = null;
				try {
					start_date = Timestamp.valueOf(req.getParameter("start_date").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.add("開始時間： 請輸入正確的時間格式");
				}
				
				Integer grotime = null;
				try {
					grotime = new Integer(req.getParameter("grotime"));
				} catch (NumberFormatException e) {
					errorMsgs.add("團購期間： 請輸入正確的數字格式");
				}
				
				Timestamp end_date = null;
				try {
					end_date = Timestamp.valueOf(req.getParameter("end_date"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("結束時間： 請輸入正確的時間格式");
				}				
				
				GroupbuyVO groupbuyVO = new GroupbuyVO();
				groupbuyVO.setP_id(p_id);
				groupbuyVO.setStart_date(start_date);
				groupbuyVO.setGrotime(grotime);
				groupbuyVO.setEnd_date(end_date);
				groupbuyVO.setStatus(status);
				groupbuyVO.setPeople(people);
				groupbuyVO.setMoney(money);
				groupbuyVO.setReb1_no(reb1_no);
				groupbuyVO.setReb2_no(reb2_no);
				groupbuyVO.setReb3_no(reb3_no);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("groupbuyVO", groupbuyVO);
					RequestDispatcher failureView = req.getRequestDispatcher(listAllGroupbuy);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				GroupbuyService groupbuySvc = new GroupbuyService();
				groupbuyVO = groupbuySvc.addGroupbuy(p_id, start_date, end_date, grotime, 
						reb1_no, reb2_no, reb3_no, people, money);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				
				RequestDispatcher successView = req.getRequestDispatcher(listAllGroupbuy);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/

			} catch (Exception e) {
				errorMsgs.add("新增資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listAllGroupbuy);
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數***************************************/
				String gro_id = req.getParameter("gro_id");
				
				/***************************2.開始刪除資料***************************************/
				GroupbuyService groupbuySvc = new GroupbuyService();
				groupbuySvc.deleteGroupbuy(gro_id);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				RequestDispatcher successView = req.getRequestDispatcher(listAllGroupbuy);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
				
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗： " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listAllGroupbuy);
				failureView.forward(req, res);
			}
		}
		
		
		
	}

}
