package com.ssafy.happyhouse.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.SidoCodeDTO;
import com.ssafy.happyhouse.mapper.FSelectBoxMapper;

@Service
public class FSelectBoxServiceImpl implements FSelectBoxService {

	@Autowired
	FSelectBoxMapper mapper;

	@Override
	public ArrayList<SidoCodeDTO> selectSido() throws Exception {
		ArrayList<SidoCodeDTO> list = mapper.selectSido();
		return list;
	}

	@Override
	public ArrayList<SidoCodeDTO> selectGugun(String sido) throws Exception {
		ArrayList<SidoCodeDTO> list = mapper.selectGugun(sido);
		return list;
	}

	@Override
	public ArrayList<HouseInfo> selectDong(String gugun) throws Exception {
		ArrayList<HouseInfo> list = mapper.selectDong(gugun);
		return list;
	}

	@Override
	public ArrayList<HouseDeal> selectApt(String dong) throws Exception {
		ArrayList<HouseDeal> list = mapper.selectApt(dong);
		return list;
	}

}
