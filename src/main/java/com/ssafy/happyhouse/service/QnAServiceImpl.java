package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.QnA;
import com.ssafy.happyhouse.mapper.QnAMapper;

@Service
public class QnAServiceImpl implements QnAService {
	
	@Autowired
	QnAMapper mapper;
	
	@Override
	public List<QnA> retrieveQnA() {
		return mapper.selectQnA();
	}

//	@Override
//	public List<QnA> searchQnA(String key, String word) {
//		key = key == null ? "" : key;
//		word = word == null ? "" : word;
//		return mapper.searchQnA(key, word);
//	}

	@Override
	public boolean insertQnA(QnA qna) {
		return mapper.insertQnA(qna);
	}

	@Override
	public boolean updateQnA(QnA qna) {
		return mapper.updateQnA(qna);
	}

	@Override
	public boolean deleteQnA(int qnaNo) {
		return mapper.deleteQnA(qnaNo);
	}

	@Override
	public QnA detailQnA(int qnaNo) {
		return mapper.detailQnA(qnaNo);
	}

}
