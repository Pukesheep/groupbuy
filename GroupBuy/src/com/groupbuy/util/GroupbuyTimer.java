package com.groupbuy.util;

import java.io.IOException;
import java.util.Timer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GroupbuyTimer")
public class GroupbuyTimer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static Timer timer;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
	}
	
	public void init() {
		System.out.println("GroupbuyTimer is loaded.");
		
		timer = new Timer();
		Undeploy undeploy = new Undeploy();
		OrderList orderlist = new OrderList();
		
		// 檢查上架團購的時間, 計算並且判斷人數對應折扣後修改團購狀態, 30秒執行一次
		timer.schedule(undeploy, 0, 30 * 1000);
		// 查詢進入達標狀態的團購, 產生訂單, 5分鐘執行一次
//		timer.schedule(orderlist, 0, 5 * 60 * 1000);
		timer.schedule(orderlist, 0, 30 * 1000);
		
	}
	
	public void destroy() {
		System.out.println("GroupbuyTimer is destroyed.");
		timer.cancel();
	}

}
