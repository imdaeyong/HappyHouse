<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="../css/components.css">
	<link rel="stylesheet" href="../css/icons.css">
	<link rel="stylesheet" href="../css/responsee.css">
	<link rel="stylesheet" href="../owl-carousel/owl.carousel.css">
	<link rel="stylesheet" href="../owl-carousel/owl.theme.css">     
	<link rel="stylesheet" href="../css/template-style.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
	<%@ include file="../header.jsp"%>
	<div class="container">
		<section>
		<div>
			<div class="container">
				<div class="mt-2 mb-2">
				</div>
			</div>
		</div>
		</section>
		<!-- End Breadcrumbs -->
		<!-- section start -->
		<section id="index_section">
			<div  style="min-height: 850px; width:100%;">
				<div class="card-body">

<!-- here start -->
<script>
$(document).ready(function(){
	$.get("${pageContext.request.contextPath}/fav.do"
		,{act:"callSi"}
		,function(data, status){
			$.each(data, function(index, vo) {
				$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
			});//each
		}//function
		, "json"
	);//get
});//ready
$(document).ready(function(){
	$("#dong").change(function() {
		$.get("${pageContext.request.contextPath}/fsel/search"
				,{dong:$("#dong").val()}
				,function(data, status){
					$("#searchResult").empty();
					geocode(data);
				}//function
				, "json"
		);//get
	});//change
});//ready
function searchEnv(d){
	$.get("${pageContext.request.contextPath}/fav.do",{
			act : "searchEnv",
			dong : d},
			function(data,status) {
				$("#title").html(d+" 환경점검 정보");
				var str="";
				$.each(data, function(index, vo) {
					str+="<tr><td>";
					str+=vo.name
					str+="</td><td>";
					str+=vo.address
					str+="</td></tr>";
				});
				
				$("#modal_table tbody").html(str);
				$('#myModal').modal('show');
			}
	, "json");
}

function searchComm(d){
	$.get("${pageContext.request.contextPath}/fav.do",{
			act : "searchComm",
			dong : d},
			function(data, vo) {
				geocode(data);
			}
	, "json");
}
function geocode(jsonData) {
	let idx = 0;
	$.each(jsonData, function(index, vo) {
		let tmpLat;
		let tmpLng;
		https://maps.googleapis.com/maps/api/js?key="  type="text/javascript">
		$.get("https://maps.googleapis.com/maps/api/geocode/json"
				,{	key:'AIzaSyAGZLKaqO2wNo1-9kK4lceD2tGARAlNVoA'
					, address:vo.doro+"+"+vo.ShopName+"+"+vo.jibun
				}
				, function(data, status) {
					
					//alert(data.results[0].geometry.location.lat);
					tmpLat = data.results[0].geometry.location.lat;
					tmpLng = data.results[0].geometry.location.lng;
					$("#lat_"+index).text(tmpLat);
					$("#lng_"+index).text(tmpLng);
					addMarker(tmpLat, tmpLng, vo.ShopName);
				}
				, "json"
		);//get
	});//each
}
				</script>
				<div class="row">
					<aside class="col-lg-3 order-lg-1">
						<div class="sidebar">
							<div class="block clearfix">
								<c:if test="${dongs.size()  ne null  }">
									<h3 class="title">관심 지역 목록</h3>
									<a href="${root}/user/favRegist.jsp">관심 지역 등록</a>
									<div class="media margin-clear" style="margin-top: 10px;">
										<c:forEach var="dong" items="${dongs}">
											<li class="media">
												<div class="btn-group-vertical" style="white-space: nowrap; margin: 10px;">
													<button class="btn btn-secondary" style="background-color:gray;pointer-events: none;">${dong}</button>
													<button type="button" class="btn btn-success" onclick="searchEnv('${dong}');" >환경점검 정보</button>
													<button type="button" class="btn btn-success" onclick="searchComm('${dong}');" >업종 정보</button>
													<button type="button" class="btn btn-success" onclick="location.href='fav.do?act=delete&dong=${dong}&id=${userinfo.id}'" ><i class="fa fa-user pr-2"></i>삭제</button> 
												</div>
											</li>
										</c:forEach>
									</div>
								</c:if>
							</div>
						</div>
						<div class="block clearfix" id="houseInfo"></div>
					</aside>
					<!-- sidebar end -->
				</div>

<!-- here end -->
<!-- map start -->
				 <button onclick="deleteMarkers();" class="btn btn-danger" >초기화</button>
				<div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
					<script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
					<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGZLKaqO2wNo1-9kK4lceD2tGARAlNVoA&callback=initMap"  type="text/javascript"></script>
					<script>
						var multi = {lat: 37.5665734, lng: 126.978179};
						var map;
						var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
						var marker;
						function initMap() {
							map = new google.maps.Map(document.getElementById('map'), {
								center: multi, zoom: 12
							});
						}
						function addMarker(tmpLat, tmpLng, ShopName) {
							var marker = new google.maps.Marker({
								position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
								label: ShopName,
								title: ShopName
							});
							marker.addListener('click', function() {
								map.setZoom(17);
								map.setCenter(marker.getPosition());
								callHouseDealInfo();
							});
							marker.setMap(map);
						}
						function deleteMarkers() {
							initMap();
					     }
						function callHouseDealInfo() {
							alert("you can call HouseDealInfo");
						}
					</script>
<!-- map end -->

				</div>
			</div>
		</section>
		<!-- section end -->
<!-- 		<footer class="col-ms-12 bg-dark rounded mt-1"></footer> -->
	</div>
</body>

<div class="modal fade" id="myModal">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<table id="modal_table">
	        	<thead>
	        		<tr>
	        			<th>상호명</th>
	        			<th>주소</th>
	        		</tr>
        		</thead>
        		<tbody>
        		</tbody>
        	</table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
</html>
