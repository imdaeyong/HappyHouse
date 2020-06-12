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

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.SidoCodeDTO;
import com.ssafy.happyhouse.service.FSelectBoxService;

@RestController
@RequestMapping("/fsel")
public class FSelectBoxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	@Autowired
	private FSelectBoxService fselService; 
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/error");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	@RequestMapping(value="/sido")
	public List<SidoCodeDTO> sidosearch(@RequestParam Map<String, String> param ,Model m) throws Exception{
		return fselService.selectSido();
	}
	
	@RequestMapping(value="/gugun")
	public List<SidoCodeDTO> gugunsearch(@RequestParam Map<String, String> param ,Model m) throws Exception{
		return fselService.selectGugun(param.get("sido"));
	}
	
	@RequestMapping(value="/dong")
	public List<HouseInfo> dongsearch(@RequestParam Map<String, String> param ,Model m) throws Exception{
		return fselService.selectDong(param.get("gugun"));
	}
	
	@RequestMapping(value="/apt")
	public List<HouseDeal> aptsearch(@RequestParam Map<String, String> param ,Model m) throws Exception{
		return fselService.selectApt(param.get("dong"));
	}
	

}
