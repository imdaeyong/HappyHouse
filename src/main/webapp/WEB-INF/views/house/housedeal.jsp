<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="com.ssafy.happyhouse.service.HouseService" %> 
<%@ page import="com.ssafy.happyhouse.service.HouseServiceImpl" %>
<%@ page import="com.ssafy.happyhouse.dto.HouseDeal" %> 
<%@ page import="com.ssafy.happyhouse.dto.HouseDeal" %> 
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
	int no = Integer.parseInt(request.getParameter("no"));

	HouseService houseService = new HouseServiceImpl();
	HouseDeal housedeal = houseService.search(no);

	String result = "";
	result += "{";
	result += "\"img\":\"" + housedeal.getImg() + "\",";
	result += "\"aptName\":\"" + housedeal.getAptName() + "\",";
	result += "\"dealAmount\":\"" + housedeal.getDealAmount().trim() + "\",";
	result += "\"buildYear\":\"" + housedeal.getBuildYear() + "\",";
	result += "\"area\":\"" + housedeal.getArea() + "\",";
	result += "\"dealDate\":\"" + housedeal.getDealYear() + "/" + housedeal.getDealMonth() + "/" + housedeal.getDealDay() + "\",";
	result += "\"dong\":\"" + housedeal.getDong().trim() + "\",";
	result += "\"jibun\":\"" + housedeal.getJibun() + "\"";
	result += "}";
	
	System.out.println(result);
	
	JSONParser parser = new JSONParser();
	Object obj = parser.parse( result );
	JSONObject jsonObj = (JSONObject) obj;

	out.println(jsonObj);
%>