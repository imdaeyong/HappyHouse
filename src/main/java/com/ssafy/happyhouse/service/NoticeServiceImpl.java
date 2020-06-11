package com.ssafy.happyhouse.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeMapper mapper;

	@Override
	public int registNotice(NoticeDto noticeDto) {
		return mapper.registNotice(noticeDto);
	}

	@Override
	public List<NoticeDto> listNotice() {
		return mapper.listNotice();
	}
	
	@Override
	public List<NoticeDto> searchNotice(String key, String word) {
		key = key == null ? "" : key;
		word = word == null ? "" : word;
		return mapper.searchNotice(key, word);
	}

	@Override
	public NoticeDto getNotice(int noticeno){
		return mapper.getNotice(noticeno);
	}

	@Override
	public int modifyNotice(NoticeDto noticeDto){
		return mapper.modifyNotice(noticeDto);
	}

	@Override
	public int deleteNotice(int noticeno) {
		return mapper.deleteNotice(noticeno);
	}
	

}
