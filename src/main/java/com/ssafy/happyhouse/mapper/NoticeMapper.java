package com.ssafy.happyhouse.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.NoticeDto;

@Mapper
public interface NoticeMapper {

	/**
	 * 공지사항 등록
	 */
	public int registNotice(NoticeDto noticeDto);
	
	/** 공지사항 목록
	 * 
	 * @param key
	 * @param word
	 * @return
	 * @throws SQLException
	 */
	public List<NoticeDto> listNotice();
	public List<NoticeDto> searchNotice(@Param("key") String key,@Param("word") String word);
	
	/**
	 * 공지사항 상세
	 * @param noticeno
	 * @return
	 * @throws SQLException
	 */
	public NoticeDto getNotice(int noticeno);
	
	/**
	 * 공지사항 수정
	 * @param noticeDto
	 * @throws SQLException
	 */
	public int modifyNotice(NoticeDto noticeDto);
	
	/**
	 * 공지사항 삭제	 * 
	 * @param noticeno
	 * @throws SQLException
	 */
	public int deleteNotice(int noticeno);
	
}
