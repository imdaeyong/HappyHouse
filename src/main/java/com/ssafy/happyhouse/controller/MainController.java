package com.ssafy.happyhouse.controller;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.service.LoginService;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@Controller
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Autowired
	private LoginService loginService;
	
	@ExceptionHandler
	public ModelAndView handler(Exception ex) { //에러 페이지 출력.
		ModelAndView  mav = new ModelAndView("error/error");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	@GetMapping(value="/") 
	public String loginForm() {
		return "user/login";
	}
	
	@RequestMapping(value="/house/lists") 
	public String list() {
		return "index";
	}
	
	@RequestMapping(value="/mvmypage") 
	public String mvmypage() {
		return "user/mypage_edit";
	}
	
	@RequestMapping(value="/moveJoin") 
	public String moveJoin() {
		return "user/join";
	}
	@RequestMapping(value="/findpwd") 
	public String findpwd() {
		return "user/findpwd";
	}
	
	@RequestMapping(value="/map")
	public String map() {
		return "map";
	}
	@RequestMapping(value="/mvqna")
	public String qna() {
		return "qna";
	}
	@RequestMapping(value="/drugstore")
	public String drugstore() {
		return "drugstore";
	}
	
	
//	@GetMapping(value="/") 
//	public String loginForm() {
//		return "index";
//	}
	
//	
//	
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		process(request, response);
//	}
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setCharacterEncoding("utf-8");
//		process(request, response);
//	}
//	
//	private void redirect(HttpServletResponse response, String root, String path) throws IOException {
//	      response.sendRedirect(root + path);
//	}
//
//	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String root = request.getContextPath();
//		String act = request.getParameter("act");
//		String path="/index.jsp";
//		
//		if("mvnotice".equals(act)) {
//			path = "/notice.do?act=search&key=&word=";
//			redirect(response, root, path);
//		} else if("mvlogin".equals(act)) {
//			response.sendRedirect(root + "/user/login.jsp");
//		} else if("mvjoin".equals(act)) {
//			response.sendRedirect(root + "/user/join.jsp");
//		} else if("login".equals(act)) {
//			login(request, response);
//		} else if("logout".equals(act)) {
//			logout(request, response);
//		} else if("join".equals(act)) {
//			join(request, response);
//		} else if("mvmypage".equals(act)) {
//			response.sendRedirect(root + "/user/mypage.jsp");
//		} else if("back".equals(act)) {
//	         path = "/notice.do?act=search&key=&word=";
//	         redirect(response, root, path);
//	    }
//	}
//	
//	private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//		HttpSession session = request.getSession();
//		session.removeAttribute("userinfo");
//		session.invalidate();
//		response.sendRedirect("/index.jsp");
//	}
//
//	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String path = "/index.jsp";
//		String userid = request.getParameter("userid");
//		String userpwd = request.getParameter("userpwd");
//		
//		try {
//			UserInfo userInfo = loginService.login(userid, userpwd);
//			if(userInfo != null) {
////				session 설정
//				HttpSession session = request.getSession();
//				session.setAttribute("userinfo", userInfo);
//				
////				cookie 설정
//				String idsave = request.getParameter("idsave");
//				if("saveok".equals(idsave)) {//아이디 저장을 체크 했다면.
//					Cookie cookie = new Cookie("ssafy_id", userid);
//					cookie.setPath(request.getContextPath());
//					cookie.setMaxAge(60 * 60 * 24 * 365 * 40);//40년간 저장.
//					response.addCookie(cookie);
//				} else {//아이디 저장을 해제 했다면.
//					Cookie cookies[] = request.getCookies();
//					if(cookies != null) {
//						for(Cookie cookie : cookies) {
//							if("ssafy_id".equals(cookie.getName())) {
//								cookie.setMaxAge(0);
//								response.addCookie(cookie);
//								break;
//							}
//						}
//					}
//				}
//			} else {
//				path = "/user/login.jsp";
//				request.setAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "로그인 중 문제가 발생했습니다.");
//			path = "/error/error.jsp";
//		}
//		request.getRequestDispatcher(path).forward(request, response);
//	}
//	
//	private void join(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String path = "/index.jsp";
//		
//		String userid = request.getParameter("userid");
//		String userpwd = request.getParameter("userpwd");
//		String username = request.getParameter("username");
//		String nickname = request.getParameter("nickname");
//		String email = request.getParameter("emailid");
//		String emaildomain = request.getParameter("emaildomain");
//		String address = request.getParameter("address") + request.getParameter("address_detail");
//		String hobby = request.getParameter("hobby");
//		String homepage = request.getParameter("homepage");
//		
//		if(!email.equals("")) email = email + "@" + emaildomain;
//		
//		try {
//			UserInfo userinfo = signupService.signUp(userid, userpwd, username, nickname, email, address, hobby, homepage);
//			if(userinfo == null) {
//				path = "/user/join.jsp";
//				//request.setAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "회원가입 중 문제가 발생했습니다.");
//			path = "/error/error.jsp";
//		}
//		request.getRequestDispatcher(path).forward(request, response);
//	}
}
