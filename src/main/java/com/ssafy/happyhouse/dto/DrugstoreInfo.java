package com.ssafy.happyhouse.dto;

public class DrugstoreInfo {
	private String id;
	private String drugstoreName;
	private String drugstoreAddress;
	private String X;
	private String Y;
	private String phoneNum;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDrugstoreName() {
		return drugstoreName;
	}
	public void setDrugstoreName(String drugstoreName) {
		this.drugstoreName = drugstoreName;
	}
	public String getDrugstoreAddress() {
		return drugstoreAddress;
	}
	public void setDrugstoreAddress(String drugstoreAddress) {
		this.drugstoreAddress = drugstoreAddress;
	}
	public String getX() {
		return X;
	}
	public void setX(String x) {
		X = x;
	}
	public String getY() {
		return Y;
	}
	public void setY(String y) {
		Y = y;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	@Override
	public String toString() {
		return "DrugstoreInfo [id=" + id + ", drugstoreName=" + drugstoreName + ", drugstoreAddress=" + drugstoreAddress
				+ ", X=" + X + ", Y=" + Y + ", phoneNum=" + phoneNum + "]";
	}

	
	
}
