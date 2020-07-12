package com.member.model;

import java.util.*;

public interface MemberDAO_interface {

	public String insert(MemberVO memberVO);
	public void update(MemberVO memberVO);
//	public void updateBonus( String mem_id, Integer mem_bonus);
	public void delete(String mem_id);
	public MemberVO findByPrimaryKey(String mem_id);
	public java.util.List<MemberVO> getAll();
	public java.util.List<MemberVO> getAll(Map<String, String[]> map);
	public String loginByEmail(String mem_email);
	public String signUp(MemberVO memberVO);
}
