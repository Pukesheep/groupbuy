package com.member.model;

import java.sql.Date;

public class MemberService {

	private MemberDAO_interface dao;
	
	public MemberService() {
		dao = new MemberDAO();
	}
	
	public MemberVO addMember(String mem_email, String mem_pass, 
			String mem_name, byte[] mem_icon, String mem_phone, String mem_addr, 
			String bank_acc, String card_no, String card_yy, String card_mm, 
			String card_sec, Integer mem_autho, Integer mem_bonus, Date mem_joindat, 
			Date mem_birth, Integer mem_warn) {
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setMem_email(mem_email);
		memberVO.setMem_pass(mem_pass);
		memberVO.setMem_name(mem_name);
		memberVO.setMem_icon(mem_icon);
		memberVO.setMem_phone(mem_phone);
		memberVO.setMem_addr(mem_addr);
		memberVO.setBank_acc(bank_acc);
		memberVO.setCard_no(card_no);
		memberVO.setCard_yy(card_yy);
		memberVO.setCard_mm(card_mm);
		memberVO.setCard_sec(card_sec);
		memberVO.setMem_autho(mem_autho);
		memberVO.setMem_bonus(mem_bonus);
		memberVO.setMem_joindat(mem_joindat);
		memberVO.setMem_birth(mem_birth);
		memberVO.setMem_warn(mem_warn);
		String generatedKey = dao.insert(memberVO);
		memberVO.setMem_id(generatedKey);
		
		return memberVO;
	}
	
	public MemberVO updateMember(String mem_id, String mem_email, String mem_pass, 
			String mem_name, byte[] mem_icon, String mem_phone, String mem_addr, 
			String bank_acc, String card_no, String card_yy, String card_mm, 
			String card_sec, Integer mem_autho, Integer mem_bonus, Date mem_joindat, 
			Date mem_birth, Integer mem_warn) {
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setMem_id(mem_id);
		memberVO.setMem_email(mem_email);
		memberVO.setMem_pass(mem_pass);
		memberVO.setMem_name(mem_name);
		memberVO.setMem_icon(mem_icon);
		memberVO.setMem_phone(mem_phone);
		memberVO.setMem_addr(mem_addr);
		memberVO.setBank_acc(bank_acc);
		memberVO.setCard_no(card_no);
		memberVO.setCard_yy(card_yy);
		memberVO.setCard_mm(card_mm);
		memberVO.setCard_sec(card_sec);
		memberVO.setMem_autho(mem_autho);
		memberVO.setMem_bonus(mem_bonus);
		memberVO.setMem_joindat(mem_joindat);
		memberVO.setMem_birth(mem_birth);
		memberVO.setMem_warn(mem_warn);
		dao.update(memberVO);
		
		return memberVO;
	}
	
	public void deleteMember(String mem_id) {
		dao.delete(mem_id);
	}
	
	public MemberVO getOneMember(String mem_id) {
		return dao.findByPrimaryKey(mem_id);
	}
	
	public java.util.List<MemberVO> getAll() {
		return dao.getAll();
	}
	
	public java.util.List<MemberVO> getAll(java.util.Map<String, String[]> map){
		return dao.getAll(map);
	}
	
	public MemberVO loginByEmail(String mem_email) {
		
		String mem_id = dao.loginByEmail(mem_email);
		return dao.findByPrimaryKey(mem_id);
	}
	
	public MemberVO signUp(String mem_name, String mem_email, String mem_pass, Integer mem_autho) {
		
		MemberVO memberVO = new MemberVO();
		memberVO.setMem_name(mem_name);
		memberVO.setMem_email(mem_email);
		memberVO.setMem_pass(mem_pass);
		memberVO.setMem_autho(mem_autho);
		String generatedKey = dao.signUp(memberVO);
		memberVO.setMem_id(generatedKey);
		
		return memberVO;
	}
	
}
