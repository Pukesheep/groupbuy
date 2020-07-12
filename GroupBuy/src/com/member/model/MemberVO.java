package com.member.model;

import java.sql.Date;

public class MemberVO implements java.io.Serializable {

	private static final long serialVersionUID = 8917879880210084752L;

	private String mem_id;
	private String mem_email;
	private String mem_pass;
	private String mem_name;
	private byte[] mem_icon;
	private String mem_phone;
	private String mem_addr;
	private String bank_acc;
	private String card_no;
	private String card_yy;
	private String card_mm;
	private String card_sec;
	private Integer mem_autho;
	private Integer mem_bonus;
	private java.sql.Date mem_joindat;
	private java.sql.Date mem_birth;
	private Integer mem_warn;
	
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	public String getMem_id() {
		return mem_id;
	}
	
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	
	public String getMem_email() {
		return mem_email;
	}
	
	public void setMem_pass(String mem_pass) {
		this.mem_pass = mem_pass;
	}
	
	public String getMem_pass() {
		return mem_pass;
	}
	
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	
	public String getMem_name() {
		return mem_name;
	}
	
	public void setMem_icon(byte[] mem_icon) {
		this.mem_icon = mem_icon;
	}
	
	public byte[] getMem_icon() {
		return mem_icon;
	}
	
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	
	public String getMem_phone() {
		return mem_phone;
	}
	
	public void setMem_addr(String mem_addr) {
		this.mem_addr = mem_addr;
	}
	
	public String getMem_addr() {
		return mem_addr;
	}
	
	public void setBank_acc(String bank_acc) {
		this.bank_acc = bank_acc;
	}
	
	public String getBank_acc() {
		return bank_acc;
	}
	
	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}
	
	public String getCard_no() {
		return card_no;
	}
	
	public void setCard_yy(String card_yy) {
		this.card_yy = card_yy;
	}
	
	public String getCard_yy() {
		return card_yy;
	}
	
	public void setCard_mm(String card_mm) {
		this.card_mm = card_mm;
	}
	
	public String getCard_mm() {
		return card_mm;
	}
	
	public void setCard_sec(String card_sec) {
		this.card_sec = card_sec;
	}
	
	public String getCard_sec() {
		return card_sec;
	}
	
	public void setMem_autho(Integer mem_autho) {
		this.mem_autho = mem_autho;
	}
	
	public Integer getMem_autho() {
		return mem_autho;
	}
	
	public void setMem_bonus(Integer mem_bonus) {
		this.mem_bonus = mem_bonus;
	}
	
	public Integer getMem_bonus() {
		return mem_bonus;
	}
	
	public void setMem_joindat(Date mem_joindat) {
		this.mem_joindat = mem_joindat;
	}
	
	public Date getMem_joindat() {
		return mem_joindat;
	}
	
	public void setMem_birth(Date mem_birth) {
		this.mem_birth = mem_birth;
	}
	
	public Date getMem_birth() {
		return mem_birth;
	}
	
	public void setMem_warn(Integer mem_warn) {
		this.mem_warn = mem_warn;
	}
	
	public Integer getMem_warn() {
		return mem_warn;
	}
	
}
