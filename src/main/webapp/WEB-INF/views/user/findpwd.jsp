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
<title>비밀번호 찾기</title>
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
function findpwd() {
	if(document.getElementById("userid").value == "") {
		alert("아이디 입력!!!");
		return;
	} else {
		$.ajax(
				{
			        type : 'get',
			        url : '${root}/findPwdById/' + $("#userid").val(),
			        dataType : 'json',
			        data :{},
			        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			        success : function(data) { 
			        	alert(data.pw);
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) 
			        { 
			        	console.log(jqXHR.responseText); 
			        }
			    });
	}
}
	 
function login() {
	document.location.href = "${root}/"
}	

function moveJoin() {
	document.location.href = "${root}/moveJoin";
}	
</script>
</head>
<body>

<%@ include file="../header.jsp" %>

<div class="container" align="center" style="margin-top: 90px;margin-bottom: 90px;">
<h2 class="w3-center">비밀번호 찾기</h2>
	<div class="col-lg-6" align="center">
		<form id="findpwform" method="post" action="">
		<input type="hidden" name="act" id="act" value="findPwdById">
			<div class="form-group" align="left" style="margin-bottom: 40px;">
				<label for="">아이디</label>
				<input type="text" class="form-control" id="userid" name="userid" placeholder="" value="${saveid}">
			</div>
			
			<c:if test="${foundPw == null}">
				<h4>${message}</h4>
			</c:if>
			<c:if test="${foundPw ne ''}">
				<h4>${foundPw}</h4>
			</c:if>
			<% session.removeAttribute("message"); %>
			<% session.removeAttribute("foundPw"); %>

			<div class="form-group" align="center" style="margin-top: 40px;">
				<button type="button" class="btn btn-warning" onclick="javascript:login();">로그인</button>
				<button type="button" class="btn btn-warning" onclick="javascript:findpwd();">비밀번호 찾기</button>
				<button type="button" class="btn btn-primary" onclick="javascript:moveJoin();">회원가입</button>
			</div>
		</form>
	</div>
</div>
