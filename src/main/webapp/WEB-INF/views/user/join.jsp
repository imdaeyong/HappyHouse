<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String contextPath = request.getContextPath();
%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원가입</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<script type="text/javascript">
$(document).ready(function() {
	$("#registerBtn").click(function() {
		if($("#username").val() == "") {
			alert("이름 입력!!!");
			return;
		} else if($("#userid").val() == "") {
			alert("아이디 입력!!!");
			return;
		} else if($("#userpwd").val() == "") {
			alert("비밀번호 입력!!!");
			return;
		} else if($("#userpwd").val() != $("#pwdcheck").val()) {
			alert("비밀번호 확인!!!");
			return;
		} else {
			$.ajax(
					{
				        type : 'post',
				        url : '<%=contextPath%>/signUp',
				        dataType : 'json',
				        data : 
						{
				        	id: $("#id").val(),
				        	pw: $("#pw").val(),
				        	name: $("#name").val(),
				        	nickname: $("#nickname").val(),
				        	email: $("#emailid").val()+"@"+$("#emaildomain option:selected").val(),
				        	homepage: $("#homepage").val(),
				        	address: $("#address").val(),
				        	hobby: $("#hobby").val(),
				        	
						},
				        success : function(data, status, xhr) { 
							document.location.href = "${contextPath}/";
				        }, 
				        error: function(jqXHR, textStatus, errorThrown) 
				        { 
				        	console.log(jqXHR.responseText); 
				        }
				    });
		} 
	});
	 
});
</script>
</head>
<body>

<%@ include file="../header.jsp" %>

<div class="container" align="center" style="margin-top: 90px;margin-bottom: 90px;">
	<div class="col-lg-6" align="center">
		<form id="memberform" method="post" action="">
		<input type="hidden" name="act" id="act" value="join">
			<div class="form-group" align="left">
				<label for="name">이름</label>
				<input type="text" class="form-control" id="name" name="name" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">아이디</label>
				<input type="text" class="form-control" id="id" name="id" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">비밀번호</label>
				<input type="password" class="form-control" id="pw" name="pw" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">비밀번호재입력</label>
				<input type="password" class="form-control" id="pwcheck" name="pwcheck" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">닉네임</label>
				<input type="text" class="form-control" id="nickname" name="nickname" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">이메일</label><br>
				<div id="email" class="custom-control-inline">
				<input type="text" class="form-control" id="emailid" name="emailid" placeholder="" size="25"> @
				<select class="form-control" id="emaildomain" name="emaildomain">
					<option value="naver.com">naver.com</option>
					<option value="google.com">google.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="hanmail.net">hanmail.net</option>
				</select>
				</div>
			</div>
			<!-- <div class="form-group" align="left">
				<label for="tel">전화번호</label>
				<div id="tel" class="custom-control-inline">
				<select class="form-control" id="tel1" name="tel1">
					<option value="010">010</option>
					<option value="02">02</option>
					<option value="031">031</option>
					<option value="032">032</option>
					<option value="041">041</option>
					<option value="051">051</option>
					<option value="061">061</option>
				</select> _
				<input type="text" class="form-control" id="tel2" name="tel2" placeholder=""> _
				<input type="text" class="form-control" id="tel3" name="tel3" placeholder="">
				</div>
			</div> -->
			<div class="form-group" align="left">
				<label for="">주소</label><br>
				<!-- <div id="addressdiv" class="custom-control-inline">
					<input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="우편번호" size="7" maxlength="5" readonly="readonly">
					<button type="button" class="btn btn-primary" onclick="javascript:">우편번호</button>
				</div> -->
				<input type="text" class="form-control" id="address" name="address" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">취미</label>
				<input type="text" class="form-control" id="hobby" name="hobby" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">홈페이지</label>
				<input type="text" class="form-control" id="homepage" name="homepage" placeholder="">
			</div>
			<div class="form-group" align="center">
				<button type="button" class="btn btn-primary" id="registerBtn">회원가입</button>
				<button type="reset" class="btn btn-warning">초기화</button>
			</div>
		</form>
	</div>
</div>


</body>
</html>