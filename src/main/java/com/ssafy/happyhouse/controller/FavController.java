package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.dto.SidoCodeDTO;
import com.ssafy.happyhouse.mapper.FavMapper;



//RestController를 사용하기때문에 모든 return값이 자동으로 비동기통신방식으로(json) 보내진다
// @ResponseBody + @Controller
@RestController
public class FavController {
	
	@Autowired
	FavMapper favMapper;
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/errorHandler");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	

	@GetMapping(value="/sidolist")
	public List<SidoCodeDTO> list() {
		return favMapper.sidolist();
	}

}
