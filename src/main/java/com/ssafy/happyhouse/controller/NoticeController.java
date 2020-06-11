package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.cj.protocol.x.Notice;
import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.service.NoticeService;



//RestController를 사용하기때문에 모든 return값이 자동으로 비동기통신방식으로(json) 보내진다
// @ResponseBody + @Controller
@RestController
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) {
		ModelAndView  mav = new ModelAndView("error/errorHandler");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	//studens.jsp페이지가 호출되면 페이지에서 자동으로 /student를 get방식으로 호출함
	//전체리스트를 보내줌
	//@GetMapping은 데이타를 검색하여 값을 받아올 때 사용 CRUD 에서 Retrieve
	@GetMapping(value="/notice")
	public List<NoticeDto> list() {
		return noticeService.listNotice();
	}
	@GetMapping(value="/noticeSearch")
	public List<NoticeDto> list(@RequestParam Map<String, String> param) {
		//param.toString();
		String key =  param.get("key");
		String word = param.get("word");
		return noticeService.searchNotice(key, word);
	}
	
	//@PostMapping은 데이타를 새로 만들 때 사용 CRUD 에서 Create 
	@PostMapping(value="/notice")
	public int insert(NoticeDto dto) {
		dto.setId("ssafy");
		return noticeService.registNotice(dto);
	}

	//@PutMapping은 데이타를 업데이트할 때 사용 CRUD 에서 Update  
	@PutMapping(value="/notice/{noticeno}")
	public int update(@PathVariable int noticeno, @RequestBody NoticeDto dto) {
		return noticeService.modifyNotice(dto);
	}
	
	//@DeleteMapping은 데이타를 삭제할 때 사용 CRUD 에서 Delete   
	@DeleteMapping(value="/notice/{noticeno}")
	public int delete(@PathVariable int noticeno) {
		return noticeService.deleteNotice(noticeno);
	}
	
	//@GetMapping은 데이타를 검색하여 값을 받아올 때 사용 CRUD 에서 Retrieve
	@GetMapping(value="/notice/{noticeno}")
	public NoticeDto detail(@PathVariable int noticeno) {
		return noticeService.getNotice(noticeno);
	}
}
