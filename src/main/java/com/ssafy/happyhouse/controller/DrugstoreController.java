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

import com.ssafy.happyhouse.dto.DrugstoreInfo;
import com.ssafy.happyhouse.dto.SidoCodeDTO;
import com.ssafy.happyhouse.service.DrugstoreService;

@RestController
public class DrugstoreController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	@Autowired
	private DrugstoreService drugstoreService; 
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/error");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	@RequestMapping(value="/searchDrugStore")
	public List<DrugstoreInfo> searchDrugStore(@RequestParam Map<String, String> param ,Model m) throws Exception{
		String lat =param.get("lat");
		String lon =param.get("lon");
		System.out.println(lat + "; " + lon);
		return drugstoreService.searchDrugStore(lat, lon);
	}

	

}
