package com.groupbuy.util;

import java.util.*;
import java.util.stream.Collectors;
import java.sql.*;
import com.groupbuy.model.*;
import com.gromem.model.*;
import com.gro_order.model.*;

public class OrderList extends TimerTask {

	@Override
	public void run() {
		
		GroupbuyService groupbuySvc = new GroupbuyService();
		GromemService gromemSvc = new GromemService();
		Gro_orderService gro_orderSvc = new Gro_orderService();
		
		// 篩選出所有達標的團購(status == 2)
		List<GroupbuyVO> list = groupbuySvc.getAll().stream()
				.filter(groupbuy -> groupbuy.getStatus() == 2)
				.collect(Collectors.toList());
		// 篩選出所有達標的團購(status == 2)
		
		for (GroupbuyVO aGroupbuy : list) {
			
			// 先取得團購相關物件
			List<GromemVO> gromemList = gromemSvc.getAllByG(aGroupbuy.getGro_id());
			
			// 存入整理完的gro_orderVO物件的list
			List<Gro_orderVO> gro_orderList = new ArrayList<Gro_orderVO>();
			
			// 接收成立訂單的自增主鍵的list
			List<String> primaryKeyList = new ArrayList<String>();
			
			// 開始設定訂單相關資訊
			Double ord_price = aGroupbuy.getMoney(); // 訂單價格
			String ordstat_id = "002"; // 待付款
			String gro_id = aGroupbuy.getGro_id(); // 團購編號
			
			for (GromemVO gromemVO : gromemList) {
				Gro_orderVO gro_orderVO = new Gro_orderVO();
				String mem_id = gromemVO.getMem_id(); // 會員編號
				gro_orderVO.setGro_id(gro_id);
				gro_orderVO.setOrdstat_id(ordstat_id);
				gro_orderVO.setOrd_price(ord_price);
				gro_orderVO.setMem_id(mem_id);
				gro_orderList.add(gro_orderVO);
			}
			
			// 存好gro_orderVO的list拿去呼叫ording方法
			// 再用前面宣告的list來接自增主鍵的字串
			primaryKeyList = gro_orderSvc.ording(gro_orderList);
			
			// 成立訂單成功後, 把groupbuyVO的狀態從達標(2)改為成立訂單(4)
			Integer status = new Integer(4);
			groupbuySvc.updateGroupbuy(aGroupbuy.getGro_id(), aGroupbuy.getP_id(), aGroupbuy.getStart_date(), aGroupbuy.getEnd_date(), 
					aGroupbuy.getGrotime(), status, aGroupbuy.getReb1_no(), aGroupbuy.getReb2_no(), aGroupbuy.getReb3_no(), 
					aGroupbuy.getPeople(), aGroupbuy.getMoney(), aGroupbuy.getAmount());
			
			// 存入自增主鍵的 list 目前還沒有要用到
		}
		
		
		
		
		
		
		
		
		
		
		
	}

}
