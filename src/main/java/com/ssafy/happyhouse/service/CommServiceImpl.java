package com.ssafy.happyhouse.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.HappyHouseException;
import com.ssafy.happyhouse.PageNavigation;
import com.ssafy.happyhouse.dto.CommInfo;
import com.ssafy.happyhouse.dto.EnvInfo;
import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.mapper.CommMapper;

@Service
public class CommServiceImpl implements CommService{

	@Autowired
	CommMapper mapper;
	

	@Override
	public List<CommInfo> searchDong(String dong) throws SQLException {
		return mapper.searchDong(dong);
	}

	@Override
	public List<CommInfo> searchClass(String code) throws SQLException {
		return mapper.searchClass(code);
	}

	@Override
	public List<EnvInfo> searchEnv(String dong) throws SQLException {
		return mapper.searchEnv(dong);
	}

}




