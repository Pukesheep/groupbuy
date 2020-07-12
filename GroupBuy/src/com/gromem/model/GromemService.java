package com.gromem.model;

import java.util.*;

public class GromemService {

	private GromemDAO_interface dao;
	
	public GromemService() {
		dao = new GromemDAO();
	}
	
	public void addGromem(String mem_id, String gro_id) {
		
		GromemVO gromemVO = new GromemVO();
		gromemVO.setMem_id(mem_id);
		gromemVO.setGro_id(gro_id);
		dao.insert(gromemVO);
	}
	
	public void deleteGromem(String mem_id, String gro_id) {
		dao.delete(mem_id, gro_id);
	}
	
	public List<GromemVO> getAllByM(String mem_id){
		return dao.findByMem_id(mem_id);
	}
	
	public List<GromemVO> getAll(){
		return dao.getAll();
	}
	
}
