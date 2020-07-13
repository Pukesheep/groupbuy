package com.gro_order.model;

import java.sql.*;
import java.util.*;
import java.sql.*;

public class Gro_orderServier {

	private Gro_orderDAO_interface dao;
	
	public Gro_orderServier() {
		dao = new Gro_orderDAO();
	}
	
	public Gro_orderVO addGro_order(String gro_id, String mem_id, String ordstat_id, Timestamp ord_date) {
		
		Gro_orderVO gro_orderVO = new Gro_orderVO();
		
		gro_orderVO.setGro_id(gro_id);
		gro_orderVO.setMem_id(mem_id);
		gro_orderVO.setOrdstat_id(ordstat_id);
		gro_orderVO.setOrd_date(ord_date);
		String generatedKey = dao.insert(gro_orderVO);
		gro_orderVO.setOrd_id(generatedKey);
		
		return gro_orderVO;
	}
	
	public Gro_orderVO updateGro_order(String ord_id,String gro_id, String mem_id, String ordstat_id, Timestamp ord_date) {
		
		Gro_orderVO gro_orderVO = new Gro_orderVO();
		
		gro_orderVO.setOrd_id(ord_id);
		gro_orderVO.setGro_id(gro_id);
		gro_orderVO.setMem_id(mem_id);
		gro_orderVO.setOrdstat_id(ordstat_id);
		gro_orderVO.setOrd_date(ord_date);
		dao.update(gro_orderVO);
		
		return gro_orderVO;
	}
	
	public void deleteGro_order(String ord_id) {
		dao.delete(ord_id);
	}
	
	public Gro_orderVO getOneGro_order(String ord_id) {
		return dao.findByPrimaryKey(ord_id);
	}
	
	public List<Gro_orderVO> getAll(){
		return dao.getAll();
	}
	
	public List<Gro_orderVO> getAllByMem_id(String mem_id){
		return dao.findByMem_id(mem_id);
	}
	
	public List<Gro_orderVO> getAllByGro_id(String gro_id){
		return dao.findByGro_id(gro_id);
	}
	
}
