package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.DrugstoreInfo;
import com.ssafy.happyhouse.mapper.DrugstoreMapper;

@Service
public class DrugstoreServiceImpl implements DrugstoreService {
	
	@Autowired
	DrugstoreMapper mapper;
	
	@Override
	public List<DrugstoreInfo> searchDrugStore(String x, String y) throws Exception {
		// TODO Auto-generated method stub
		return mapper.searchDrugStore(x, y);
	}

}
