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
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBJ3iLRNnx8MpswGdoR69UQOtGSQltPDZQ"></script>
<body>

<%@ include file="header.jsp" %>
  
<div class="w3-display-container w3-content w3-wide" style="margin-bottom:10px;max-width:1500px;">
   <div class="background-primary padding text-center" style="background-image: URL(../img/bar_img2.jpg);">
        <h2 class="text-size-50 text-center">지도로 아파트 검색</h2>                                                                       
   </div>
   <section id="index_section" style="margin-top:50px;">
<!-- here start -->
<script>
var map;
let loc_lat;
let loc_lon;   

//위치변경
function setCenter(lat, lng) {            
   // map.setCenter(moveLatLon);
   map.setLevel(1, {anchor: new kakao.maps.LatLng(lat, lng)});
   map.setCenter(map.getCenter());
}
$(document).ready(function() {
   
   navigator.geolocation.getCurrentPosition(function(position) {
         var lat = position.coords.latitude, // 위도
             lon = position.coords.longitude; // 경도    
             $("#lat").val(lat);
             $("#lon").val(lon); 
             loc_lat=lat;
             loc_lon=lon;
            
             initMap();
    });
});
function initMap(){
   
   let cur_loc;
   
    // 현재위치 마커    
    var geocoder = new kakao.maps.services.Geocoder();
    searchDetailAddrFromCoords(
          new kakao.maps.LatLng($("#lat").val(), $("#lon").val()), 
          function(result, status) {
             if (status === kakao.maps.services.Status.OK) {
                if(result[0].road_address==null)   {
                   $("#doro").val(result[0].address.address_name); 
                   cur_loc = result[0].address.address_name;
                }else {
                   $("#doro").val(result[0].road_address.address_name);    
                   cur_loc = result[0].road_address.address_name;
                }  
            }
          }
    );   
    function searchDetailAddrFromCoords(coords, callback) {
       // 좌표로 법정동 상세 주소 정보를 요청합니다
       geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);     
    }
   
   
     
     
   //마커 이미지!
   var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
   var imageSize = new kakao.maps.Size(24, 35);
   var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
   
   var ssafyLogo = "/img/ssafylogo.png";
   var ssafySize = new kakao.maps.Size(50, 30);
   var ssafy = new kakao.maps.MarkerImage(ssafyLogo,ssafySize);   
   var multi = new kakao.maps.LatLng(37.5012743, 127.039585);
   map = new kakao.maps.Map(document.getElementById('map'), {
      center : multi, // 지도의 중심좌표
      level : 10   // 지도의 확대 레벨
   });
   
   //싸피 마커
   var ssafymarker = new kakao.maps.Marker({
      position : multi,
      map : map,
      image:ssafy
   });      

      
    var ssafyiwContent = '<div class="card" style="width:200px; text-align: center;">' +
   '<img id="imgView" src = "/img/ssafy.jpg" class="card-img-top" width="200px" height="200px">' +
      '<div class="card-body background-primary">' +
      '<h4 class="card-title" >SSAFY</h4>' +
      '<a href="https://map.kakao.com/?sName='+$("#doro").val()+'&eName=역삼동 멀티캠퍼스" class="button button-white-stroke text-size-12" style="margin-top:10px;" target="_blank">가시는 길</a>' +
      '</div>' +
      '</div>';
    
   var ssafyinfowindow = new kakao.maps.InfoWindow({ //인포윈도우 생성!
       content : ssafyiwContent,
       removable : true,
      
   }); 
   
   kakao.maps.event.addListener(ssafymarker, 'click', function() {
         // 마커 위에 인포윈도우를 표시합니다
         ssafyinfowindow.close();
         ssafyinfowindow.open(map, ssafymarker);  
   });
   
   
   
   var my_loc = new kakao.maps.LatLng($("#lat").val(),$("#lon").val());
   
   
   //현재위치 마커   
    var my_marker = new kakao.maps.Marker({  
        map: map, 
        position: my_loc,
        image:markerImage
    }); 

    // 커스텀 오버레이를 생성합니다
    var customOverlay = new kakao.maps.CustomOverlay({
        position: my_loc,
        content: '<div class ="label"><span class="center" style="letter-spacing: 1px; font-family: NanumGothic,\'Malgun Gothic\',dotum,\'돋움\',sans-serif; color: #333; le">현재위치   </span><span class="right"></span></div>'   
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
           map.setCenter(cluster.getCenter());
        }else{            
            // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
            map.setLevel(level-2, {anchor: cluster.getCenter()});
            map.setCenter(cluster.getCenter());
        }       
        
    });

   
    $.get("${pageContext.request.contextPath}/fsel/apt"
         ,{dong:$("#dong").val()}
         ,function(datas, status){
         
         $("tbody").empty(); //테이블 초기화
              
           $.each(datas, function(index, vo) {
              let str = "<tr onclick='setCenter("+vo.lat+","+ vo.lng +")'>"
              + "<td>" + vo.no + "</td>"
              + "<td>" + vo.dong + "</td>"
              + "<td>" + vo.aptName + "</td>"
              + "<td>" + vo.floor + "</td>"
              + "<td>" + vo.dealAmount + "</td></tr>"
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
              //인포윈도우 만들기 - 마커용
              var iwContent = '<div class="card" style="width:250px; text-align: center;">' +
             '<img id="imgView" src = "/img/'+marker.getTitle()+'.jpg" onerror="src=\'/img/그림1.jpg\'" class="card-img-top" width="200px" height="200px">' +
             '<div class="card-body background-primary">' +
             '<h4 class="card-title" style="letter-spacing:1px;" >'+marker.getTitle()+'</h4>' +             
             '<p class="card-text" style="margin-bottom: 0.75rem;">현재 매물층 :'+data.floor+'</p>' +
             '<p class="card-text">거래가격 :'+data.dealAmount+'</p>' +
             '<a href="https://new.land.naver.com/search?sk='+data.dong+marker.getTitle()+'" class="button button-white-stroke text-size-12" target="_blank">매물보러가기</a>' +
             '<a href="https://map.kakao.com/?sName='+$("#doro").val()+'&eName='+data.dong+marker.getTitle()+'" class="button button-white-stroke text-size-12" style="margin-top:10px;" target="_blank">가시는 길</a>' +
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
              
              
              return marker;              
           });

           // 클러스터러에 마커들을 추가합니다
           clusterer.addMarkers(markers);
       });
    
    //거리재기
   var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
   var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
   var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
   var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
   var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
   
   // 지도에 클릭 이벤트를 등록합니다
   // 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
   kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

    // 마우스로 클릭한 위치입니다 
    var clickPosition = mouseEvent.latLng;

    // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
    if (!drawingFlag) {

        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
        drawingFlag = true;
        
        // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
        deleteClickLine();
        
        // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
        deleteDistnce();

        // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
        deleteCircleDot();
    
        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
        clickLine = new kakao.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
        
        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
        moveLine = new kakao.maps.Polyline({
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다    
        });
    
        // 클릭한 지점에 대한 정보를 지도에 표시합니다
        displayCircleDot(clickPosition, 0);

            
    } else { // 선이 그려지고 있는 상태이면

        // 그려지고 있는 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();

        // 좌표 배열에 클릭한 위치를 추가합니다
        path.push(clickPosition);
        
        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
        clickLine.setPath(path);

        var distance = Math.round(clickLine.getLength());
        displayCircleDot(clickPosition, distance);
    }
});
    
// 지도에 마우스무브 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

    // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag){
        
        // 마우스 커서의 현재 위치를 얻어옵니다 
        var mousePosition = mouseEvent.latLng; 

        // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
        
        // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
        var movepath = [path[path.length-1], mousePosition];
        moveLine.setPath(movepath);    
        moveLine.setMap(map);
        
        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
            content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
        
        // 거리정보를 지도에 표시합니다
        showDistance(content, mousePosition);   
    }             
});                 

// 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

    // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag) {
        
        // 마우스무브로 그려진 선은 지도에서 제거합니다
        moveLine.setMap(null);
        moveLine = null;  
        
        // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
    
        // 선을 구성하는 좌표의 개수가 2개 이상이면
        if (path.length > 1) {

            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
            if (dots[dots.length-1].distance) {
                dots[dots.length-1].distance.setMap(null);
                dots[dots.length-1].distance = null;    
            }

            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
                
            // 그려진 선의 거리정보를 지도에 표시합니다
            showDistance(content, path[path.length-1]);  
             
        } else {

            // 선을 구성하는 좌표의 개수가 1개 이하이면 
            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
            deleteClickLine();
            deleteCircleDot(); 
            deleteDistnce();

        }
        
        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
        drawingFlag = false;          
    }  
});    

// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);    
        clickLine = null;        
    }
}

// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
function showDistance(content, position) {
    
    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
        
        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
        
    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
        
        // 커스텀 오버레이를 생성하고 지도에 표시합니다
        distanceOverlay = new kakao.maps.CustomOverlay({
            map: map, // 커스텀오버레이를 표시할 지도입니다
            content: content,  // 커스텀오버레이에 표시할 내용입니다
            position: position, // 커스텀오버레이를 표시할 위치입니다.
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3  
        });      
    }
}

// 그려지고 있는 선의 총거리 정보와 
// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
function displayCircleDot(position, distance) {

    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
    var circleOverlay = new kakao.maps.CustomOverlay({
        content: '<span class="dot"></span>',
        position: position,
        zIndex: 1
    });

    // 지도에 표시합니다
    circleOverlay.setMap(map);

    if (distance > 0) {
        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
        var distanceOverlay = new kakao.maps.CustomOverlay({
            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
            position: position,
            yAnchor: 1,
            zIndex: 2
        });

        // 지도에 표시합니다
        distanceOverlay.setMap(map);
    }

    // 배열에 추가합니다
    dots.push({circle:circleOverlay, distance: distanceOverlay});
}

// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
function deleteCircleDot() {
    var i;

    for ( i = 0; i < dots.length; i++ ){
        if (dots[i].circle) { 
            dots[i].circle.setMap(null);
        }

        if (dots[i].distance) {
            dots[i].distance.setMap(null);
        }
    }

    dots = [];
}

// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {

    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
    var walkkTime = distance / 67 | 0;
    var walkHour = '', walkMin = '';

    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
    if (walkkTime > 60) {
        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
    }
    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
    var bycicleTime = distance / 227 | 0;
    var bycicleHour = '', bycicleMin = '';

    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
    if (bycicleTime > 60) {
        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
    }
    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
    var content = '<ul class="dotOverlay distanceInfo">';
    content += '    <li style="height:15px; letter-spacing:1px;">';
    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
    content += '    </li>';
    content += '    <li style="height:15px; letter-spacing:1px;">';
    content += '        <span class="label">도보 </span>' + walkHour + walkMin;
    content += '    </li>';
    content += '    <li style="height:15px; letter-spacing:1px;">';
    content += '        <span class="label">자전거 </span>' + bycicleHour + bycicleMin;
    content += '    </li>';
    content += '</ul>'

    return content;
}
}
   
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
               $("#gugun").append('<option value="0">구 / 군</option>');
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
               $("#dong").append('<option value="0">읍 / 동 / 면</option>');
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
            <form class="customform" style="margin-bottom:30px; text-align-last:center;">
               <select id="sido"  style="margin-bottom:0; font-size:15px; width:32%;"><option value="0">시 / 도</option></select>
               <select id="gugun" style="margin-bottom:0; font-size:15px; width:32%;"><option value="0">구 / 군</option></select>
               <select id="dong" style="margin-bottom:0; font-size:15px; width:32%;"> <option value="0">읍 / 면 / 동</option></select>
            </form>
            <input type="hidden" id="lat"/>
            <input type="hidden" id="lon" />
            <input type="hidden" id="doro" />
            <!-- map start -->
            <div id="map" style="width: 100%; height: 500px; margin: auto;"></div>
            <!-- map end -->
            <table class="table" style="margin-bottom: 50px;margin-top:30px; font-size:16px; width:100%; text-align:center; ">
               <thead class="thead-dark">
                  <tr>
                     <th width="5%">번호</th>
                     <th width="20%">법정동</th>
                     <th width="50%">아파트이름</th>
                     <th width="5%">층</th>
                     <th width="20%">거래가격</th>
                  </tr>
               </thead>
               <tbody>
               <!--  여기에 결과 들어감 -->
               </tbody>
            </table>
<!-- here end -->
   </section>
</div>

<!-- Footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
  <style>
  /*//////////////////////////////////////////////////////////////////
[ Table ]*/

.limiter {
  width: 100%;
  margin: 0 auto;
}

.container-table100 {
  width: 100%;
  min-height: 100vh;
  background: #c850c0;
  background: -webkit-linear-gradient(45deg, #4158d0, #c850c0);
  background: -o-linear-gradient(45deg, #4158d0, #c850c0);
  background: -moz-linear-gradient(45deg, #4158d0, #c850c0);
  background: linear-gradient(45deg, #4158d0, #c850c0);

  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;
  padding: 33px 30px;
}

.wrap-table100 {
  width: 1170px;
}

table {
  border-spacing: 1;
  border-collapse: collapse;
  background: white;
  border-radius: 10px;
  overflow: hidden;
  width: 100%;
  margin: 0 auto;
  position: relative;
}
table * {
  position: relative;
}
table td, table th {
  padding-left: 8px;
}
table thead tr {
  height: 50px;
  background: #36304a;
}
table tbody tr {
  height: 50px;
}
table tbody tr:last-child {
  border: 0;
}

table th, table td {
  text-align: center;
}

.table100-head th{
  font-family: OpenSans-Regular;
  font-size: 18px;
  color: #fff;
  line-height: 1.2;
  font-weight: unset;
}

tbody tr:nth-child(even) {
  background-color: #f5f5f5;
}

tbody tr {
  font-family: OpenSans-Regular;
  font-size: 15px;
  color: #808080;
  line-height: 1.2;
  font-weight: unset;
}

tbody tr:hover {
  color: #555555;
  background-color: #f5f5f5;
  cursor: pointer;
}
  
.label {margin-bottom: 96px;}
.label * {display: inline-block;vertical-align: top;}
.label .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px; letter-spacing:0px;}
.label .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
li .label{
   line-height: 1.6;
    font-family: NanumGothic,'Malgun Gothic',dotum,'돋움',sans-serif;
    color: #333;
    }
</style>
</html>