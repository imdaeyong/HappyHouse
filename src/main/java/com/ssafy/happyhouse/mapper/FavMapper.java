package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.SidoCodeDTO;

@Mapper
public interface FavMapper {


	public List<SidoCodeDTO> sidolist();

	
}
