package com.rebate.model;

import java.util.*;

public class RebateService {

	private RebateDAO_interface dao;
	
	public RebateService() {
		dao = new RebateDAO();
	}
	
	public RebateVO addRebate(Double discount, Integer people) {
		
		RebateVO rebateVO = new RebateVO();
		
		rebateVO.setDiscount(discount);
		rebateVO.setPeople(people);
		dao.insert(rebateVO);
		
		return rebateVO;
	}
	
	public RebateVO updateRebate(String reb_no, Double discount, Integer people) {
		
		RebateVO rebateVO = new RebateVO();
		
		rebateVO.setReb_no(reb_no);
		rebateVO.setDiscount(discount);
		rebateVO.setPeople(people);
		
		return rebateVO;
	}
	
	public void deleteRebate(String reb_no) {
		dao.delete(reb_no);
	}
	
	public RebateVO getOneRebate(String reb_no) {
		return dao.findByPrimaryKey(reb_no);
	}
	
	public List<RebateVO> getAll(){
		return dao.getAll();
	}
	
}
