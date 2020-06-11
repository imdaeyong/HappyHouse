<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String contextPath = request.getContextPath();
%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<title>회원정보 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/components.css">
<link rel="stylesheet" href="../css/icons.css">
<link rel="stylesheet" href="../css/responsee.css">
<link rel="stylesheet" href="../owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="../owl-carousel/owl.theme.css">     
<link rel="stylesheet" href="../css/template-style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<head>
<style>
.center {
  margin: auto;
  width: 60%;
  padding: 10px;
}
.w3-row {
  margin: auto;
  padding: 10px;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	detail();
});

function detail(){
	$.ajax({
	        type : 'get',
	        url : '<%=contextPath%>/detailUser/' + ${userinfo.id},
	        dataType : 'json',
	        data : 
			{
			},
	        success : function(data, status, xhr) { 

	        	$("#id").val(data.id),
	        	$("#pw").val(data.pw),
	        	$("#name").val(data.name),
	        	$("#nickname").val(data.nickname),
	        	$("#email").val(data.email),
	        	$("#homepage").val(data.homepage),
	        	$("#address").val(data.address),
	        	$("#hobby").val(data.hobby)
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
			}
	});
}



function edit() {
	if(document.getElementById("id").value == "") {
		alert("아이디 입력!!!");
		return;
	} else if(document.getElementById("pw").value == "") {
		alert("비밀번호 입력!!!");
		return;
	} else if(document.getElementById("name").value == "") {
		alert("이름 입력!!!");
		return;
	} else {
		$.ajax(
				{
			        type : 'put',
			        url : '<%=contextPath%>/modifyUser',
			        dataType : 'json',
			        data : 
					{
			        	id: $("#id").val(),
			        	pw: $("#pw").val(),
			        	name: $("#name").val(),
			        	nickname: $("#nickname").val(),
			        	email: $("#email").val(),
			        	homepage: $("#homepage").val(),
			        	address: $("#address").val(),
			        	hobby: $("#hobby").val(),
			        	
					},
			        success : function(data, status, xhr) { 
			        	
			        	document.location.href = "${root}/house/lists";
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) 
			        { 
			        	console.log(jqXHR.responseText); 
			        }
			    });
	}
}
function deleteUser(){
	$.ajax(
			{
		        type : 'put',
		        url : '<%=contextPath%>/deleteUser/'+ ${userinfo.id},
		        dataType : 'json',
		        data : 
				{
				},
		        success : function(data, status, xhr) { 
		        	
		        	document.location.href = "${root}/logout";
		        }, 
		        error: function(jqXHR, textStatus, errorThrown) 
		        { 
		        	console.log(jqXHR.responseText); 
		        }
		    });
}
</script>

</head>

<body>
<%@ include file="../header.jsp" %>
<div class="center" style="width: 60%">
<h2 class="w3-center">회원정보 수정</h2>

<form id="editform" method="post" action="" class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin">
<input type="hidden" name="userid" id="userid" value="${userinfo.id}">
 
<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
  <div class="w3-rest">
    이름
    <input class="w3-input w3-border" id="name" name="name" type="text"  readonly>
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-weixin"></i></div>
  <div class="w3-rest">
    아이디
    <input class="w3-input w3-border" id="id" name="id" type="text" onFocus="this.value=''">
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-lock"></i></div>
  <div class="w3-rest">
    비밀번호
    <input class="w3-input w3-border" id="pw" name="pw" type="text"  onFocus="this.value=''">
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-star"></i></div>
  <div class="w3-rest">
    닉네임
    <input class="w3-input w3-border" id="nickname" name="nickname" type="text"  onFocus="this.value=''">
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope"></i></div>
  <div class="w3-rest">
    이메일
    <input class="w3-input w3-border" id="email" name="email" type="text"  onFocus="this.value=''">
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-home"></i></div>
  <div class="w3-rest">
    주소
    <input class="w3-input w3-border" id="address" name="address" type="text"  onFocus="this.value=''">
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-laptop"></i></div>
  <div class="w3-rest">
    홈페이지
    <input class="w3-input w3-border" id="homepage" name="homepage" type="text" onFocus="this.value=''">
  </div>
</div>

<div class="w3-row">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-gamepad"></i></div>
  <div class="w3-rest">
    취미
    <input class="w3-input w3-border" id="hobby" name="hobby" type="text"  onFocus="this.value=''">
  </div>
</div>

<button class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding" onclick="javascript:edit();">수정</button>
<button class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding" onclick="javascript:deleteUser();">탈퇴</button>
<a href="${root}/house/lists" class="w3-button w3-block w3-section w3-red w3-ripple w3-padding">취소</a>

</form>
</div>
</body>
</html> 
