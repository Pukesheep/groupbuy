package com.gro_order.model;

import java.util.*;

public interface Gro_orderDAO_interface {
	
	public String insert(Gro_orderVO gro_orderVO);
	public void update(Gro_orderVO gro_orderVO);
	public void delete(String ord_id);
	public Gro_orderVO findByPrimaryKey(String ord_id);
	public List<Gro_orderVO> getAll();
	public List<Gro_orderVO> findByMem_id(String mem_id);
	public List<Gro_orderVO> findByGro_id(String gro_id);

}
