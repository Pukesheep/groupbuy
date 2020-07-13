package com.ordstat.model;

import java.util.List;

public class OrdstatService {
	
	private OrdstatDAO_interface dao;	
	
	public OrdstatService() {
		dao = new OrdstatDAO();
	}
	
	//新增
	public OrdstatVO addOrdstat(String ordstat) {
		
		OrdstatVO ordstatVO = new OrdstatVO();
		
		ordstatVO.setOrdstat(ordstat);
		
		dao.insert(ordstatVO);
		
		return ordstatVO;
	}
	
	//修改
	public OrdstatVO updateOrdstat(String ordstat_id,String ordstat) {
		OrdstatVO ordstatVO = new OrdstatVO();
		ordstatVO.setOrdstat_id(ordstat_id);
		ordstatVO.setOrdstat(ordstat);
		
		dao.update(ordstatVO);
		
		return ordstatVO;	
	}
	
	//查詢一個狀態
	public OrdstatVO listOneOrdstat(String ordstat_id) {
		return dao.listOneOrdstat(ordstat_id);
	}
	
	//查詢全部狀態
	public List<OrdstatVO> getAll(){
		return dao.getAll();
	}
	

	

}
