package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.QnA;

public interface QnAService {
	List<QnA> retrieveQnA();
//	List<QnA> searchQnA(String key, String word);
	boolean insertQnA(QnA qna);
	boolean updateQnA(QnA qna);
	boolean deleteQnA(int qnaNo);
	QnA detailQnA(int qnaNo);
}
