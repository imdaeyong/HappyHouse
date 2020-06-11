package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.QnA;

@Mapper
public interface QnAMapper {

	public List<QnA> selectQnA();
//	public List<QnA> searchQnA(@Param("key") String key,@Param("word") String word);
	public boolean insertQnA(QnA qna);
	public boolean updateQnA(QnA qna);
	public boolean deleteQnA(int qnaNo);
	public QnA detailQnA(int qnaNo);

}
