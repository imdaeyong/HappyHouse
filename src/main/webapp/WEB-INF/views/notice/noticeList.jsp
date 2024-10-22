<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<%
	String contextPath = request.getContextPath();
%>

<%--
<c:if test="${userinfo == null}">
	<c:redirect url="/main.do"/>
</c:if>
<c:if test="${userinfo != null}">
--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>공지사항</title>
<meta charset="utf-8">
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

	function searchNotice() {
		var key = document.getElementById("key").value;
		var word = document.getElementById('word').value
		var dataList = { "key" : key, "word" : word };
		if (key == "noticeno") {
			if (isNaN(word) == true) {
				alert("숫자를 입력해주세요");
				return;
			}
		}
		if (word == "") {
			alert("모든 목록 조회!!");
			list();
			return;
		}
		
		$.ajax({
	        type : 'get',
	        url : '<%=contextPath%>/noticeSearch',
	        dataType : 'json',
	        data : dataList,
	        success : function(data, status, xhr) { 

	        	makeListHtml(data);
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
	        }
	    });
		
	}


	$(document).ready(function() {
		list();
	});
	
	function list(){
		$.ajax(
		{
	        type : 'get',
	        url : '<%=contextPath%>/notice',
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

		$("#noticeBody").html("");

		for( var i=0; i<list.length; i++){
			
			var content = list[i].content;
			var id = list[i].id;
			var noticeno = list[i].noticeno;
			var regtime = list[i].regtime;
			var subject = list[i].subject;
			
			var listHtml =
				'<tr style="cursor:pointer" data-id=' + noticeno +'><th>' + noticeno + '</th><td>' + subject + '</td><td>' + id + '</td></tr>';

			$("#noticeBody").append(listHtml);
		}

		makeListHtmlEventHandler();
	}
	
	function makeListHtmlEventHandler(){
		$("#noticeBody tr").click(function(){
			var noticeno = $(this).attr("data-id");
			detail(noticeno);
		});
	}
	
	function detail(noticeno){
			
		
	 	$.ajax(
		{
	        type : 'get',
	        url : '<%=contextPath%>/notice/' + noticeno,
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
		var content = detail.content;
		var id = detail.id;
		var noticeno = detail.noticeno;
		var regtime = detail.regtime;
		var subject = detail.subject;

		
		$("#detail_regtime").html(regtime);
		$("#detail_content").val(content);
		$("#detail_id").html(id);
		$("#detail_noticeno").html(noticeno);
		$("#detail_subject").val(subject);

		$('#noticeModal').modal('show');
	}

	function deleteNotice(){
		var noticeno = $("#detail_noticeno").text();
		$.ajax(
		{
	        type : 'delete',
	        url : '<%=contextPath%>/notice/' + noticeno,
	        dataType : 'json',
	        data : 
			{
			},
	        success : function(data, status, xhr) { 
	        	list();
	        	$('#noticeModal').modal('hide');
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
	        }
	    });
	}	
	function showModifyModal(){
		var noticeno = $("#detail_noticeno").text();
		$.ajax(
				{
			        type : 'get',
			        url : '<%=contextPath%>/notice/' + noticeno,
			        dataType : 'json',
			        data : 
					{
					},
			        success : function(data, status, xhr) { 

			        	makeModifyHtml(data);
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) 
			        { 
			        	console.log(jqXHR.responseText); 
			        }
			    });
	}
	function makeModifyHtml(detail){
		var content = detail.content;
		var id = detail.id;
		var noticeno = detail.noticeno;
		var regtime = detail.regtime;
		var subject = detail.subject;


		
		$("#modify_regtime").val(regtime);
		$("#modify_content").val(content);
		$("#modify_id").val(id);
		$("#modify_noticeno").val(noticeno);
		$("#modify_subject").val(subject);
		$("#modify_noticeno2").html(noticeno);

		$('#modifyModal').modal('show');
	}
	
	function modifyNotice() {
		var notice = { subject: $("#modify_subject").val() , content: $("#modify_content").val(), id: $("#modify_id").val(), noticeno: $("#modify_noticeno").val() };
		if(document.getElementById("modify_subject").value == "") {
			alert("제목 입력!!!!");
			return;
		} else if(document.getElementById("modify_content").value == "") {
			alert("내용 입력!!!!");
			return;
		} else {
			$.ajax(
			{
		        type : 'put',
		        url : '<%=contextPath%>/notice/'+ $("#modify_noticeno").val(),
		        dataType : 'json',
		        data :JSON.stringify( notice ),
		        contentType : 'application/json',
		        success : function(data, status, xhr) { 
		        	$('#noticeModal').modal('hide');
		        	$('#modifyModal').modal('hide');
		        	list();
		        }, 
		        error: function(jqXHR, textStatus, errorThrown) 
		        { 
		        	console.log(jqXHR.responseText); 
		        }
		    });
		}
	  }
</script>
</head>
<body>
	<%@ include file="../header.jsp"%>

	<div class="w3-display-container w3-content w3-wide" style="margin-bottom:10px;max-width:1500px;">
		<div align="center">
			<div class="background-primary padding text-center" style="background-image: URL(../img/bar_img2.jpg);">
		        <h2 class="text-size-50 text-center">공지사항</h2>                                                                       
			</div>
			<form id="searchform" method="get" class="form-inline" action="">
				<input type="hidden" name="act" id="act" value="search">
				<table class="table table-borderless">
					<tr>
						<td align="right"><select class="form-control" name="key" id="key">
								<option value="noticeno" selected="selected">글번호</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
						</select> <input type="text" class="form-control" placeholder="검색어 입력" name="word" id="word">
							<button type="button" class="btn btn-primary" onclick="javascript:searchNotice();">검색</button>
							<a class="button btn text-size-12" href="${root}/moveNotice">글쓰기</a>
						</td>
					</tr>
				</table>
			</form>
			<table class="table" style="margin-bottom: 50px; font-size:16px; width:100%">
				<thead class="thead-dark">
					<tr>
						<th width="10%">번 호</th>
						<th width='60%'>제 목</th>
						<th width="30%">작 성 자</th>
					</tr>
				</thead>
				<tbody id="noticeBody">
				</tbody>
			</table>
		</div>
	</div>
	<%@ include file="../footer.jsp"%>

</body>

<div class="modal fade" id="noticeModal"  tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">공지사항 상세내용(<label for="" id="detail_noticeno"></label>)</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body mx-3">
        	<div class="form-group" align="right">
				<label for="">작성자 : </label>
				<label for="" id="detail_id"></label>
			</div>
        	<div class="form-group" align="right">
				<label align="right" for="">작성일 : </label>
				<label for="" id="detail_regtime"></label>
			</div>
        	<div class="form-group" align="left">
			<label for="">제목</label>
				<input type="text" class="form-control subject" id="detail_subject" readonly>
			</div>
        	<div class="form-group" align="left">
			<label for="">내용</label>
				<input type="text" class="form-control subject" id="detail_content" readonly>
			</div>
      </div>
      <div class="modal-footer d-flex justify-content-center">
        <button type="button" class="btn btn-primary" onclick="javascript:showModifyModal();">수정</button>
		<button type="button" class="btn btn-danger" onclick="javascript:deleteNotice()" >삭제</button>
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="modifyModal"  tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">공지사항 수정(<label for="" id="modify_noticeno2"></label>)</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body mx-3">
      		<input type="hidden" name="modify_id" id="modify_id">
			<input type="hidden" name="modify_regtime" id="modify_regtime">
			<input type="hidden" name="modify_noticeno" id="modify_noticeno">
        	<div class="form-group" align="left">
			<label for="">제목</label>
				<input type="text" class="form-control subject" id="modify_subject" name="modify_subject">
			</div>
        	<div class="form-group" align="left">
			<label for="">내용</label>
				<textarea rows="6" class="form-control subject" id="modify_content" name="modify_content" style="resize:none;"></textarea>
			</div>
      </div>
      <div class="modal-footer d-flex justify-content-center">
        <button type="button" class="btn btn-primary" onclick="javascript:modifyNotice();">공지수정</button>
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

</html>