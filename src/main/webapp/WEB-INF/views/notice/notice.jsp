<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function mvmodify() {
		location.href = "${root}/notice.do?act=mvmodify&noticeno=${notice.noticeno}";
	}
	function back() {
		document.location.href = "${root}/notice.do?act=back";
	}
</script>
<title>공지사항 상세</title>
</head>
<body>
	<%@ include file="../header.jsp" %>
	
	<div class="w3-display-container w3-content w3-wide" align="center" style="margin-top: 90px;margin-bottom: 90px;">
		
		<div class="col-lg-8" align="center">
			<h2>게시물</h2>
			<table class="w3-table w3-bordered">
				<tbody>
					<tr>
						<td>작성자 : ${notice.id}</td>
						<td align="right">작성일 : ${notice.regtime}</td>
					</tr>
					<tr>
						<td>번호</td>
						<td colspan="2"><strong>${notice.noticeno}</strong></td>
					</tr>
					<tr>
						<td>제목</td>
						<td colspan="2"><strong>${notice.subject}</strong></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2">${notice.content}</td>
					</tr>
				</tbody>
			</table>
			<c:if test="${userinfo.isAdmin == 1}">
			<button type="button" class="btn btn-primary" onclick="javascript:mvmodify();" style="margin-top: 60px;">수정</button>
			<button type="button" class="btn btn-warning" onclick="document.location.href = '${root}/notice.do?act=ntdelete&noticeno=${notice.noticeno}'" style="margin-top: 60px;">삭제</button>
			</c:if>
			<button type="button" class="btn btn-warning" onclick="javascript:back();" style="margin-top: 60px;">돌아가기</button>
		</div>
	</div>
</body>
<%@ include file="../header.jsp" %>
</html>