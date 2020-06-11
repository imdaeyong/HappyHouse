package com.ssafy.happyhouse.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.CommInfo;
import com.ssafy.happyhouse.dto.EnvInfo;
public interface CommService {
	
	public List<CommInfo> searchDong(String dong) throws SQLException;

	/**
	 * 업종 코드를 입력 받으면 해당하는 상점 출력. code1 ~ code3까지 호환
	 * @param 업종코드
	 * @return 상가정보
	 */
	public List<CommInfo> searchClass(String code) throws SQLException;
	
	public List<EnvInfo> searchEnv(@Param("dong") String dong) throws SQLException;
}
