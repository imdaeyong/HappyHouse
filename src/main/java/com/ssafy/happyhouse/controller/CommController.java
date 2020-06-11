package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.dto.CommInfo;
import com.ssafy.happyhouse.dto.EnvInfo;
import com.ssafy.happyhouse.service.CommService;

@RestController
@RequestMapping("/common")
public class CommController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	@Autowired
	private CommService commService; 
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/error");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	@RequestMapping(value="/searchcomm")
	public List<CommInfo> searchComm(@RequestParam Map<String, String> param ,Model m) throws Exception{
		String dong =param.get("dong");
		return commService.searchDong(dong);
	}
	@RequestMapping(value="/searchenv")
	public List<EnvInfo> searchEnv(@RequestParam Map<String, String> param ,Model m) throws Exception{
		String dong =param.get("dong");
		return commService.searchEnv(dong);
	}
	
}

