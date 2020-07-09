package com.rebate.model;

import java.io.*;

public class RebateVO implements Serializable {

	private static final long serialVersionUID = 2951005854674310194L;

	private String reb_no;
	private Double discount;
	private Integer people;
	
	public String getReb_no() {
		return reb_no;
	}
	public void setReb_no(String reb_no) {
		this.reb_no = reb_no;
	}
	public Double getDiscount() {
		return discount;
	}
	public void setDiscount(Double discount) {
		this.discount = discount;
	}
	public Integer getPeople() {
		return people;
	}
	public void setPeople(Integer people) {
		this.people = people;
	}
	
	
	
}
