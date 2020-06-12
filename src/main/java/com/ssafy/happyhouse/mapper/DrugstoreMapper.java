package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.DrugstoreInfo;

@Mapper
public interface DrugstoreMapper {

	List<DrugstoreInfo> searchDrugStore(@Param("lat") String lat,@Param("lon") String lon) throws Exception;


}
