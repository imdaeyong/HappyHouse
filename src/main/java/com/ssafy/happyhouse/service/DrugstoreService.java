package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.DrugstoreInfo;

public interface DrugstoreService {

	List<DrugstoreInfo> searchDrugStore(String lat, String lon) throws Exception;


}
