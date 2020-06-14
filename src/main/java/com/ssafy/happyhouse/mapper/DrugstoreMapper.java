package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.DrugstoreInfo;

@Mapper
public interface DrugstoreMapper {

	List<DrugstoreInfo> searchDrugStore(@Param("x") String x,@Param("y") String y) throws Exception;


}
