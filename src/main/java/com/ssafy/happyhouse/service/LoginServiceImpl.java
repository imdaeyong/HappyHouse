package com.ssafy.happyhouse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.UserInfo;
import com.ssafy.happyhouse.mapper.UserMapper;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	UserMapper mapper;
	
	@Override
	public UserInfo login(String userid, String userpwd){
		if(userid == null || userpwd == null)
			return null;
		return mapper.login(userid, userpwd);
	}
	
}
