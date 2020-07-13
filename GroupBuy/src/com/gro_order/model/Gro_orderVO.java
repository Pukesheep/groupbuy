package com.gro_order.model;

import java.io.*;
import java.sql.*;

public class Gro_orderVO implements Serializable {

	private static final long serialVersionUID = -2253671985885788436L;
	
	private String ord_id;
	private String gro_id;
	private String mem_id;
	private String ordstat_id;
	private Integer ord_price;
	private Timestamp ord_date;
	private String receive_name;
	private String address;
	private String phone;
	
	public String getOrd_id() {
		return ord_id;
	}
	public void setOrd_id(String ord_id) {
		this.ord_id = ord_id;
	}
	public String getGro_id() {
		return gro_id;
	}
	public void setGro_id(String gro_id) {
		this.gro_id = gro_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getOrdstat_id() {
		return ordstat_id;
	}
	public void setOrdstat_id(String ordstat_id) {
		this.ordstat_id = ordstat_id;
	}
	public Integer getOrd_price() {
		return ord_price;
	}
	public void setOrd_price(Integer ord_price) {
		this.ord_price = ord_price;
	}
	public Timestamp getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(Timestamp ord_date) {
		this.ord_date = ord_date;
	}
	public String getReceive_name() {
		return receive_name;
	}
	public void setReceive_name(String receive_name) {
		this.receive_name = receive_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
