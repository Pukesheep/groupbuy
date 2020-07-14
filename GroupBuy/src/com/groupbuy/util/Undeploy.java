package com.groupbuy.util;

import java.util.*;
import java.util.stream.Collectors;
import java.sql.*;
import com.groupbuy.model.*;
import com.gromem.model.*;
import com.rebate.model.*;
import com.product.model.*;

public class Undeploy extends TimerTask {

	@Override
	public void run() {
		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		
		GroupbuyService groupbuySvc = new GroupbuyService();
		GromemService gromemSvc = new GromemService();
		RebateService rebateSvc = new RebateService();
		ProService proSvc = new ProService();
		
		// 篩選出所有上架團購(status == 1), 以及已經截止的團購案(end_date.before(now))
		List<GroupbuyVO> list = groupbuySvc.getAll().stream()
				.filter(groupbuy -> groupbuy.getStatus() == 1)
				.filter(groupbuy -> groupbuy.getEnd_date().before(now))
				.collect(Collectors.toList());
		// 篩選出所有上架團購(status == 1), 而且是已經截止的團購案(end_date.before(now))
		
		for (GroupbuyVO aGroupbuy : list) {
			
			// 先取得團購相關物件
			ProVO proVO = proSvc.getOnePro(aGroupbuy.getP_id());
			RebateVO reb1 = rebateSvc.getOneRebate(aGroupbuy.getReb1_no());
			RebateVO reb2 = rebateSvc.getOneRebate(aGroupbuy.getReb2_no());
			RebateVO reb3 = rebateSvc.getOneRebate(aGroupbuy.getReb3_no());
			// 先取得團購相關物件
			
			// 取得價格以及折扣
			Double discount1 = new Double(reb1.getDiscount());
			Double discount2 = new Double(reb2.getDiscount());
			Double discount3 = new Double(reb3.getDiscount());
			Double p_price = new Double(proVO.getP_price());
			// 取得價格以及折扣
			
			// 取得人數
			Integer level1 = new Integer(reb1.getPeople());
			Integer level2 = new Integer(reb2.getPeople());
			Integer level3 = new Integer(reb3.getPeople());
			Long peopleLong = gromemSvc.getAllByG(aGroupbuy.getGro_id()).stream()
					.collect(Collectors.counting());
			int people = peopleLong.intValue();
			// 取得人數
			
			// 預設狀態為2(達標)
			Integer status = new Integer(2);
			
			// 計算人數抵達哪一個折扣門檻
			
			Double money = p_price;
			
			if (people >= level3) {
				money = new Double(p_price * discount3);
				
			} else if (people >= level2) {
				money = new Double(p_price * discount2);
				
			} else if (people >= level1) {
				money = new Double(p_price * discount1);
				
			} else {
				// 人數未超過任一門檻, 狀態設定為3(未達標)
				status = new Integer(3);
				groupbuySvc.updateGroupbuy(aGroupbuy.getGro_id(), aGroupbuy.getP_id(), aGroupbuy.getStart_date(), aGroupbuy.getEnd_date(), aGroupbuy.getGrotime(), status, 
						aGroupbuy.getReb1_no(), aGroupbuy.getReb2_no(), aGroupbuy.getReb3_no(), people, money, aGroupbuy.getAmount());
			}
			// 計算人數抵達哪一個折扣門檻
			
			groupbuySvc.updateGroupbuy(aGroupbuy.getGro_id(), aGroupbuy.getP_id(), aGroupbuy.getStart_date(), 
					aGroupbuy.getEnd_date(), aGroupbuy.getGrotime(), status, aGroupbuy.getReb1_no(), aGroupbuy.getReb2_no(), aGroupbuy.getReb3_no(), 
					people, money, aGroupbuy.getAmount());
			
		}
		
	}

}
