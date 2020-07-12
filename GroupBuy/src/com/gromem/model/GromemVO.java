package com.gromem.model;

import java.io.*;

public class GromemVO implements Serializable {

	private static final long serialVersionUID = 1735113453803184299L;
	
	private String mem_id;
	private String gro_id;
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getGro_id() {
		return gro_id;
	}
	public void setGro_id(String gro_id) {
		this.gro_id = gro_id;
	}
	
}
