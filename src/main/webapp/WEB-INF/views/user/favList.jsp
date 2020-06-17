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
<link rel="stylesheet" href="../css/components.css">
<link rel="stylesheet" href="../css/icons.css">
<link rel="stylesheet" href="../css/responsee.css">
<link rel="stylesheet" href="../owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="../owl-carousel/owl.theme.css">     
<link rel="stylesheet" href="../css/template-style.css">
<link href='https://fonts.googleapis.com/css?family=Playfair+Display&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8cbe81440a2dc401533a67159970a3ac&libraries=services,clusterer,drawing"></script>
<body>

<%@ include file="../header.jsp" %>

<div class="w3-display-container w3-content w3-wide" style="margin-bottom:10px;max-width:1500px;">
	<div class="background-primary padding text-center" style="background-image: URL(../img/bar_img2.jpg);">
        <h2 class="text-size-50 text-center">관심지역 상권 보기</h2>                                                                       
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
	var multi = new kakao.maps.LatLng(37.5012743, 127.039585);
	map = new kakao.maps.Map(document.getElementById('map'), {
		center : multi, // 지도의 중심좌표
		level : 8	// 지도의 확대 레벨
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
        minLevel: 2, // 클러스터 할 최소 지도 레벨 
        disableClickZoom: true
    });
	 
    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
    	var level = map.getLevel();
        if(level<=2){
        	map.setLevel(1);        	
        }else{            
            // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
            map.setLevel(level-2, {anchor: cluster.getCenter()});
            map.setCenter(cluster.getCenter());
        }    	
        
    });
	 
	
    $.get("${pageContext.request.contextPath}/fsel/comm"
			,{dong:$("#dong").val()}
			,function(datas, status){
				console.log(datas);
				$("tbody").empty();
				$.each(datas, function(index, vo) {
					let str = "<tr>"
					+ "<td>" + vo.shopName + "</td>"
					+ "<td>" + vo.codeName3 + "</td>"
					+ "<td>" + vo.doro + "</td></tr>"
					//+ "<td>" + vo.lat.replace(/\"/g,'') + "</td>"
					//+ "<td>" + vo.lng.replace(/\"/g,'') + "</td></tr>"
					$("tbody").append(str);
					
				});//each
	        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	       		var markers = $(datas).map(function(i, data) {
		            var marker =  new kakao.maps.Marker({
		                position : new kakao.maps.LatLng(data.lat.replace(/\"/g,''), data.lng.replace(/\"/g,'')),
		     			label:data.shopName,
		     			title:data.shopName,
		     			image:markerImage,
		     			clickable:true,
				    });
	
		            var iwContent = '<div class="card" style="width:200px; text-align: center;">' +
		             '<div class="card-body background-primary">' +
		             '<h4 class="card-title" >'+data.shopName+'</h4>' +             
		             '<p class="card-text" style="margin-bottom: 0.75rem;">주업종 :'+data.codeName3+'</p>' +
		             '<p class="card-text">주소 :'+data.doro+'</p>' +
		             '</div>' +
		             '</div>';
	 		       
					var infowindow = new kakao.maps.InfoWindow({
		               content : iwContent,
		               removable: true
		          	});
	 		       
		            kakao.maps.event.addListener(marker, 'click', function() {
		        	      // 마커 위에 인포윈도우를 표시합니다
		        	      console.log(marker);
		        	      infowindow.open(map, marker);  
		        	});		
	            	return marker;
	       	 });
	        // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers);
	    });
}
	
let colorArr = ['table-primary','table-success','table-danger'];
var markers= [];
var locations= [];

$(document).ready(function(){
	//관심 동 리스트 가져오기
	$.ajax({
        type : 'get',
        url : '${pageContext.request.contextPath}/userFavList/' + $("#login_id").val(),
        dataType : 'json',
        data :{},
        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
        success : function(data) { 
        	$.each(data, function(index, vo) {
				$("#dong").append("<option value='"+vo.dongName+"'>"+vo.dongName+"</option>");
			});
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(jqXHR.responseText); 
        }
    });

});//ready
$(document).ready(function(){
	$("#dong").change(function() {
		initMap();				
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
	관심지역 : <form class="customform"><select  id="dong"><option value="0">선택</option></select></form>
	<!-- map start -->
	<div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
	<!-- map end -->
<table class="table" style="margin-bottom: 50px; font-size:16px; width:100%">
	<thead class="thead-dark">
		<tr>
			<th>상가명</th>
			<th>분류</th>
			<th>상가주소</th>
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
