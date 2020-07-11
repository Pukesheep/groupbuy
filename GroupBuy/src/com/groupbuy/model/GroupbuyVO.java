package com.groupbuy.model;

import java.sql.Timestamp;

public class GroupbuyVO implements java.io.Serializable {

	private static final long serialVersionUID = 7709042651207845128L;

	private String gro_id;
	private String p_id;
	private Timestamp start_date;
	private Timestamp end_date;
	private Integer grotime;
	private String reb1_no;
	private String reb2_no;
	private String reb3_no;
	private Integer status;
	private Integer people;
	private double money;
	private Integer amount;
	
	public String getGro_id() {
		return gro_id;
	}
	public void setGro_id(String gro_id) {
		this.gro_id = gro_id;
	}
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	public Timestamp getStart_date() {
		return start_date;
	}
	public void setStart_date(Timestamp start_date) {
		this.start_date = start_date;
	}
	public Timestamp getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}
	public Integer getGrotime() {
		return grotime;
	}
	public void setGrotime(Integer grotime) {
		this.grotime = grotime;
	}
	public String getReb1_no() {
		return reb1_no;
	}
	public void setReb1_no(String reb1_no) {
		this.reb1_no = reb1_no;
	}
	public String getReb2_no() {
		return reb2_no;
	}
	public void setReb2_no(String reb2_no) {
		this.reb2_no = reb2_no;
	}
	public String getReb3_no() {
		return reb3_no;
	}
	public void setReb3_no(String reb3_no) {
		this.reb3_no = reb3_no;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getPeople() {
		return people;
	}
	public void setPeople(Integer people) {
		this.people = people;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	
}
