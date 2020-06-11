package com.ssafy.happyhouse.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.UserInfo;
import com.ssafy.happyhouse.mapper.UserMapper;

@Service
public class UserInfoServiceImpl implements UserInfoService {
	
	@Autowired
	UserMapper mapper;

	@Override
	public int signUp(UserInfo user) {
		return mapper.signUp(user);
	}

	@Override
	public int modify(UserInfo dto) {
		return mapper.modify(dto);
	}

	@Override
	public int delete(String id) {
		return mapper.delete(id);
	}
	
	@Override
	public UserInfo detail(String id) {
		return mapper.detail(id);
	}

	@Override
	public UserInfo findPwdById(String id) {
		return mapper.findPwdById(id);
	}
	

}
