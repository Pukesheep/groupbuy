package com.product.model;

import java.util.*;

public interface ProDAO_interface {
		public void insert(ProVO proVO);
		public void update(ProVO proVO);
		public void delete(String p_id);
		public ProVO findByPrimaryKey(String p_id );
		public List<ProVO> getAll();
//		public List<ProVO> getAllFront();
		public List<ProVO> findByPtId(String pt_id);
}
