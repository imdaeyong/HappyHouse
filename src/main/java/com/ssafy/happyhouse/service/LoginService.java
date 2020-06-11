package com.ssafy.happyhouse.service;

import com.ssafy.happyhouse.dto.UserInfo;

public interface LoginService {

	public UserInfo login(String userid, String userpwd);
	
}
