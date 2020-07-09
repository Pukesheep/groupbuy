package com.product.model;
import java.sql.Date;

public class ProVO implements java.io.Serializable{
	private String p_id;
	private String pt_id;
	private String p_name;
	private Double p_price;
	private byte[] p_image;
	private String p_info;
	private Integer p_sales;
	private Integer p_stock;
	private Date p_add_date;
	private Integer p_stat;
	
	public ProVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	public String getPt_id() {
		return pt_id;
	}
	public void setPt_id(String pt_id) {
		this.pt_id = pt_id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public Double getP_price() {
		return p_price;
	}
	public void setP_price(Double p_price) {
		this.p_price = p_price;
	}
	public byte[] getP_image() {
		return p_image;
	}
	public void setP_image(byte[] p_image) {
		this.p_image = p_image;
	}
	public String getP_info() {
		return p_info;
	}
	public void setP_info(String p_info) {
		this.p_info = p_info;
	}
	public Integer getP_sales() {
		return p_sales;
	}
	public void setP_sales(Integer p_sales) {
		this.p_sales = p_sales;
	}
	public Integer getP_stock() {
		return p_stock;
	}
	public void setP_stock(Integer p_stock) {
		this.p_stock = p_stock;
	}
	public Date getP_add_date() {
		return p_add_date;
	}
	public void setP_add_date(Date p_add_date) {
		this.p_add_date = p_add_date;
	}
	public Integer getP_stat() {
		return p_stat;
	}
	public void setP_stat(Integer p_stat) {
		this.p_stat = p_stat;
	}
}
