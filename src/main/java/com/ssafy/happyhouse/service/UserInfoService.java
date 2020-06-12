package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.FavInfo;
import com.ssafy.happyhouse.dto.UserInfo;

public interface UserInfoService {
	
	public int signUp(UserInfo dto);
	public int modify(UserInfo dto);
	
	public int delete(String id);
	
	public UserInfo findPwdById(String id);
	public UserInfo detail(String id);
	public int registFav(FavInfo favInfo);
	public List<FavInfo> userFavList(String id);
}
