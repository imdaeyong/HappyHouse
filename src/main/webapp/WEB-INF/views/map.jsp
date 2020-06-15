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
  
<div class="w3-display-container w3-content w3-wide" style="margin-bottom:10px;max-width:1500px;">
	<div class="background-primary padding text-center">
        <h2 class="text-size-50 text-center">지도로 아파트 검색</h2>                                                                              
	</div>
	<section id="index_section">
		<div class="card col-sm-12 mt-1">
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
	var map; //맵 생성, 센터 잡아주기
		
	//마커 이미지!
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var imageSize = new kakao.maps.Size(24, 35);
	var ssafySize = new kakao.maps.Size(50, 30);
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	
	var ssafyLogo = "/img/ssafylogo.png";
	var ssafy = new kakao.maps.MarkerImage(ssafyLogo,ssafySize);	
	var multi = new kakao.maps.LatLng(37.5012743, 127.039585);
	var map = new kakao.maps.Map(document.getElementById('map'), {
		center : multi, // 지도의 중심좌표
		level : 10	// 지도의 확대 레벨
	});
	
	var marker = new kakao.maps.Marker({
		position : multi,
		map : map,
		image:ssafy
	});
	
	var iwContent = '<div class="card" style="width:200px; text-align: center;">' +
	'<img id="imgView" src = "/img/ssafy.jpg" class="card-img-top" width="200px" height="200px">' +
	   '<div class="card-body background-primary">' +
	   '<h4 class="card-title" >SSAFY'+'</h4>' +
	   '<a href="https://map.kakao.com/link/to/SSAFY,37.5012743, 127.039585" class="button button-white-stroke text-size-12" target="_blank">가시는 길</a>' +
	   '</div>' +
	   '</div>';
	 
	
	var infowindow = new kakao.maps.InfoWindow({ //인포윈도우 생성!
	    content : iwContent,
	    removable : true,
	   
	}); 
	
	kakao.maps.event.addListener(marker, 'click', function() {
	      // 마커 위에 인포윈도우를 표시합니다
	      infowindow.close();
	      infowindow.open(map, marker);  
	});
	
	var my_loc = new kakao.maps.LatLng($("#lat").val(),$("#lon").val());
	
	  // 마커를 생성합니다
    var my_marker = new kakao.maps.Marker({  
        map: map, 
        position: my_loc,
        image:markerImage
    }); 

	 // 커스텀 오버레이를 생성합니다
    var customOverlay = new kakao.maps.CustomOverlay({
        position: my_loc,
        content: '<div class ="label"><span class="left"></span><span class="center">현재위치! </span><span class="right"></span></div>'   
    });

    // 커스텀 오버레이를 지도에 표시합니다
    customOverlay.setMap(map);
	
	 // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 2, // 지도레벨이 어느정도 이상일때 클러스터 보일지
        disableClickZoom: true
    });
	
	 
    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
    	var level = map.getLevel();
        if(level<=2){
        	map.setLevel(1);        	
        }else{            
            // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
            map.setLevel(level-2, {anchor: cluster.getCenter()});
        }    	
        
    });
	 
	
	 $.get("${pageContext.request.contextPath}/fsel/apt"
			,{dong:$("#dong").val()}
			,function(datas, status){
			console.log("아파트리스트확인");
			console.log(datas);
			
			$("tbody").empty(); //테이블 초기화
	           
	        $.each(datas, function(index, vo) {
	           let str = "<tr>"
	           + "<td>" + vo.no + "</td>"
	           + "<td>" + vo.dong + "</td>"
	           + "<td>" + vo.aptName + "</td>"
	           + "<td>" + vo.floor + "</td>"
	           + "<td>" + vo.dealAmount + "</td>"
	           + "<td>" + vo.lng + "</td></tr>"
	           $("tbody").append(str);
	           
	        });

	        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	        var markers = $(datas).map(function(i, data) {
	        	
	        	var marker = new kakao.maps.Marker({
	                position : new kakao.maps.LatLng(data.lat, data.lng),
	     			title:data.aptName, //marker.mc에 title담기는거같음
	     			image:markerImage,
	     			clickable:true //마커 클릭시 지도 동작x
	            });
	        	var marker_infos =[
	        		{dealAmount:data.dealAmount},
	        		{floor:data.floor},	        
	        		{marker:marker}	        		
	        	];
	        	console.log(marker_infos);
	        	//인포윈도우 만들기 - 마커용
	        	var iwContent = '<div class="card" style="width:200px; text-align: center;">' +
	    		'<img id="imgView" src = "/img/'+marker.getTitle()+'.jpg" onerror="src=\'/img/그림1.jpg\'" class="card-img-top" width="200px" height="200px">' +
	    		'<div class="card-body background-primary">' +
	    		'<h4 class="card-title" >'+marker.getTitle()+'</h4>' +	    		
	    		'<p class="card-text" style="margin-bottom: 0.75rem;">현재 매물층 :'+data.floor+'</p>' +
	    		'<p class="card-text">거래가격 :'+data.dealAmount+'</p>' +
	    		'<a href="https://new.land.naver.com/search?sk='+data.dong+marker.getTitle()+'" class="button button-white-stroke text-size-12" target="_blank>매물보러가기</a>' +
	    		'<a href="https://map.kakao.com/?sName=역삼동 멀티캠퍼스'+''+'&eName='+data.dong+ marker.getTitle()+'" class="button button-white-stroke text-size-12" style="margin-top:10px; target="_blank">가시는 길</a>' +
	    		'</div>' +
	    		'</div>';
	    		 
	    		 https://map.kakao.com/?sName=’+startPoint+’&eName=’+endPoint
	        	
	        	var infowindow = new kakao.maps.InfoWindow({ //인포윈도우 생성!
	        	    content : iwContent,
	        	    removable : true,
	        	   
	        	}); 
	        	kakao.maps.event.addListener(marker, 'click', function() {
	        	      // 마커 위에 인포윈도우를 표시합니다
	        	      console.log(marker);
	        	      infowindow.open(map, marker);  
	        	});
	        	
	        	
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
				<form class="customform">
					<table class="table" style=" font-size:16px; width:100%; text-align:center;margin-bottom:0;">
						<thead class="thead-dark">
							<tr>
								<th width="33%">시도</th>
								<th width="33%">구군</th>
								<th width="33%">읍면동</th>
							</tr>
							<tr>
								<td style="padding: 0;"><select id="sido" style="margin-bottom:0;"> <option value="0">선택</option></td>
								<td style="padding: 0;"><select id="gugun" style="margin-bottom:0;"	> <option value="0">선택</option></td>
								<td style="padding: 0;"><select id="dong" style="margin-bottom:0;"> <option value="0">선택</option></td>
							</tr>
						</thead>
					</table>
				</form>
				<input type="hidden" id="lat"/>
	<input type="hidden" id="lon" />
				<!-- map start -->
				<div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
				<!-- map end -->
				<table class="table" style="margin-bottom: 50px; font-size:16px; width:100%">
					<thead class="thead-dark">
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
			</div>
		</div>
	</section>
</div>

<!-- Footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>
