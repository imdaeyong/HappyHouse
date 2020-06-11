<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String contextPath = request.getContextPath(); %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
	<c:set var="idck" value=" checked=\"checked\""/>
</c:if>
<!DOCTYPE html>
<html>
<title>Happy House</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
<body>

<%@ include file="header.jsp" %>

<div class="container">
				<div class="mt-2 mb-2">
					<h2>주소로 찾기</h4>
				</div>
<section id="index_section">
			<div class="card col-sm-12 mt-1" style="min-height: 850px;">
				<div class="card-body">

<!-- here start -->
<script>
let colorArr = ['table-primary','table-success','table-danger'];
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
						$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
					});//each
				}//function
				, "json"
		);//get
	});//change
	$("#dong").change(function() {
		$.get("${pageContext.request.contextPath}/fsel/apt"
				,{dong:$("#dong").val()}
				,function(data, status){
					$("#searchResult").empty();
					$.each(data, function(index, vo) {
						let str = "<tr class="+colorArr[index%3]+">"
						+ "<td>" + vo.no + "</td>"
						+ "<td>" + vo.dong + "</td>"
						+ "<td>" + vo.aptName + "</td>"
						+ "<td>" + vo.jibun + "</td>"
						+ "<td id='lat_"+index+"'></td>"
						+ "<td id='lng_"+index+"'></td></tr>";
						$("tbody").append(str);
						$("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>");
					});//each
					geocode(data);
				}//function
				, "json"
		);//get
	});//change
});//ready
function geocode(jsonData) {
	let idx = 0;
	$.each(jsonData, function(index, vo) {
		let tmpLat;
		let tmpLng;
		$.get("https://maps.googleapis.com/maps/api/geocode/json"
				,{	key:'AIzaSyAGZLKaqO2wNo1-9kK4lceD2tGARAlNVoA'
					, address:vo.dong+"+"+vo.AptName+"+"+vo.jibun
				}
				, function(data, status) {
					//alert(data.results[0].geometry.location.lat);
					tmpLat = data.results[0].geometry.location.lat;
					tmpLng = data.results[0].geometry.location.lng;
					$("#lat_"+index).text(tmpLat);
					$("#lng_"+index).text(tmpLng);
					addMarker(tmpLat, tmpLng, vo.AptName);
				}
				, "json"
		);//get
	});//each
}
</script>
시도 : <select id="sido">
	<option value="0">선택</option>
</select>
구군 : <select id="gugun">
	<option value="0">선택</option>
</select>
읍면동 : <select id="dong">
	<option value="0">선택</option>
</select>
<table class="table mt-2">
	<thead>
		<tr>
			<th>번호</th>
			<th>법정동</th>
			<th>아파트이름</th>
			<th>지번</th>
			<th>위도</th>
			<th>경도</th>
		</tr>
	</thead>
	<tbody>
	<!--  여기에 결과 들어감 -->
	</tbody>
</table>
<!-- here end -->
<!-- map start -->
<div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
<script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGZLKaqO2wNo1-9kK4lceD2tGARAlNVoA&callback=initMap"  type="text/javascript"></script>
<script>
	var multi = {lat: 37.5665734, lng: 126.978179};
	var map;
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			center: multi, zoom: 12
		});
		var marker = new google.maps.Marker({position: multi, map: map});
		var markerCluster = new MarkerClusterer(
				map,
				markers,
				{
					imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
				}
			);
	}
	
	function addMarker(tmpLat, tmpLng, AptName) {
		var marker = new google.maps.Marker({
			position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
			label: AptName,
			title: AptName
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(marker.getPosition());
			callHouseDealInfo();
		});
		marker.setMap(map);
	}
	function callHouseDealInfo() {
		alert("you can call HouseDealInfo");
	}
</script>
<!-- map end -->

				</div>
			</div>
		</section>
	</div>

<!-- Footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>
