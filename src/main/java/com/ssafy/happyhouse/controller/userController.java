package com.ssafy.happyhouse.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonValue;
import com.ssafy.happyhouse.dto.FavInfo;
import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.dto.UserInfo;
import com.ssafy.happyhouse.service.UserInfoService;



@RestController
public class userController {
	@Autowired
	UserInfoService userInfoService;
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/errorHandler");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	@PostMapping(value="/signUp")
	public int insert(UserInfo dto) {
		return userInfoService.signUp(dto);
	}
	
	@GetMapping(value="/findPwdById/{id}")
	public UserInfo findPwdById(@PathVariable String id) {
		return userInfoService.findPwdById(id);
	}
	
	@PutMapping(value="/modifyUser")
	public int modifyUser(UserInfo dto) {
		System.out.println("adasa");
		return userInfoService.modify(dto);
	}
	
	@GetMapping(value="/detailUser/{id}")
	public UserInfo detailUser(@PathVariable String id) {
		return userInfoService.detail(id);
	}
	@PutMapping(value="/deleteUser/{id}")
	public int deleteUser(@PathVariable String id) {
		return userInfoService.delete(id);
	}
	
	@PostMapping(value="/registFav")
	public int registFav(FavInfo favInfo) {
		System.out.println(favInfo);
		return userInfoService.registFav(favInfo);
	}
	
	
}

