package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.dto.UserInfo;
import com.ssafy.happyhouse.service.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/errorHandler");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	//get방식으로 /login을 받으면 application.properties에서 지정한 경로인 /WEB-INF/views/의 loginForm.jsp로 보내주는 코드
	@GetMapping(value="/login")
	public String loginForm() {
		return "loginForm";
	}
	
	//post방식으로 /login을 받았을때 같이 보내진 id와 password를 가지고 회원 확인함
	@PostMapping(value="/login")
	public String login(String id, String password, HttpSession session) {
		// #1
		UserInfo userinfo = loginService.login(id, password);
		
		// #2
//		Map<String, String> loginMap = new HashMap<String, String>();
//		loginMap.put("id", id);
//		loginMap.put("password", password);
//		TeacherDto teacherDto = loginService.login(loginMap);
		
		
		System.out.println(userinfo);
		
		//해당 회원 없을시 result에 fail을 담아서 login을 호출한다
		if( userinfo == null ) {
			return "user/login";
		}else {
			//해당회원있으면 view의 student폴더의 student.jsp호출
			session.setAttribute("userinfo", userinfo);
			return "index";
		}
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		//로그아웃하면 세션 무효화후 loginForm.jsp호출
		session.invalidate();
		return "user/login";
	}
}
