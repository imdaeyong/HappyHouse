<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
	<c:set var="idck" value=" checked=\"checked\""/>
</c:if>
<!DOCTYPE html>
<style>
	#menus{
		width:100%;
		text-align:center;
	}
	#menus div{
		display :inline-block;
		border : 1px solid blue;
		
	}
</style>
<!-- Navbar (sit on top) -->
<input type="hidden" id="login_id" value="${userinfo.name}"/>
<div class="w3-top">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
    <a href="/house/lists" class="w3-bar-item w3-button"><b>Happy</b> House</a>
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
      <c:if test="${userinfo == null}">
        <a href="${root}/" class="w3-bar-item w3-button">공지사항</a>
      	<a href="${root}/" class="w3-bar-item w3-button w3-green w3-padding">로그인</a>
      	<a href="${root}/moveJoin" class="w3-button w3-amber w3-padding">회원가입</a>
      </c:if>
      <c:if test="${userinfo != null}">	
    	<a href="${root}/noticepage" class="w3-bar-item w3-button">공지사항</a>
    	<a href="${root}/moveFavList" class="w3-bar-item w3-button" style="text-decoration: none;">관심지역 보기</a>
    	<a href="${root}/moveFavRegist" class="w3-bar-item w3-button" style="text-decoration: none;">관심지역 등록</a>
      	<a href="${root}/mvmypage" style="cursor: pointer;text-decoration: none;"><strong style="color: #6495ED;">${userinfo.name}</strong></a>님 환영합니다.
		<a href="${root}/logout" class="w3-button w3-amber w3-padding">로그아웃</a>
      </c:if>
    </div>
  </div>
</div>
<!-- Header -->
<header class="w3-display-container w3-content w3-wide" style="max-width:1500px;" id="home">
  <img class="w3-image" src="/img/cityview.jpg" alt="Architecture" width="1500">
  <div class="w3-display-middle w3-margin-top w3-center">
    <h1 class="w3-xxlarge w3-text-white"><span class="w3-padding w3-white w3-opacity-min"><b>Happy</b></span> <span class="w3-hide-small w3-text-light-grey">House</span></h1>
  </div>
</header>

<section class="section-small-padding background-white text-center container" >
	<div class="line">
		<div class="margin">
			<div class="s-12 m-12 l-3 margin-m-bottom">
				<div class="padding block-bordered">
					<i class="icon-sli-home icon3x text-dark center"></i>
					<h2 class="text-thin">아파트 목록</h2>
					<a class="button button-dark-stroke text-size-12" href="${root}/house/lists">MOVE</a>
				</div>
			</div>
			<div class="s-12 m-12 l-3 margin-m-bottom">
				<div class="padding block-bordered">
					<i class="icon-sli-heart icon3x text-dark center"></i>
					<h2 class="text-thin">관심지역 등록</h2>
					<a class="button button-dark-stroke text-size-12" href="${root}/moveFavRegist">MOVE</a>
				</div>
			</div>
			<div class="s-12 m-12 l-3 margin-m-bottom">
				<div class="padding block-bordered">
					<i class="icon-sli-map icon3x text-dark center"></i>
					<h2 class="text-thin">지도로 검색</h2>
					<a class="button button-dark-stroke text-size-12" href="${root}/map">MOVE</a>
				</div>
			</div>
			<div class="s-12 m-12 l-3 margin-m-bottom">
				<div class="padding block-bordered">
					<i class="icon-sli-question icon3x text-dark center"></i>
					<h2 class="text-thin">QnA</h2>
					<a class="button button-dark-stroke text-size-12" href="/qna.html">MOVE</a>
				</div>
			</div>
			<a class="button button-dark-stroke text-size-12" href="/testmap.html">맵테스트</a>

			<c:if test="${userinfo.name == null}">
				<c:if test="${pageContext.request.requestURI != '/WEB-INF/views/user/login.jsp' and pageContext.request.requestURI != '/WEB-INF/views/user/join.jsp' and pageContext.request.requestURI != '/WEB-INF/views/user/findpwd.jsp'}">
					<c:redirect url="${root}/"/>
				</c:if>
			</c:if>
		</div>
	</div>
</section>
