package com.ssafy.happyhouse.dto;

public class UserInfo {
	private String id;
	private String pw;
	private String name;
	private String nickname;
	private String email;
	private String homepage;
	private String address;
	private String hobby;
	private String isAdmin="0";
	
	public UserInfo() {}
	public UserInfo(String id, String pw, String name, String nickname, String email, String homepage, String address,
			String hobby) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.homepage = homepage;
		this.address = address;
		this.hobby = hobby;
	}
	public UserInfo(String id, String pw, String name, String nickname, String email, String homepage, String address,
			String hobby, String isAdmin) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.homepage = homepage;
		this.address = address;
		this.hobby = hobby;
		this.isAdmin = isAdmin;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}
	
	@Override
	public String toString() {
		return "UserInfo [id=" + id + ", pw=" + pw + ", name=" + name + ", nickname=" + nickname + ", email=" + email
				+ ", homepage=" + homepage + ", address=" + address + ", hobby=" + hobby + ", isAdmin=" + isAdmin + "]";
	}
}
