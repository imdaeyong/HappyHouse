<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<title>마이페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<head>
<style>
.center {
  margin: auto;
  width: 60%;
  padding: 10px;
}
</style>

<script type="text/javascript">
function out() {
	document.getElementById("outform").action = "${root}/user.do";
	document.getElementById("outform").submit();
	alert("탈퇴 완료");
}
</script>

</head>

<body>
<%@ include file="../header.jsp" %>

<div class="center" style="width: 60%; margin-top: 90px; margin-bottom: 90px;">
<form action="" id="outform" class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin">
<input type="hidden" name="act" id="act" value="userout">
<input type="hidden" name="userid" id="userid" value="${userinfo.id}">
<input type="hidden" name="userpw" id="userpw" value="${userinfo.pw}">
<h2 class="w3-center">마이페이지</h2>
 
<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
  <div class="w3-rest">
    이름
    <p class="w3-white" style="padding: 10px">&nbsp;${userinfo.name}</p>
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-weixin"></i></div>
  <div class="w3-rest">
    아이디
    <p class="w3-white" style="padding: 10px">&nbsp;${userinfo.id}</p>
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-star"></i></div>
  <div class="w3-rest">
    닉네임
    <p class="w3-white" style="padding: 10px">&nbsp;${userinfo.nickname}</p>
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope"></i></div>
  <div class="w3-rest">
    이메일
    <p class="w3-white" style="padding: 10px">&nbsp;${userinfo.email}</p>
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-home"></i></div>
  <div class="w3-rest">
    주소
    <p class="w3-white" style="padding: 10px">&nbsp;${userinfo.address}</p>
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-laptop"></i></div>
  <div class="w3-rest">
    홈페이지
    <p class="w3-white" style="padding: 10px">&nbsp;${userinfo.homepage}</p>
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-gamepad"></i></div>
  <div class="w3-rest">
    취미
    <p class="w3-white" style="padding: 10px">&nbsp;${userinfo.hobby}</p>
  </div>
</div>

<a href="${root}/user.do?act=useredit" class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding">수정</a>
<button class="w3-button w3-block w3-section w3-red w3-ripple w3-padding" onclick="javascript:out();">탈퇴</button>

</form>
</div>
</body>
</html> 
