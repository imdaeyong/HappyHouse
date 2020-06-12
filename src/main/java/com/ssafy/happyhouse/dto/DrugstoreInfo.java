package com.ssafy.happyhouse.dto;

public class DrugstoreInfo {
	private String id;
	private String drugstoreName;
	private String drugstoreAddress;
	private String lng;
	private String lat;
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
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
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
				+ ", lng=" + lng + ", lat=" + lat + ", phoneNum=" + phoneNum + "]";
	}
	
	
}
