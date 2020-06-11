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
<script type="text/javascript" src="../js/jquery-ui.min.js"></script>

<style>
  .w3-border-right {
    width: 100px;
  }
  .w3-bar-item {
    margin-right: 5px;
  }
  #nav {
  margin : 0 auto;
  }
  #deal td {
  	text-overflow:ellipsis;
  	white-space: nowrap;
  }

</style>

<script type="text/javascript">

$(document).ready(function() {
	list();	  
});
function search(){
	 var aptdeal =  document.getElementById("aptdeal").value;
	 var aptrent =  document.getElementById("aptrent").value;
	 var housedeal =  document.getElementById("housedeal").value;
	 var houserent =  document.getElementById("houserent").value;
	 var searchsel =  document.getElementById("searchsel").value;
	 var searchtext =  document.getElementById("searchtext").value;
	 var pg =  document.getElementById("pg").value;
	
	 var datas = {"aptdeal" : aptdeal,
			 	  "aptrent" : aptrent,
			 	  "housedeal" : housedeal,
			 	  "houserent" : houserent,
			 	  "searchsel" : searchsel,
			 	  "searchtext" : searchtext,
			 	  "pg" : pg
			 	  }
	 
   	$.ajax(
   	{
         type : 'get',
         url : '<%=contextPath%>/house/list',
         dataType : 'json',
         data : datas,
         success : function(data, status, xhr) { 

            makeListHtml(data);
         }, 
         error: function(jqXHR, textStatus, errorThrown) 
         { 
            console.log(jqXHR.responseText); 
         }
     });
 }
function list(){
    $.ajax(
    {
         type : 'get',
         url : '<%=contextPath%>/house/list',
         dataType : 'json',
         data : 
       {
       },
         success : function(data, status, xhr) { 

            makeListHtml(data);
         }, 
         error: function(jqXHR, textStatus, errorThrown) 
         { 
            console.log(jqXHR.responseText); 
         }
     });
 }
function makeListHtml(list){

	$("#tbodyHouse").html("");

	for( var i=0; i<list.length; i++){
		
		var no = list[i].no;
		var dong = list[i].dong;
		var aptName = list[i].aptName;
		var dealAmount = list[i].dealAmount;
		var type = list[i].type;
		
		var listHtml =
			'<tr id="deal'+ no +'"style="cursor:pointer" data-id=' + no +'><td>' 
			+ no + '</td><td>' + dong + '</td><td>' 
			+ aptName 
			+ '</td><td>' + dealAmount + '</td><td>' + type +'</td></tr>';

		$("#tbodyHouse").append(listHtml);		
	}
	makeListHtmlEventHandler();
}
function makeListHtmlEventHandler(){
	$("#tbodyHouse tr").click(function(){
		var no = $(this).attr("data-id");
		detail(no);
	});
}

function detail(no){
	$.ajax(
	{
        type : 'get',
        url : '<%=contextPath%>/house/detail/' + no,
        dataType : 'json',
        data : 
		{
		},
        success : function(data, status, xhr) { 

        	makeDetailHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(jqXHR.responseText); 
        }
    });
}
function makeDetailHtml(detail){
	console.log(detail);

	$("#houseimg").empty();
	$("#housename").empty();
	$("#housedealprice").empty();
	$("#housebuildyear").empty();
	$("#housearea").empty();
	$("#housedealdate").empty();
	$("#housedong").empty();
	$("#housejibun").empty();
	
	
	$("#houseimg").attr("src", "/img/" + detail.aptName+".jpg");
	$("#houseimg").attr("onerror", "this.src='/img/그림1.jpg'");				
	$("#housename").append(detail.aptName);
	$("#housedealprice").append(detail.dealAmount);
	$("#housebuildyear").append(detail.buildYear);
	$("#housearea").append(detail.area);
	$("#housedealdate").append(detail.dealYear).append("년");
	$("#housedealdate").append(detail.dealMonth).append("월");
	$("#housedealdate").append(detail.dealDay).append("일");	
	$("#housedong").append(detail.dong);
	$("#housejibun").append(detail.jibun);
}

</script>
<script>
 	  function pageMove(pg) { 
			document.getElementById("pg").value=pg;
			document.getElementById("searchsel").value="${searchsel}";
			document.getElementById("searchtext").value="${searchtext}";
			document.getElementById("houseForm").action = "${root}/house.do?";
			document.getElementById("houseForm").submit();
		}
 	</script>
<body>

<%@ include file="/WEB-INF/views/header.jsp"%>

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:1564px">

	<div class="background-primary padding text-center">
        <p class="h1">아파트 거래 내역 목록</p>                                                                        
	</div>
  <!-- HouseDeal Section -->
  <div class="w3-container w3-padding-32 w3-row">
  	<div class="w3-col" style="width:350px; margin-right:10px;">
  		<img class="w3-image" id="houseimg" name="houseimage" src="/img/그림1.jpg" style="width: 300px; height: 190px">
  		<table class="w3-table" style="margin-top: 20px; border-collapse: separate; border-spacing: 5px;">
			<tr>
			  <th class="w3-border-right">주택명</th>
			  <td id="housename"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">거래금액</th>
			  <td id="housedealprice"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">건축연도</th>
			  <td id="housebuildyear"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">전용면적</th>
			  <td id="housearea"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">거래일</th>
			  <td id="housedealdate"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">법정동</th>
			  <td id="housedong"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">지번</th>
			  <td id="housejibun"></td>
			</tr>
		</table>
  	</div>
  	<div class="w3-rest">	  	
	  	<div style="margin-bottom: 20px;">
	  	<form method="post" name="houseForm" id="houseForm" >	  		
	  		<div style="margin-bottom: 5px;">
		  	  <input type="checkbox" id="aptdeal" name="aptdeal" value="aptdeal" checked><label for="aptdeal" style="cursor: pointer;"> 아파트 매매 </label>
		  	  <input type="checkbox" id="aptrent" name="aptrent" value="aptrent" checked><label for="aptrent" style="cursor: pointer;"> 아파트 전월세 </label>
		  	  <input type="checkbox" id="housedeal" name="housedeal" value="housedeal" checked><label for="housedeal" style="cursor: pointer;"> 다세대, 주택 매매 </label>
		  	  <input type="checkbox" id="houserent" name="houserent" value="houserent" checked><label for="houserent" style="cursor: pointer;"> 다세대, 주택 전월세 </label>
	  		</div>
	  		
	  		<select id="searchsel" name="searchsel" style="cursor: pointer;">
			  <option value="all">--- 전체 ---</option>
			  <option value="dong">법정동</option>
			  <option value="aptname">아파트 이름</option>
			</select>
			<input type="hidden" name="pg" id="pg" value="1">
			<input type="text" id="searchtext" name="searchtext">
			<input type="button" onclick="javascript:search();" value="검색" style="cursor: pointer;">
	  	
	  	</form>
	  	</div>	  	
	  	<div style="width:100%; height:460px; overflow:auto">
		    <table class="w3-table-all w3-hoverable w3-small" style="border:1px;">
			    <thead>
			      <tr class="w3-lime">
			        <th class="w3-lime" style="position:sticky; top:0;">번호</th>
			        <th class="w3-lime" style="position:sticky; top:0;">법정동</th>
			        <th class="w3-lime" style="position:sticky; top:0;">아파트이름</th>
			        <th class="w3-lime" style="position:sticky; top:0;">거래금액</th>
			        <th class="w3-lime" style="position:sticky; top:0;">거래종류</th>
			      </tr>
			    </thead>

			    <tbody id="tbodyHouse">
			  	</tbody>
		  	</table>
	  	</div>
	  	<table id = "nav">
			 <tr>
			  	<td>
			  	${navigation.navigator }
			  </td>
			  </tr>
		</table>
  	</div>
  	
  </div>

<!-- End page content -->
</div>

<!-- Footer -->

<%@ include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>
