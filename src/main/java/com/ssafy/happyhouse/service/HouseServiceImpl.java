package com.ssafy.happyhouse.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.HappyHouseException;
import com.ssafy.happyhouse.PageNavigation;
import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.mapper.HouseMapper;

@Service
public class HouseServiceImpl implements HouseService{

	@Autowired
	HouseMapper mapper;
	
	/**
	 * 검색 조건(key) 검색 단어(word)에 해당하는 아파트 거래 정보(HouseInfo)를  검색해서 반환.  
	 * @param bean  검색 조건과 검색 단어가 있는 객체
	 * @return 조회한 식품 목록
	 */
	public List<HouseDeal> searchAll(int currentPage, int sizePerPage, HousePageBean bean){
		try {
			boolean[] types = bean.getSearchType();
			int cnt = 0;
			for(boolean t : types) {
				if(t) {
					cnt++;
				}
			}
			if(cnt == 0) {
				throw new HappyHouseException("주택타입은 반드시 한 개 이상을 선택해야합니다.");
			}
			int limit = (currentPage-1)*sizePerPage;
			return mapper.searchAll(limit, sizePerPage, bean);
		} catch(SQLException e) {
			throw new HappyHouseException("주택 정보 조회 중 오류 발생!");
		}
	}
	
	/**
	 * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환. 
	 * @param no	검색할 아파트 식별 번호
	 * @return		아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
	 */
	public HouseDeal search(int no) {
		try {
			HouseDeal deal = mapper.search(no);
			if(deal == null) {
				throw new HappyHouseException(String.format("거래번호 %d번에 해당하는 주택거래 정보가 존재하지 않습니다.", no));
			}
			return deal;
		} catch(SQLException e) {
			throw new HappyHouseException("주택 정보 조회 중 오류 발생!");
		}
	}
	@Override
	public PageNavigation makePageNavigation(int currentPage, int sizePerPage, HousePageBean bean) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
		int naviSize = 10; //페이지 개수(1,2,3,4,5,6,7,8,9..)
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		int totalCount = mapper.getTotalCount(bean);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount-1)/sizePerPage + 1; //총 페이지 수
		pageNavigation.setTotalPageCount(totalPageCount);
		boolean startRange = currentPage <=naviSize; //true이면 이전을 누를수 없음.
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalPageCount - 1)/naviSize * naviSize < currentPage; //true이면 다음을 누를수 없음.
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		return pageNavigation;
	}

}




