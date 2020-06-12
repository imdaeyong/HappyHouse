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
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBJ3iLRNnx8MpswGdoR69UQOtGSQltPDZQ"></script>
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
	navigator.geolocation.getCurrentPosition(function(position) {
		var lat = position.coords.latitude, // 위도
		    lon = position.coords.longitude; // 경도    
		    $("#lat").val(lat);
			$("#lon").val(lon);
		    initMap();
	});
 });
 
function initMap(){
	var multi = new kakao.maps.LatLng($("#lat").val(),$("#lon").val());
	
	console.log(multi);
	//마커 이미지!
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var imageSize = new kakao.maps.Size(24, 35);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		
	map = new kakao.maps.Map(document.getElementById('map'), {
		center : multi, // 지도의 중심좌표
		level : 10	// 지도의 확대 레벨
	});
	
	var marker = new kakao.maps.Marker({
		position : multi,
		map : map,
		image:markerImage
	});
	
	//내용생성
/* 	var iwContent = '<div class="card" style="width:200px">' +
	'<img id="imgView" src = "/img/'.mc+'.jpg" onerror="src=\'/img/그림1.jpg\'" class="card-img-top" width="200px" height="200px">' +
	'<div class="card-body">' +
	'<h4 class="card-title">'+marker.mc+'</h4>' +
	'<p class="card-text">'+marker.mc+'</p>' +
	'<a href="https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query='+marker.mc+'" class="btn btn-primary">검색</a>' +
	'<a href="http://naver.com" class="btn btn-primary">가시는길</a>' +
	'</div>' +
	'</div>';
	 
	
	var infowindow = new kakao.maps.InfoWindow({ //인포윈도우 생성!
	    content : iwContent,
	    removable : true,
	   
	});  */
	
	kakao.maps.event.addListener(marker, 'click', function() {
	      // 마커 위에 인포윈도우를 표시합니다
	      infowindow.open(map, marker);  
	});
	
	 // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 1, // 지도레벨이 어느정도 이상일때 클러스터 보일지
        disableClickZoom: true
    });
	 
    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
        if(level<=2){
        	disableCLickZoom: false
        }else{
        	// 현재 지도 레벨에서 1레벨 확대한 레벨
            var level = map.getLevel()-2;
            // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
            map.setLevel(level, {anchor: cluster.getCenter()});	
        }
    	
    });
	 
	
	 $.get("${pageContext.request.contextPath}/searchDrugStore"
			,{lat:$("#lat").val(), lon:$("#lon").val()}
			,function(datas, status){
			$("tbody").empty(); //테이블 초기화
	           
	        $.each(datas, function(index, vo) {
	           let str = "<tr class="+colorArr[index%3]+">"
	           + "<td>" + vo.drugstoreName + "</td>"
	           + "<td>" + vo.drugstoreAddress + "</td>"
	           + "<td>" + vo.phoneNum + "</td></tr>"
	           $("tbody").append(str);
	           
	        });

	        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	        var markers = $(datas).map(function(i, data) {
	        	
	        	var marker = new kakao.maps.Marker({
	                position : new kakao.maps.LatLng(data.lat, data.lng),
	     			title:data.drugstoreName, //marker.mc에 title담기는거같음
	     			image:markerImage,
	     			clickable:true //마커 클릭시 지도 동작x
	            });
	        	
	        	//인포윈도우 만들기
	        	var iwContent = '<div class="card" style="width:200px">' +
	    		'<div class="card-body">' +
	    		'<h4 class="card-title">'+marker.drugstoreName+'</h4>' +
	    		'<p class="card-text">'+marker.phoneNum+'</p>' +
	    		'<a href="https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query='+marker.mc+'" class="btn btn-primary">검색</a>' +
	    		'<a href="http://naver.com" class="btn btn-primary">가시는길</a>' +
	    		'</div>' +
	    		'</div>';
	    		 
	        	
	        	var infowindow = new kakao.maps.InfoWindow({ //인포윈도우 생성!
	        	    content : iwContent,
	        	    removable : true,
	        	   
	        	}); 
	        	kakao.maps.event.addListener(marker, 'click', function() {
	        	      // 마커 위에 인포윈도우를 표시합니다
	        	      infowindow.open(map, marker);  
	        	});
	        	
// 	        	console.log(marker);
// 	        	console.log(marker.mc);
	        	return marker;	        	
	        });

	        // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers);
	        console.log(clusterer);
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
		initMap();				
	});//change
});//ready

</script>
<input type="hidden" id="lat"/>
<input type="hidden" id="lon" />
	시도 : <select id="sido"> <option value="0">선택</option></select>
	구군 : <select id="gugun"> <option value="0">선택</option></select>
	읍면동 : <select id="dong"><option value="0">선택</option></select>
	<!-- map start -->
<div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
<!-- map end -->
<table class="table mt-2">
	<thead>
		<tr>
			<th>약국명</th>
			<th>약국주소</th>
			<th>전화번호</th>
		</tr>
	</thead>
	<tbody>
	<!--  여기에 결과 들어감 -->
	</tbody>
</table>
<!-- here end -->


				</div>
			</div>
		</section>
	</div>

<!-- Footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>
