package com.ssafy.happyhouse.service;



import java.util.List;

import com.ssafy.happyhouse.dto.NoticeDto;


public interface NoticeService {

	public int registNotice(NoticeDto noticeDto);
	public List<NoticeDto> listNotice();
	public List<NoticeDto> searchNotice(String key, String word);
	
	public NoticeDto getNotice(int noticeno);
	public int modifyNotice(NoticeDto noticeDto);
	public int deleteNotice(int noticeno);
	
}
