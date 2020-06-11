package com.ssafy.happyhouse.service;

import java.sql.SQLException;

import com.ssafy.happyhouse.dto.UserInfo;

public interface UserInfoService {
	
	public int signUp(UserInfo dto);
	public int modify(UserInfo dto);
	
	public int delete(String id);
	
	public UserInfo findPwdById(String id);
	public UserInfo detail(String id);
}
