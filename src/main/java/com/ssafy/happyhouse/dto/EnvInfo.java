package com.ssafy.happyhouse.dto;

/**
 * 
 * Table: envinfo
 * 
 * Columns: 
 * name 		varchar(30) 
 * bizcode 		int 
 * address 		varchar(70) 
 * dongcode 	int 
 * dong			varchar(5)
 *
 */

public class EnvInfo {
	private String name;
	private int bizcode;
	private String address;
	private int dongCode;
	private String dong;

	public EnvInfo() {
		super();
	}

	public EnvInfo(String name, int bizcode, String address, int dongCode, String dong) {
		super();
		this.name = name;
		this.bizcode = bizcode;
		this.address = address;
		this.dongCode = dongCode;
		this.dong = dong;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getBizcode() {
		return bizcode;
	}

	public void setBizcode(int bizcode) {
		this.bizcode = bizcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getDongCode() {
		return dongCode;
	}

	public void setDongCode(int dongCode) {
		this.dongCode = dongCode;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	@Override
	public String toString() {
		return "EnvInfo [name=" + name + ", bizcode=" + bizcode + ", address=" + address + ", dongCode=" + dongCode
				+ ", dong=" + dong + "]";
	}
}
