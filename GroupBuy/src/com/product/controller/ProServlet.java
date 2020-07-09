package com.product.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.product.model.*;

@MultipartConfig
public class ProServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String select_page = 	"/product/select_page.jsp";
			String listOneProduct = "/product/listOneProduct.jsp";
			
			String from = req.getParameter("from");
			if ("back-end".equals(from)) {
				select_page = 		"/back-end" + select_page;
				listOneProduct = 	"/back-end" + listOneProduct;
			} else if ("front-end".equals(from)) {
				select_page = 		"/front-end" + select_page;
				listOneProduct = 	"/front-end" + listOneProduct;
			}
			

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("p_id");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入商品編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(select_page);
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String p_id = null;
				try {
					p_id = new String(str);
				} catch (Exception e) {
					errorMsgs.add("商品編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(select_page);
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ProService ProSvc = new ProService();
				ProVO proVO = ProSvc.getOnePro(p_id);
				if (proVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(select_page);
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("proVO", proVO); // 資料庫取出的proVO物件,存入req
				String url = "listOneProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(listOneProduct); // 成功轉交 listOnePro.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(select_page);
				failureView.forward(req, res);
			}

		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllPro.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String listAllProduct = "/back-end/product/listAllProduct.jsp";
			String update_Pro_input = "/back-end/product/update_Pro_input.jsp";

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String p_id = new String(req.getParameter("p_id"));// p001

				/*************************** 2.開始查詢資料 ****************************************/
				ProService proSvc = new ProService();
				ProVO proVO = proSvc.getOnePro(p_id);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("proVO", proVO); // 資料庫取出的proVO物件,存入req
				String url = "update_Pro_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(update_Pro_input);// 成功轉交 update_Pro_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(listAllProduct);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_pro_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String listOneProduct = 	"/back-end/product/listOneProduct.jsp";
			String update_Pro_input = 	"/back-end/product/update_Pro_input.jsp";

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String p_id = new String(req.getParameter("p_id").trim());

				String p_name = req.getParameter("p_name");
				if (p_name == null || p_name.trim().length() == 0) {
					errorMsgs.add("商品名稱請勿空白");
				}

				Double p_price = null;
				String p_pricestr = req.getParameter("p_price");
				if (p_pricestr == null || (p_pricestr.trim()).length() == 0) {
					p_price = 0.0;
					errorMsgs.add("商品價格請勿空白");
				} else {
					try {
						p_price = new Double(req.getParameter("p_price").trim());
					} catch (NumberFormatException e) {
						p_price = 0.0;
						errorMsgs.add("商品價格請填數字.");
					}
				}

				String p_info = req.getParameter("p_info").trim();
				if (p_info == null || p_info.trim().length() == 0) {
					errorMsgs.add("商品描述請勿空白");
				}

				Integer p_stock = null;
				String p_stockstr = req.getParameter("p_stock");
				if (p_stockstr == null || p_stockstr.trim().length() == 0) {
					p_stock = 0;
					errorMsgs.add("商品庫存請勿空白");
				} else {
					try {
						p_stock = new Integer(req.getParameter("p_stock").trim());
					} catch (NumberFormatException e) {
						p_stock = 0;
						errorMsgs.add("商品庫存請填數字.");
					}
				}

				Integer p_stat = new Integer(req.getParameter("p_stat").trim());

				byte[] p_image = null;
				Part part = req.getPart("p_image");
				InputStream in = part.getInputStream();

				if (in.available() > 0) {
					p_image = new byte[in.available()];
					in.read(p_image);
					in.close();
				} else {
					ProService ProSvc = new ProService();
					ProVO proVO = ProSvc.getOnePro(p_id);
					p_image = proVO.getP_image();
					in.close();
				}

				String pt_id = req.getParameter("pt_id").trim();
				Integer p_sales = new Integer(req.getParameter("p_sales"));

				java.sql.Date p_add_date = java.sql.Date.valueOf(req.getParameter("p_add_date").trim());

				ProVO proVO = new ProVO();
				proVO.setP_id(p_id);
				proVO.setPt_id(pt_id);
				proVO.setP_name(p_name);
				proVO.setP_price(p_price);
				proVO.setP_image(p_image);
				proVO.setP_info(p_info);
				proVO.setP_stock(p_stock);
				proVO.setP_stat(p_stat);
				proVO.setP_add_date(p_add_date);
				proVO.setP_sales(p_sales);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proVO", proVO); // 含有輸入格式錯誤的proVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher(update_Pro_input);
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				ProService proSvc = new ProService();
				proVO = proSvc.updatePro(p_id, pt_id, p_name, p_price, p_image, p_info, p_sales, p_stock, p_add_date,
						p_stat);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("proVO", proVO); // 資料庫update成功後,正確的的proVO物件,存入req
				String url = "listOneProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(listOneProduct); // 修改成功後,轉交listOnePro.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(update_Pro_input);
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addPro.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String addPro = 		"/back-end/product/addPro.jsp";
			String listAllProduct = "/back-end/product/listAllProduct.jsp";

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String p_id = req.getParameter("p_id");
				String pt_id = req.getParameter("pt_id").trim();
				
				String p_name = req.getParameter("p_name");
				if (p_name == null || p_name.trim().length() == 0) {
					errorMsgs.add("商品名稱請勿空白");
				}

				Double p_price = null;
				String p_pricestr = req.getParameter("p_price");
				if (p_pricestr == null || (p_pricestr.trim()).length() == 0) {
					errorMsgs.add("商品價格請勿空白");
				} else {
					try {
						p_price = new Double(req.getParameter("p_price").trim());
					} catch (NumberFormatException e) {
						errorMsgs.add("商品價格請填數字.");
					}
				}

				String p_info = req.getParameter("p_info").trim();
				if (p_info == null || p_info.trim().length() == 0) {
					errorMsgs.add("商品描述請勿空白");
				}

				Integer p_stock = null;
				String p_stockstr = req.getParameter("p_stock");
				if (p_stockstr == null || p_stockstr.trim().length() == 0) {
					p_stock = 0;
					errorMsgs.add("商品庫存請勿空白");
				} else {
					try {
						p_stock = new Integer(req.getParameter("p_stock").trim());
					} catch (NumberFormatException e) {
						p_stock = 0;
						errorMsgs.add("商品庫存請填數字.");
					}
				}

				Integer p_stat = new Integer(req.getParameter("p_stat").trim());

				byte[] p_image = null;
				Part part = req.getPart("p_image");//資料
				InputStream in = part.getInputStream();//資料
				if (in.available() > 0) { //如果有資料
					p_image = new byte[in.available()];//建立跟資料一樣長度的byte陣列
					in.read(p_image);//把資料存進去
					in.close();
				} else {
					errorMsgs.add("請選擇圖片");
				}
				
//				Part filePart = req.getPart("file");
//				InputStream fileContent = filePart.getInputStream();
//				byte[] p_image = IOUtils.toByteArray(fileContent);
//				if(p_image == null) {
//				 errorMsgs.add("請選擇圖片");
//				}

				ProVO proVO = new ProVO();
				proVO.setPt_id(pt_id);
				proVO.setP_name(p_name);
				proVO.setP_price(p_price);
				proVO.setP_image(p_image);
				proVO.setP_info(p_info);
				proVO.setP_stock(p_stock);
				proVO.setP_stat(p_stat);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("proVO", proVO); // 含有輸入格式錯誤的proVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher(addPro);
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				ProService proSvc = new ProService();
				proVO = proSvc.addPro(pt_id, p_name, p_price, p_image, p_info, p_stock, p_stat);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "listAllProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(listAllProduct); // 新增成功後轉交listAllPro.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(addPro);
				failureView.forward(req, res);
			}
		}
		
		if("getAll_ByPtId".equals(action)) {
			
			List<ProVO> list = new ArrayList<ProVO>();
			
			String select_page = 			"/product/select_page.jsp";
			String listAllProductByPtId =	"/product/listAllProductByPtId.jsp";
			String back = 	"/back-end";
			String front = 	"/front-end";
			
			
			String from = req.getParameter("from");
			if ("back-end".equals(from)) {
				select_page = 			back + select_page;
				listAllProductByPtId = 	back + listAllProductByPtId;
			} else if ("front-end".equals(from)) {
				select_page = 			front + select_page;
				listAllProductByPtId = 	front + listAllProductByPtId;
			}
			
			try {
				String pt_id = req.getParameter("pt_id");
				
				ProService proSvc = new ProService();
				list = proSvc.getAllByPtId(pt_id);
				
				req.setAttribute("list",list);
				req.setAttribute("pt_id",pt_id);
				RequestDispatcher failureView = req.getRequestDispatcher(listAllProductByPtId);
				failureView.forward(req, res);
			}catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher(select_page);
				failureView.forward(req,res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllProduct.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String p_id = req.getParameter("p_id");

				/*************************** 2.開始刪除資料 ***************************************/
				ProService proSvc = new ProService();
				proSvc.deletePro(p_id);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "listAllProduct.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("listAllProduct.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
