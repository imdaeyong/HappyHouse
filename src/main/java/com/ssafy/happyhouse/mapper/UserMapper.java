package com.ssafy.happyhouse.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.UserInfo;

@Mapper
public interface UserMapper {

	/**
	 * 로그인
	 * 
	 * @param id,pw // 아이디, 비밀번호 입력받음
	 * @return UserInfo 리턴
	 */
	public UserInfo login(@Param("id") String id, @Param("pw") String pw);

	/**
	 * 회원가입
	 * 
	 * @param UserInfo //회원정보 입력 후 가입
	 * @return 성공/실패
	 */

	public int signUp(UserInfo user);

	/**
	 * 정보수정
	 * 
	 * @param UserInfo,id // 현재 사용자의 id로 userinfo를 가져와서 수정
	 * @return 성공/실패
	 */

	public int modify(UserInfo user);

	/**
	 * 정보삭제
	 * 
	 * @param id // 현재 사용자 정보 삭제
	 * @return
	 * @throws SQLException
	 */

	public int delete(String id);

	/**
	 * 아이디로 비밀번호 찾기
	 * 
	 * @param id //id를 주면 비밀번호 찾아줌
	 */

	public UserInfo findPwdById(String id);
	public UserInfo detail(String id);

	/********************* 관심지역 ***************/
	/*	
	*//**
		 * 관심지역 저장
		 * 
		 * @param user_no, dong // 현재 사용자에게 관심지역(동) 추가
		 */
	/*
	 * public int favInsert(int user_no, String dong);
	 * 
	 *//**
		 * 관심지역 출력
		 * 
		 * @param user_no //현재 사용자의 관심지역들 출력
		 */
	/*
	 * public List<String> favList(int user_no);
	 * 
	 *//**
		 * 관심지역 삭제
		 * 
		 * @param user_no,dong / 현재 동 관심지역 삭제
		 *//*
			 * public int favDelete(int user_no, String dong);
			 */

}
