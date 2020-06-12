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
<link rel="stylesheet" href="../css/components.css">
<link rel="stylesheet" href="../css/icons.css">
<link rel="stylesheet" href="../css/responsee.css">
<link rel="stylesheet" href="../owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="../owl-carousel/owl.theme.css">     
<link rel="stylesheet" href="../css/template-style.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8cbe81440a2dc401533a67159970a3ac&libraries=services,clusterer,drawing"></script>
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

$(document).ready(function() {
    initMap();
 });
function initMap(){

	//마커 이미지!
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var imageSize = new kakao.maps.Size(24, 35);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		
	var map;
	var multi = new kakao.maps.LatLng(37.5665734, 126.978179);
	map = new kakao.maps.Map(document.getElementById('map'), {
		center : multi, // 지도의 중심좌표
		level : 9	// 지도의 확대 레벨
	});
	
	var marker = new kakao.maps.Marker({
		position : multi,
		map : map,
		image:markerImage
	});
	
	 // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 5 // 클러스터 할 최소 지도 레벨 
    });
	 
	
	 $.get("${pageContext.request.contextPath}/fsel/apt"
			,{dong:$("#dong").val()}
			,function(datas, status){
			console.log(datas);
			
	        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	        var markers = $(datas).map(function(i, data) {
	            return new kakao.maps.Marker({
	                position : new kakao.maps.LatLng(data.lat, data.lng),
	     			label:data.aptName,
	     			title:data.aptName,
	     			image:markerImage
	            });
	        });

	        // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers);
	    });
}
	
let colorArr = ['table-primary','table-success','table-danger'];
var markers= [];
var locations= [];

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
				,function(data, status)
				{
					$("tbody").empty(); //테이블 초기화
// 					removeMarker(); //지도 초기화
						
					$.each(data, function(index, vo) {
						let str = "<tr class="+colorArr[index%3]+">"
						+ "<td>" + vo.no + "</td>"
						+ "<td>" + vo.dong + "</td>"
						+ "<td>" + vo.aptName + "</td>"
						+ "<td>" + vo.floor + "</td>"
						+ "<td>" + vo.dealAmount + "</td>"
						+ "<td>" + vo.lng + "</td></tr>"
						$("tbody").append(str);
						
					});//each
// 				houselists(data);	
				initMap();				
				}//function					
			, "json"						
		);//get
	});//change
});//ready
// function houselists(data){	
// 	console.log(data);
// 	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

	
// 	for(var i=0; i<data.length;i++){		
// 		console.log("현재 데이터");
// 		console.log(data[i]);
// 		var imageSize = new kakao.maps.Size(24, 35);
// 		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
// 		console.log(data[i].lat);
		
// 		var marker= new kakao.maps.Marker({
// 			position:new kakao.maps.LatLng(parseFloat(data[i].lat),parseFloat(data[i].lng)),
// 			label:data[i].aptName,
// 			title:data[i].aptName,
// 			image:markerImage
// 		});
// 		marker.setMap(map);
// 		console.log(marker);
// 	}
// }
function removeMarker(){
	
	
}

</script>
	시도 : <select id="sido"> <option value="0">선택</option></select>
	구군 : <select id="gugun"> <option value="0">선택</option></select>
	읍면동 : <select id="dong"><option value="0">선택</option></select>
<table class="table mt-2">
	<thead>
		<tr>
			<th>번호</th>
			<th>법정동</th>
			<th>아파트이름</th>
			<th>층</th>
			<th>거래가격</th>
			<th>링크</th>
		</tr>
	</thead>
	<tbody>
	<!--  여기에 결과 들어감 -->
	</tbody>
</table>
<!-- here end -->
<!-- map start -->
<div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
<!-- map end -->

				</div>
			</div>
		</section>
	</div>

<!-- Footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>
