package com.product.model;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

public class ProService {

	private ProDAO_interface dao;

	public ProService() {
		dao = new ProDAO();
	}

	public ProVO addPro(String pt_id, String p_name, Double p_price, byte[] p_image, String p_info,Integer p_stock,
			Integer p_stat) {

		ProVO proVO = new ProVO();
		
		proVO.setPt_id(pt_id);
		proVO.setP_name(p_name);
		proVO.setP_price(p_price);
		proVO.setP_image(p_image);
		proVO.setP_info(p_info);
		proVO.setP_stock(p_stock);
		proVO.setP_stat(p_stat);
		dao.insert(proVO);

		return proVO;

	}

	public ProVO updatePro(String p_id, String pt_id, String p_name, Double p_price, byte[] p_image, String p_info, Integer p_sales,
			Integer p_stock, java.sql.Date p_add_date, Integer p_stat) {

		ProVO proVO = new ProVO();
		
		proVO.setP_id(p_id);
		proVO.setPt_id(pt_id);
		proVO.setP_name(p_name);
		proVO.setP_price(p_price);
		proVO.setP_image(p_image);
		proVO.setP_info(p_info);
		proVO.setP_sales(p_sales);
		proVO.setP_stock(p_stock);
		proVO.setP_add_date(p_add_date);
		proVO.setP_stat(p_stat);
		dao.update(proVO);

		return proVO;

	}
	
	public void deletePro(String p_id) {
		dao.delete(p_id);
	}
	
	public ProVO getOnePro(String p_id) {
		return dao.findByPrimaryKey(p_id);
	}
	
	public List<ProVO> getAllByPtId(String pt_id){
		return dao.findByPtId(pt_id);
	}

	public List<ProVO> getAll(){
		return dao.getAll();
	}
	
	public List<ProVO> getAllFront(){
		List<ProVO> list =dao.getAll().stream()
		.filter(p ->p.getP_stat().equals(1))
		.collect(Collectors.toList());
		
		return list;
	}
}
