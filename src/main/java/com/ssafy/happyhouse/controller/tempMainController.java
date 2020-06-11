package com.ssafy.happyhouse.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.service.LoginService;
import com.ssafy.happyhouse.service.NoticeService;
@Controller
public class tempMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Autowired
	private LoginService loginService;
	private NoticeService noticeService;
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) { //에러 페이지 출력.
		ModelAndView  mav = new ModelAndView("error/error");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	
	
	@GetMapping(value="/noticepage") 
	public String loginForm() {
		return "notice/noticeList";
	}
	
	@GetMapping(value="/moveNotice") 
	public String moveNotice() {
		return "notice/regist";
	}
	
	@GetMapping(value="/moveFavRegist") 
	public String moveFavRegist() {
		return "user/favRegist";
	}
	
	@GetMapping(value="/moveFavList") 
	public String moveFavList() {
		return "user/favList";
	}
	

}
