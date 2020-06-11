package com.ssafy.happyhouse.service;

import java.util.ArrayList;

import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.SidoCodeDTO;

public interface FSelectBoxService {

	ArrayList<SidoCodeDTO> selectSido() throws Exception;

	ArrayList<SidoCodeDTO> selectGugun(String sido) throws Exception;

	ArrayList<HouseInfo> selectDong(String gugun) throws Exception;

	ArrayList<HouseInfo> selectApt(String dong) throws Exception;

}
