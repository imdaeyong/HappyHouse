package com.ssafy.happyhouse.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.SidoCodeDTO;

@Mapper
public interface FSelectBoxMapper {

	ArrayList<SidoCodeDTO> selectSido() throws Exception;

	ArrayList<SidoCodeDTO> selectGugun(@Param("sido") String sido) throws Exception;

	ArrayList<HouseInfo> selectDong(@Param("gugun") String gugun) throws Exception;

	ArrayList<HouseDeal> selectApt(@Param("dong") String dong) throws Exception;

}
