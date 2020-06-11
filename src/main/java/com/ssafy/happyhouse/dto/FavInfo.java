package com.ssafy.happyhouse.dto;

public class FavInfo {
	private String id;
	private String dongName;
	private String dongCode;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDongName() {
		return dongName;
	}
	public void setDongName(String dongName) {
		this.dongName = dongName;
	}
	public String getDongCode() {
		return dongCode;
	}
	public void setDongCode(String dongCode) {
		this.dongCode = dongCode;
	}
	@Override
	public String toString() {
		return "FavInfo [id=" + id + ", dongName=" + dongName + ", dongCode=" + dongCode + "]";
	}
}
