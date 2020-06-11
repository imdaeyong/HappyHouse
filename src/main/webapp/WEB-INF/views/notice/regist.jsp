<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String contextPath = request.getContextPath();
%>
<%-- <c:if test="${userinfo == null}">
	<c:redirect url="/main.do"/>
</c:if>
<c:if test="${userinfo != null}">
--%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>공지사항 작성</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  
  <script type="text/javascript">
  function registNotice() {
	if(document.getElementById("subject").value == "") {
		alert("제목 입력!!!!");
		return;
	} else if(document.getElementById("content").value == "") {
		alert("내용 입력!!!!");
		return;
	} else {
		$.ajax(
		{
	        type : 'post',
	        url : '<%=contextPath%>/notice',
	        dataType : 'json',
	        data : 
			{
	        	subject: $("#subject").val(),
	        	content: $("#content").val(),
	        	id: $("#id").val()
	        	
			},
	        success : function(data, status, xhr) { 
				document.location.href = "${contextPath}/noticepage";
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
	        }
	    });
	}
  }
  function modifyNotice() {
	if(document.getElementById("subject").value == "") {
		alert("제목 입력!!!!");
		return;
	} else if(document.getElementById("content").value == "") {
		alert("내용 입력!!!!");
		return;
	} else {
		$.ajax(
		{
	        type : 'put',
	        url : '<%=contextPath%>/notice',
	        dataType : 'json',
	        data : 
			{
	        	subject: $("#subject").val(),
	        	content: $("#content").val(),
	        	id: $("#id").val(),
	        	noticeno: $("#noticeno").val(),
	        	
			},
	        success : function(data, status, xhr) { 

	        	list();
	        	clear();
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
	        }
	    });
	}
  }
  function back(){
	  document.location.href = "${contextPath}/noticepage";
  }
  </script>
</head>
<body>

<%@ include file="../header.jsp" %>
	
<div class="container" align="center" style="margin-top: 90px;margin-bottom: 90px;">
	<div class="col-lg-6" align="center">
		<h2>공지사항 쓰기</h2>
		<form id="writeform" method="post" action="">
			<input type="hidden" name="id" id="id" value="${userinfo.id}">
			<div class="form-group" align="left">
				<label for="subject">제목:</label>
				<input type="text" class="form-control" id="subject" name="subject" value="${notice.subject}" }>
			</div>
			<div class="form-group" align="left">
				<label for="content">내용:</label>
				<textarea class="form-control" rows="15" id="content" name="content" style="resize:none;" >${notice.content}</textarea>
			</div>
			<c:if test="${notice == null}">
				<input type="hidden" name="act" id="act" value="ntregist">
				<button type="button" class="btn btn-primary" onclick="javascript:registNotice();">공지작성</button>
			</c:if>
			<c:if test="${notice != null}">
				<input type="hidden" name="act" id="act" value="ntmodify">
				<input type="hidden" name="noticeno" id="noticeno" value="${notice.noticeno}">
				<button type="button" class="btn btn-primary" onclick="javascript:modifyNotice();">공지수정</button>
			</c:if>
			<button type="reset" class="btn btn-warning">초기화</button>
			<button type="button" class="btn btn-warning" onclick="javascript:back();">돌아가기</button>
		</form>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>
<%-- 
</c:if>
--%>