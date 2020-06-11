	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
	<c:set var="idck" value=" checked=\"checked\""/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>로그인</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
  h3 {
  	margin-top: 40px;
    margin-bottom: 20px;
    text-align: center;
  }
</style>

<script type="text/javascript">
function moveJoin(){
	document.location.href = "${root}/moveJoin";
}
function findpwd(){
	document.location.href = "${root}/findpwd";
}
</script>
</head>
<body>

<%@ include file="../header.jsp" %>

<div class="container" align="center" style="margin-top: 90px;margin-bottom: 90px;">
<h2 class="w3-center">로그인</h2>
	<c:if test="${userinfo == null}">
		<h3>${msg}</h3>
	</c:if>
	
	<c:if test="${userinfo != null}">
	</c:if>

	<div class="col-lg-6" align="center">
		<form action="login" method="post" action="">
		<input type="hidden" name="act" id="act" value="login">
			<div class="form-group" align="left">
				<label for="">아이디</label>
				<input type="text" class="form-control" name="id" placeholder="" value="${saveid}">
			</div>
			<div class="form-group" align="left">
				<label for="">비밀번호</label>
				<input type="password" class="form-control" name="password" placeholder="" onkeydown="javascript:if(event.keyCode == 13) {login();}">
			</div>
			<div class="form-group form-check" align="right">
			    <label class="form-check-label">
			      <input class="form-check-input" type="checkbox" id="idsave" name="idsave" value="saveok"${idck}> 아이디저장
			    </label>
			</div>
			<div class="form-group" align="center">
				<button type="submit" class="btn btn-warning"">로그인</button>
				<button type="button" class="btn btn-warning" onclick="javascript:findpwd();">비밀번호 찾기</button>
				<button type="button" class="btn btn-primary" onclick="javascript:moveJoin();">회원가입</button>
			</div>
		</form>
<%
	String result = request.getParameter("result");
	if( "fail".equals(result) ){
%>
	<script>alert("아이디 또는 패스워드가 올바르지 않습니다.")</script>
<%
	}
%>
	</div>
</div>
