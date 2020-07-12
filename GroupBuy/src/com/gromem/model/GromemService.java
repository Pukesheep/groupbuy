package com.gromem.model;

import java.util.*;
import com.groupbuy.model.*;

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
	
	public void join(GromemVO gromemVO, Integer people) {
		dao.join(gromemVO, people);
	}
	
	public void quit(GromemVO gromemVO, Integer people) {
		dao.quit(gromemVO, people);
	}
	
	public GromemVO getOneGromem(String mem_id, String gro_id) {
		return dao.findByCompositeKey(mem_id, gro_id);
	}
	
}
