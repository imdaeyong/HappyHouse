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
		    makeMap();
	});
 });
 
function makeMap(){
	var location = new kakao.maps.LatLng($("#lat").val(),$("#lon").val());
		//마커 이미지!
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var imageSize = new kakao.maps.Size(24, 35);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		
	map = new kakao.maps.Map(document.getElementById('map'), {
		center : location, // 지도의 중심좌표
		level : 4	// 지도의 확대 레벨
	});
	
	var marker = new kakao.maps.Marker({
		position : location,
		map : map,
		image:markerImage
	});
	
	var geocoder = new kakao.maps.services.Geocoder(), // 좌표계 변환 객체를 생성합니다
    wtmLat = $("#lat").val(), // 변환할 WTM X 좌표 입니다
    wtmLon = $("#lon").val(); // 변환할 WTM Y 좌표 입니다

	// WTM 좌표를 WGS84 좌표계의 좌표로 변환합니다
	geocoder.transCoord(wtmLon, wtmLat, transCoordCB, {
		input_coord: kakao.maps.services.Coords.WGS84, // 변환 결과로 받을 좌표계 입니다 
		output_coord: kakao.maps.services.Coords.WTM// 변환을 위해 입력한 좌표계 입니다
	});
	
	// 좌표 변환 결과를 받아서 처리할 콜백함수 입니다.
	function transCoordCB(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result[0]);
	        searchDrugStore(result[0].x, result[0].y)
	    }
	}
}

function searchDrugStore(x,y){
	 $.get("${pageContext.request.contextPath}/searchDrugStore"
			,{x:x, y:y}
			,function(datas, status){
			$("tbody").empty(); //테이블 초기화
	           
	        $.each(datas, function(index, vo) {
	           let str = "<tr class="+colorArr[index%3]+">"
	           + "<td>" + vo.drugstoreName + "</td>"
	           + "<td>" + vo.drugstoreAddress + "</td>"
	           + "<td>" + vo.phoneNum + "</td></tr>"
	           $("tbody").append(str);
	           
	        });
	        markMap(datas);        
	    });
}
function markMap(datas){
	var markers = $(datas).map(function(i, data) {
    	
        var geocoder = new kakao.maps.services.Geocoder(), // 좌표계 변환 객체를 생성합니다
	        wtmX = data.x, // 변환할 WTM X 좌표 입니다
	        wtmY = data.y; // 변환할 WTM Y 좌표 입니다

	    // WTM 좌표를 WGS84 좌표계의 좌표로 변환합니다
	    geocoder.transCoord(wtmX, wtmY, transCoordCB, {
	        input_coord: kakao.maps.services.Coords.WTM, // 변환을 위해 입력한 좌표계 입니다
	        output_coord: kakao.maps.services.Coords.WGS84 // 변환 결과로 받을 좌표계 입니다 
	    });

	    // 좌표 변환 결과를 받아서 처리할 콜백함수 입니다.
	    function transCoordCB(result, status) {

	        // 정상적으로 검색이 완료됐으면 
	        if (status === kakao.maps.services.Status.OK) {

	         // 마커를 변환된 위치에 표시합니다
	           var marker = new kakao.maps.Marker({
	                position: new kakao.maps.LatLng(result[0].y, result[0].x), // 마커를 표시할 위치입니다
	                map: map // 마커를 표시할 지도객체입니다
	           })
	         
	           var iwContent = '<div style="padding:5px;"><h4 class="card-title">'+data.drugstoreName+
	           '<p class="card-text">'+data.phoneNum+'</p>' +
	           '<a href="https://map.kakao.com/link/to/'+data.drutstoreName+','+result[0].y+','+result[0].x+'" style="color:blue" target="_blank">길찾기</a></div>', 
	           iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다
	           // 인포윈도우를 생성합니다
	           var infowindow = new kakao.maps.InfoWindow({
	               position : iwPosition, 
	               content : iwContent,
	               removable: true
	           });
	           
	           //마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	           kakao.maps.event.addListener(marker, 'click', function() {
	        	      // 마커 위에 인포윈도우를 표시합니다
	        	      infowindow.open(map, marker);  
	        	});
	        }
	    }	
    });
}
	
let colorArr = ['table-primary','table-success','table-danger'];
var markers= [];
var locations= [];

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
