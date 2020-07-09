package com.rebate.model;

import java.util.*;

public interface RebateDAO_interface {

	public void insert(RebateVO rebateVO);
	public void update(RebateVO rebateVO);
	public void delete(String reb_no);
	public RebateVO findByPrimaryKey(String reb_no);
	public List<RebateVO> getAll();
//	public List<RebateVO> getAll(Map<String, String[]> map);
	
}
