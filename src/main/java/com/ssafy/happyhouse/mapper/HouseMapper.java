package com.ssafy.happyhouse.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;

@Mapper
public interface HouseMapper {
	/**
	 * 검색 조건(key) 검색 단어(word)에 해당하는 아파트 거래 정보(HouseInfo)를 검색해서 반환.
	 * @param bean 검색 조건과 검색 단어가 있는 객체
	 */
	public List<HouseDeal> searchAll(@Param("limit") int limit, @Param("sizePerPage") int sizePerPage, @Param("bean") HousePageBean bean) throws SQLException;
	
	/**
	 * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환.
	 * @param no 검색할 아파트 식별 번호
	 * @return 아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
	 */
	public HouseDeal search(int no) throws SQLException;

	public int getTotalCount(@Param("bean") HousePageBean bean) throws SQLException;
}
