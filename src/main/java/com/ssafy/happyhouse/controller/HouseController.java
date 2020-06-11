package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.PageNavigation;
import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.service.HouseService;

@RestController
@RequestMapping("/house")
public class HouseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	@Autowired
	private HouseService houseService; 
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/error");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	@RequestMapping(value="/list")
	public List<HouseDeal> housesearch(@RequestParam Map<String, String> param ,Model m) throws Exception{
		
		String aptdeal = param.get("aptdeal");
		String aptrent =  param.get("aptrent");
		String housedeal = param.get("housedeal");
		String houserent =param.get("houserent");
		String searchsel = param.get("searchsel");
		String searchtext =param.get("searchtext");
		
		
		String pg = param.get("pg");
		int currentPage = pg==null? 1 : Integer.parseInt(pg); //현재 페이지 번호
		String spp = param.get("spp");
		int sizePerPage = spp == null ? 10 : Integer.parseInt(spp);//sizePerPage
		
		boolean b_aptdeal = false;
		boolean b_aptrent = false;
		boolean b_housedeal = false;
		boolean b_houserent = false;
		
		if(aptdeal==null||aptdeal.equals("aptdeal")) b_aptdeal = true;
		if(aptrent==null||aptrent.equals("aptrent")) b_aptrent = false;
		if(housedeal==null||housedeal.equals("housedeal")) b_housedeal = false;
		if(houserent==null||houserent.equals("houserent")) b_houserent = false;
		
		boolean[] searchType = new boolean[] { b_aptdeal, b_aptrent, b_housedeal, b_houserent };
		HousePageBean bean = new HousePageBean();
		
		bean.setSearchType(searchType);
		
		if(searchsel==null) searchsel="";
		if(searchtext==null) searchtext="";
		
		searchsel=searchsel.trim();
		searchtext=searchtext.trim();
		
		System.out.println("여기에요 !!"+searchsel+":"+searchtext);
		
		List<HouseDeal> deals = null;
		try {
			switch(searchsel) {
			case "dong":
				bean.setDong(searchtext);
				break;
			case "aptname":
				bean.setAptname(searchtext);
				break;
			}
			deals = houseService.searchAll(currentPage, sizePerPage, bean);
			PageNavigation pageNavigation = houseService.makePageNavigation(currentPage, sizePerPage,bean);

			if (deals != null) {
				m.addAttribute("navigation", pageNavigation);
				m.addAttribute("searchsel", searchsel); //검색조건
				m.addAttribute("searchtext", searchtext); //검색어
				m.addAttribute("pg", pg);
				m.addAttribute("deals",deals);			
			} else {
				m.addAttribute("msg", "데이터가 없습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "검색 중 문제가 발생했습니다.");
		}
		return deals;
	}
	@GetMapping(value="/detail/{no}") //상세정보 
	public HouseDeal detail(@PathVariable int no) {
		return houseService.search(no);
	}
	

}
