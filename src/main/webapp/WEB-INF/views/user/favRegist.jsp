<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String contextPath = request.getContextPath();
%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<style>
.center {
  margin: auto;
  padding: 10px;
  align: right;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		sidolist();
	});
	function sidolist(){
		$.ajax({
		        type : 'get',
		        url : '<%=contextPath%>/sidolist',
		        dataType : 'json',
		        data : 
				{
				},
		        success : function(data, status, xhr) { 
		        	makeListHtml(data);
		        }, 
		        error: function(jqXHR, textStatus, errorThrown) 
		        { 
		        	console.log(jqXHR.responseText); 
				}
		});		
	}
	function makeListHtml(list){
		for( var i=0; i<list.length; i++){
			
			var content = list[i].content;
			var id = list[i].id;
			var noticeno = list[i].noticeno;
			var regtime = list[i].regtime;
			var subject = list[i].subject;
			
			var listHtml =
				'<tr style="cursor:pointer" data-id=' + noticeno +'><td>' + noticeno + '</td><td>' + subject + '</td><td>' + id + '</td></tr>';

			$("#noticeBody").append(listHtml);
		}
		
	}
	function registFav() {
		if ($("#dong option:selected").val() == "0") {
			alert("동을 선택해주세요");
			return;
		}
		document.getElementById("dongform").action = "${root}/fav.do";
		document.getElementById("dongform").submit();
	}
</script>
</head>
<header class="w3-display-container w3-content w3-wide"
	style="max-width: 1500px;" id="home">
	<img class="w3-image" src="/img/cityview.jpg" alt="Architecture"
		width="1500">
	<div class="w3-display-middle w3-margin-top w3-center">
		<h1 class="w3-xxlarge w3-text-white">
			<span class="w3-padding w3-white w3-opacity-min"><b>Happy</b></span>
			<span class="w3-hide-small w3-text-light-grey">House</span>
		</h1>
	</div>
</header>
<body>
	<!-- Navbar (sit on top) -->
	<div class="w3-top">
	  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
	    <a href="/index.jsp" class="w3-bar-item w3-button" style="text-decoration: none;"><b>Happy</b> House</a>
	    <!-- Float links to the right. Hide them on small screens -->
	    <div class="w3-right w3-hide-small">
	    	<strong style="color: #6495ED;">${userinfo.name}</strong>님 환영합니다.
			<a href="${root}/main.do?act=logout" class="w3-button w3-amber w3-padding">로그아웃</a>
	    </div>
	  </div>
	</div>

	<div class="main-container" align="left" style="max-width: 70%;margin: 0px auto;">

		<!-- HouseDeal Section -->
		<div class="w3-container w3-padding-32 w3-row center">
			<div class="form-block p-30 light-gray-bg border-clear" style="margin: 0px auto;">
				<form id="dongform" method="post" action="">
					<input type="hidden" name="act" id="act" value="registFav">
					<input type="hidden" name="id" id="id" value="${userinfo.id}">
					<div class="form-group has-feedback row" align="center">
						<h2 class="title">관심 지역</h2>
						<label for="inputPassword"
							class="col-md-3 control-label text-md-right col-form-label">관심
							지역 설정 <span class="text-danger small">*</span>
						</label>
						<div class="col-md-8">
							<div class="form-group md">
								<select class="form-control" name="city" id="city">
									<option value="0">선택</option>
								</select>
							</div>
							<div class="form-group md-1">
								<select class="form-control" name="gugun" id="gugun">
									<option value="0">선택</option>
								</select>
							</div>
							<div class="form-group md-1">
								<select class="form-control" name="dong" id="dong">
									<option value="0">선택</option>
								</select>
							</div>
							<div class="form-group md-1">
								<button class="btn btn-group btn-warning btn-animated"
									onclick="javascript:registFav();">
									등록 <i class="fa fa-check"></i>
								</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

</html>
