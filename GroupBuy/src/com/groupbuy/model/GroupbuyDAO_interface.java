package com.groupbuy.model;

import java.util.*;

public interface GroupbuyDAO_interface {

	public String insert(GroupbuyVO groupbuyVO);
	public void update(GroupbuyVO groupbuyVO);
	public void delete(String gro_id);
	public GroupbuyVO findByPrimaryKey(String gro_id);
	public List<GroupbuyVO> getAll();
//	public List<GroupbuyVO> getAll(Map<String, String[]> map);
	
}
