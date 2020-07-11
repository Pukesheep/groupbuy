package com.groupbuy.model;

import java.sql.*;
import java.util.*;

public class GroupbuyService {

	private GroupbuyDAO_interface dao;
	
	public GroupbuyService() {
		dao = new GroupbuyDAO();
	}
	
	public GroupbuyVO addGroupbuy(String p_id, Timestamp start_date, Timestamp end_date, Integer grotime,
			Integer status, String reb1_no, String reb2_no, String reb3_no, Integer people, double money, Integer amount) {
		
		GroupbuyVO groupbuyVO = new GroupbuyVO();
		
		groupbuyVO.setP_id(p_id);
		groupbuyVO.setStart_date(start_date);
		groupbuyVO.setEnd_date(end_date);
		groupbuyVO.setGrotime(grotime);
		groupbuyVO.setStatus(status);
		groupbuyVO.setReb1_no(reb1_no);
		groupbuyVO.setReb2_no(reb2_no);
		groupbuyVO.setReb3_no(reb3_no);
		groupbuyVO.setPeople(people);
		groupbuyVO.setMoney(money);
		groupbuyVO.setAmount(amount);
		String generatedKey = dao.insert(groupbuyVO);
		groupbuyVO.setGro_id(generatedKey);
		
		return groupbuyVO;
	}
	
	public GroupbuyVO updateGroupbuy(String gro_id, String p_id, Timestamp start_date, Timestamp end_date, Integer grotime,
			Integer status, String reb1_no, String reb2_no, String reb3_no, Integer people, double money, Integer amount) {
		
		GroupbuyVO groupbuyVO = new GroupbuyVO();
		
		groupbuyVO.setGro_id(gro_id);
		groupbuyVO.setP_id(p_id);
		groupbuyVO.setStart_date(start_date);
		groupbuyVO.setEnd_date(end_date);
		groupbuyVO.setGrotime(grotime);
		groupbuyVO.setStatus(status);
		groupbuyVO.setReb1_no(reb1_no);
		groupbuyVO.setReb2_no(reb2_no);
		groupbuyVO.setReb3_no(reb3_no);
		groupbuyVO.setPeople(people);
		groupbuyVO.setMoney(money);
		groupbuyVO.setAmount(amount);
		dao.update(groupbuyVO);
		
		return groupbuyVO;
	}
	
	public void deleteGroupbuy(String gro_id) {
		dao.delete(gro_id);
	}
	
	public GroupbuyVO getOneGroupbuy(String gro_id) {
		return dao.findByPrimaryKey(gro_id);
	}
	
	public List<GroupbuyVO> getAll(){
		return dao.getAll();
	}
	
}
