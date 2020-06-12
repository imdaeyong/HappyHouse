<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/components.css">
<link rel="stylesheet" href="../css/icons.css">
<link rel="stylesheet" href="../css/responsee.css">
<link rel="stylesheet" href="../owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="../owl-carousel/owl.theme.css">     
<link rel="stylesheet" href="../css/template-style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
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
$(document).ready(function(){
	$.get("${pageContext.request.contextPath}/fsel/sido"
		,function(data, status){
			$.each(data, function(index, vo) {
				$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
			});//each
		}//function
		, "json"
	);//get
});//ready
$(document).ready(function(){
	$("#sido").change(function() {
		$.get("${pageContext.request.contextPath}/fsel/gugun"
				,{sido:$("#sido").val()}
				,function(data, status){
					$("#gugun").empty();
					$("#gugun").append('<option value="0">선택</option>');
					$.each(data, function(index, vo) {
						$("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
					});//each
				}//function
				, "json"
		);//get
	});//change
	$("#gugun").change(function() {
		$.get("${pageContext.request.contextPath}/fsel/dong"
				,{gugun:$("#gugun").val()}
				,function(data, status){
					$("#dong").empty();
					$("#dong").append('<option value="0">선택</option>');
					$.each(data, function(index, vo) {
						$("#dong").append("<option value='"+vo.code+"'>"+vo.dong+"</option>");
					});//each
				}//function
				, "json"
		);//get
	});//change
});//ready
function registFav() {
	if ($("#dong option:selected").val() == "0") {
		alert("등록하고싶은 동을 선택하세요");
		return;
	} else {
		$.ajax(
		{
	        type : 'post',
	        url : '<%=contextPath%>/registFav',
	        dataType : 'json',
	        data : 
			{
	        	 dongName: $("#dong option:selected").text(),
	        	 dongCode: $("#dong option:selected").val(),
	        	 id: $("#login_id").val()
			},
	        success : function(data, status, xhr) { 
				document.location.href = "${contextPath}/moveFavList";
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
	        }
	    });
	}
  }
</script>
</head>

<body>
	<%@ include file="../header.jsp" %>


	<div class="container" align="center" style="margin-bottom: 90px;">
		<div class="line">
			<h2 class="text-size-50 text-center">관심 지역 등록</h2>
			<hr class="break-small background-primary break-center">
		</div>
		<!-- HouseDeal Section -->
		<div class="col-lg-6" align="center">
		<form class="customform">
				<div class="form-group" align="left">
					<label for="">시/도 선택</label>
					<select class="form-control" name="sido" id="sido">
						<option value="0">선택</option>
					</select>
				</div>
				<div class="form-group" align="left">
					<label for="">시/도 선택</label>
					<select class="form-control" name="gugun" id="gugun">
						<option value="0">선택</option>
					</select>
				</div>
				<div class="form-group" align="left">
					<label for="">시/도 선택</label>
					<select class="form-control" name="dong" id="dong">
						<option value="0">선택</option>
					</select>
				</div>
				<div class="form-group" align="center">
					<button type="button" class="btn btn-warning" onclick="javascript:registFav();">등록</button>
				</div>
		</form>
	</div>
</body>

</html>
