package com.ssafy.happyhouse.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.CommInfo;
import com.ssafy.happyhouse.dto.EnvInfo;

@Mapper
public interface CommMapper {
	/**
	 * key값으로 법정동명을 입력받으면 상가 정보(CommInfo)를 검색해서 반환.
	 * @param 동이름
	 * @return 상가정보
	 */
	public List<CommInfo> searchDong(@Param("dong") String dong) throws SQLException;

	/**
	 * 업종 코드를 입력 받으면 해당하는 상점 출력. code1 ~ code3까지 호환
	 * @param 업종코드
	 * @return 상가정보
	 */
	public List<CommInfo> searchClass(@Param("code") String code) throws SQLException;
	
	public List<EnvInfo> searchEnv(@Param("dong") String dong) throws SQLException;
}
