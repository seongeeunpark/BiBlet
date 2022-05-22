<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/appraisalbootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/star.css">
<title>BiBlet 도서 상세/평가</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">BiBlet</a>
    <div class="collapse navbar-collapse" id="navbarColor01">
    	<div class="form-group">
       		<form action="/search" class="d-flex flex-row">
				<input class="form-control me-sm-2 flex-grow-1" type="text" name="query" id="query" value="${query}" placeholder="제목, 저자 또는 출판사 검색">
				<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
    </div>
	 <div class="col-25 col-md-20 col-lg-2 col-xl-2">
		<div class="navbar-collapse collapse show" id="navbarColor01"
			 style="float:right;">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/MyPage'">MyPage</a></li>
			</ul>
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/'">MainPage</a></li>
			</ul>
		</div>
	</div>
  </div>	
</nav>


<div style="padding-left:200px;" id="detail">	
		<div class="container">
		 	<div class="row">
			 	<div style="margin-top: 40px;" class="col-4">
					<div id="bookThumbnail"></div>
				</div>
				<div class="col-6">
				<div style="padding-top:40px; padding-left:100px;" id="comment">
					<div style="margin-top: 40px;" id="bookTitle" ></div>	
					<form:form method="post" commandName="insertCmd" onsubmit="return bookSubmit()">
					
						<div style="float: right;">
							<div style="padding-left: 30px;">독서 상태</div>
							 <select style="width:120px; height:36px;" id="option" name="option" onChange="bookStatus()" >
								<option value="none">=== 선택 ===</option>
								<option value=0>찜</option>
								<option value=1>보는 중</option>
								<option value=2>독서 완료</option>
							</select>
							<button class="btn btn-secondary my-2 my-sm-0" id='insertStatus' onclick="insertStatus()">등록</button>
							<div class="text-muted" >* 독서 완료 시에만 평가 작성이 가능합니다.</div>
						</div>
						
						<div style="padding-left: 70px; margin-top: 30px;" >평가하기</div>
							
						<div class="star-rating">
							<input type="radio" id="5-star" name="star" value=5 /> 
							<label for="5-star" class="star">&#9733;</label> 
							<input type="radio" id="4-star" name="star" value=4 /> 
							<label for="4-star" class="star">&#9733;</label> 
							<input type="radio" id="3-star" name="star" value=3 /> 
							<label for="3-star" class="star">&#9733;</label>
							<input type="radio" id="2-star" name="star" value=2 /> 
							<label for="2-star" class="star">&#9733;</label> 
							<input type="radio" id="1-star" name="star" value=1 /> 
							<label for="1-star" class="star">&#9733;</label>
						</div>
						
						<h3 style="margin-top: 20px;">코멘트</h3>
						<textarea class="form-control" rows="5" id="book_comment" name="book_comment"
						placeholder="이 작품의 대한 생각을 자유롭게 표현해주세요."></textarea>
				
				
						<div style="float: left; margin-top: 20px; margin-left: 25px;">독서 시작 날짜 : <input type="date" id="start_date" name="start_date" /></div>
						<div style="float: left; margin-top: 20px; margin-left: 25px;">독서 완료 날짜 : <input type="date" id="end_date" name="end_date" /></div>
						
						<div style="float: left; margin-top: 20px; margin-left: 145px;"> 공개 여부 :</div>
							
						<div style="float: left; margin-top: 20px; margin-left: 25px;">
							공개 <input class="form-check-input" type="checkbox" id="co_prv" name="co_prv" value="공개" onclick='checkOnlyOne(this)'/> 
						</div>
							
						<div style="float: left; margin-top: 20px; margin-left: 25px;">
						 	비공개<input class="form-check-input" type="checkbox" id="co_prv" name="co_prv" value="비공개" onclick='checkOnlyOne(this)'/>
						</div>
						
							
						<input type="hidden" name="isbn" id="isbn" value="${isbn}" /> 
						<input type="hidden" name="query" id="query" value="${query}" />
						
						<div  style="float: left; margin-top: 20px; margin-left: 200px;">
							<input class="btn btn-secondary my-2 my-sm-0" type="submit" value="코멘트 등록하기" id="writeComment" /> 
							<span id="msg" ></span>
						</div>
						
					</form:form>
					</div>
				</div>
			</div>
		</div>
		
	</div>	
	
	<div class="container">
		<div class="row">
			<div style="margin-top: 30px;" class="col"></div>
				<div style="margin-top: 30px;" class="col-11">
					<div class="card border-secondary mb-3" style="max-width: 100rem;">
					  <div class="card-header"><h4>기본 정보</h4></div>
					 	 <div class="card-body">
					 	 	<div class="card-text" id="bookInfo"></div>
						 </div>
					</div>
				</div>
			<div style="margin-top: 100px;" class="col"></div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col"></div>
				<div class="col-11">
					<div class="card text-white bg-secondary mb-3" style="max-width: 100rem;">
						<div class="card-header">
					  		<c:if test="${!empty commentCount}">
									평가 총 개수 : ${commentCount}	
							</c:if>
						</div>
						<div class="card-body">
						   <table class="table table-hover" style="width: 100%;">
						   	<thead>
							    <tr>
							      <th scope="col"><div style="padding-left:70px;">ID</div></th>
							      <th scope="col"><div style="padding-left:70px;">코멘트</div></th>
							      <th scope="col"><div style="padding-left:90px;">평가</div></th>
							      <th scope="col"><div style="padding-left:50px;">독서 시작 날짜</div></th>
							      <th scope="col"><div style="padding-left:40px;">독서 완료 날짜</div></th>
							      <th scope="col"><div style="padding-left:30px;">수정/삭제</div></th>
							    </tr>
							 </thead>
							 <tbody>
							 	<c:if test="${!empty commentsByMembers}">
									 <c:forEach var="comment" items="${commentsByMembers}">
									 	<tr class="table-light">
									      <th scope="row">
									     	<div style="padding-left:60px;">${comment.mem_id}</div>
									      </th>
									      	<td><div id="content${comment.appraisal_num}" style="padding-left:60px;">${comment.book_comment}</div></td>
										    <td>
										    	<div id="star${comment.appraisal_num}" style="padding-left:60px;">
										    		<c:if test="${comment.star==1 }">★☆☆☆☆</c:if> 
													<c:if test="${comment.star==2 }">★★☆☆☆</c:if> 
													<c:if test="${comment.star==3 }">★★★☆☆</c:if> 
													<c:if test="${comment.star==4 }">★★★★☆</c:if> 
													<c:if test="${comment.star==5 }">★★★★★</c:if>	
										    	</div>
										    </td>
										    <td><div id="startDate${comment.appraisal_num}" style="padding-left:50px;">${comment.start_date}</div></td>
										    <td><div id="endDate${comment.appraisal_num}" style="padding-left:40px;">${comment.end_date}</div></td>
									      <td>
										    <input class="btn btn-secondary my-2 my-sm-0" type="button" value="삭제" onclick='deleteBtn(${comment.appraisal_num})' />
											<input class="btn btn-secondary my-2 my-sm-0" type='button' value='수정' onclick='updateBtn(${comment.appraisal_num})' />
											
											<div style="float: right; ">
										     	<div id="pd${comment.appraisal_num}"></div>
											 	<div id="pu${comment.appraisal_num}"></div>
										    </div>	
										    								   
										   </td>
									    </tr>
							
										<div id="u${comment.appraisal_num}"></div>
								
									  </c:forEach>
									 	</c:if>
							 </tbody>
						   </table>
					  	</div>
					</div>
				</div>
			<div style="margin-top: 100px;" class="col"></div>
		</div>
	</div>

	<template id="modifyComment">
		<div class="alert alert-dismissible alert-secondary">
			<strong>독서완료</strong>
		</div>
		
		<div style="padding-left: 70px; margin-top: 30px;" >평가하기</div>
			
		<div class="star-rating">
			<input type="radio" id="5-star-m" name="m-star" value=5 /> 
			<label for="5-star-m" class="star">&#9733;</label> 
			<input type="radio" id="4-star-m" name="m-star" value=4 /> 
			<label for="4-star-m" class="star">&#9733;</label> 
			<input type="radio" id="3-star-m" name="m-star" value=3 /> 
			<label for="3-star-m" class="star">&#9733;</label>
			<input type="radio" id="2-star-m" name="m-star" value=2 /> 
			<label for="2-star-m" class="star">&#9733;</label> 
			<input type="radio" id="1-star-m" name="m-star" value=1 /> 
			<label for="1-star-m" class="star">&#9733;</label>
		</div>
		
		<h3 style="margin-top: 20px;">코멘트</h3>
		<textarea class="form-control" rows="5" id="book_comment-m" name="book_comment-m"
		placeholder="이 작품의 대한 생각을 자유롭게 표현해주세요.">{content}</textarea>
	
	
		<div style="float: left; margin-top: 20px; margin-left: 25px;">독서 시작 날짜 : <input type="date" id="start_date-m" name="start_date-m" />{startDate}</div>
		<div style="float: left; margin-top: 20px; margin-left: 25px;">독서 완료 날짜 : <input type="date" id="end_date-m" name="end_date-m" />{endDate}</div>
		
		<div style="float: left; margin-top: 20px; margin-left: 145px;"> 공개 여부 :</div>
			
		<div style="float: left; margin-top: 20px; margin-left: 25px;">
			공개 <input class="form-check-input" type="checkbox" id="free" name="co_prv-m" value="공개" onclick='checkOnlyOne(this)'/> 
		</div>
			
		<div style="float: left; margin-top: 20px; margin-left: 25px;">
		 	비공개<input class="form-check-input" type="checkbox" id="unfree" name="co_prv-m" value="비공개" onclick='checkOnlyOne(this)'/>
		</div>
		
		<div  style="float: left; margin-top: 20px; margin-left: 200px;">
			<input 
				class="btn btn-secondary my-2 my-sm-0" 
				type="button" 
				value="코멘트 수정하기" 
				id="updateComment" 
				onClick="updateComment({appraisal_num})"
			/> 
			<span id="msg" ></span>
		</div>
	</template>
	<script>


// 		# '찜', '보는 중' 등록
		function insertStatus(){
			let option = $("#option").val();
			let isbn = $("#isbn").val();
			
			$.ajax({
				url: '<c:url value="/insertStatus"/>',
				type: 'POST',
				data: JSON.stringify({
					"option": option,
					"isbn": isbn
				}),
				dataType: "json",
				contentType: 'application/json',
				success: function(data) {
					location.reload(); 
				}, error: function(){
					location.reload(); 
				}

			});
		}
		
// 		# 평가 삭제를 위한 비밀번호 입력 폼 
		function deleteBtn(appraisal_num) {
			$("#pd"+appraisal_num).html(
			'<div style="float: left; margin-right:10px; margin-top:5px;">비밀번호 입력 : </div>'+
			'<input style="float: left; width:100px; height:36px;" class="form-control" type="password" name="passCheck" id="passCheck" />'+
			'<input style="float: left;" class="btn btn-secondary my-2 my-sm-0" type="button" value="확인" onClick="passCheckAndDelete('+ appraisal_num + ')"/>'
			);
		}
		
//		비밀번호 확인 및 평가 삭제	
		function passCheckAndDelete(appraisal_num){
			
			let passCheck = $("#passCheck").val();
			$.ajax({
				url: '<c:url value="/passCheck"/>',
				type: 'POST',
				data: JSON.stringify({
					"appraisal_num": appraisal_num,
					"passCheck": passCheck
				}),
				dataType: "json",
				contentType: 'application/json',
				success: function(data) {
					if(data == 1){
					 	alert("비밀번호가 확인되었습니다.");
					 	deleteComment(appraisal_num);
					 	
					 	//비밀번호 입력 폼 사라지기
					 	$("#pd"+appraisal_num).hide();
					}else if(data == 0){
						alert("비밀번호가 일치하지 않습니다.");
						
						//비밀번호 입력 폼 사라지기
						$("#pd"+appraisal_num).html('');
					}
				}
			});
		}

// 		평가 삭제 요청		
		function deleteComment(appraisal_num){
			$.ajax({
				url: '<c:url value="/delete"/>',
				type: 'POST',
				data: JSON.stringify({
					"appraisal_num": appraisal_num
				}),
				dataType: "json",
				contentType: 'application/json',
				success: function(data) {
					location.reload(); 
				}, error: function(){
					location.reload(); 
				}
			});
		}


// 		# 평가 작성,수정 시 공개/비공개 둘 중 하나만 선택
		function checkOnlyOne(chk) {
		 let obj = document.getElementsByName("co_prv");
		    for(var i = 0; i < obj.length; i++){
		        if(obj[i] != chk){
		            obj[i].checked = false;
		        }
		    }
		}
			
//			# 평가 수정을 위한 비밀번호 입력 폼 
			function updateBtn(appraisal_num) {
				$("#pu"+appraisal_num).html(
					'<div style="float: left; margin-right:10px; margin-top:5px;">비밀번호 입력 : </div>'+
					'<input style="float: left; width:100px; height:36px;" class="form-control" type="password" name="passCheck" id="passCheck" />'+
					'<input style="float: left;" class="btn btn-secondary my-2 my-sm-0" type="button" value="확인" onClick="passCheckAndUpdate('+ appraisal_num + ')"/>'
					);
				}		  
	
		
//			비밀번호 확인 및 평가 수정 폼 보여주기
			function passCheckAndUpdate(appraisal_num){
				var passCheck = $("#passCheck").val();
				$.ajax({
					url: '<c:url value="/comment"/>',
					type: 'POST',
					data: JSON.stringify({
						"appraisal_num": appraisal_num,
						"passCheck": passCheck
					}),
					dataType: "json",
					contentType: 'application/json',
					success: function(data) {
						console.log(data);
					 	alert("비밀번호가 확인되었습니다.");
					 	
					 	updateForm(data);
					 	
					 	$("#pu"+appraisal_num).html('');
					},
					error: function(a, b, c) {
						alert("비밀번호가 일치하지 않습니다.");
						
					 
					 $("#pu"+appraisal_num).html('');
					}
				});
				
			}	
	
// 			평가 수정 폼 
			function updateForm(commentCmd) {
	
				if (commentCmd.co_prv == "공개"){
				} else {
				}
				$("#modifyComment").append("fdjkfjdkfjdkfjdkfjdkfd");
				var $result = $("#modifyComment").clone().html()
								.replace("{content}", commentCmd.book_comment)
								.replace("{startDate}", commentCmd.start_date)
								.replace("{endDate}", commentCmd.end_date)
								.replace("{appraisal_num}", commentCmd.appraisal_num)
								.replace('id="'+ commentCmd.star + '-star-m"', 'id="'+ commentCmd.star + '-star-m" checked');
				
				$("#u" + commentCmd.appraisal_num).append($result);
			}


// 			평가 수정
			function updateComment(appraisal_num){
				let star = $("input[name=m-star]").val();
				let book_comment = $("#book_comment-m").val();
				let start_date = $("#start_date-m").val();
				let end_date = $("#end_date-m").val();
				let co_prv = $("input[name=co_prv-m]").val();
				
				$.ajax({
					url: '<c:url value="/edit"/>',
					type: 'POST',
					data: JSON.stringify({
						"star": star,	
						"book_comment": book_comment,	
						"start_date": start_date,	
						"end_date": end_date,	
						"co_prv": co_prv,
						"appraisal_num": appraisal_num
					}),
					dataType: "json",
					contentType: 'application/json',
					success: function(data) {
						$("#u"+appraisal_num).html('');
						location.reload(); 
					}, error: function(e){
						console.log(e);
						location.reload(); 
					}
				});
			}


	
	   	 $(document).ready(function () {
	  		
//     		 # 상세페이지 실행하자마자 도서 데이터 요청
             var pageNum = 1;
	       	 var isbn_query = "${isbn}";
	       	 console.log("isbn_query:"+isbn_query);
            	$.ajax({	//카카오 검색요청 / [요청]
                    method: "GET",
                    url: "https://dapi.kakao.com/v3/search/book",
                    data: { query: isbn_query, page: pageNum},
                    headers: {Authorization: "KakaoAK 6f9ab74953bbcacc4423564a74af264e"} 
                })
               
                .done(function (msg) {	//검색 결과 담기 / [응답]
                	console.log(msg);
                        $("#bookThumbnail").append("<img style='width:450px; height:580px;' src='" + msg.documents[0].thumbnail + "'/><br>");		//표지
                        $("#bookTitle").append("<h2>"+ msg.documents[0].title + "</h2>저자 : "+msg.documents[0].authors);	//제목
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>저자:</h4><h5 style='display:inline'> " + msg.documents[0].authors + "</h5><br>");		//저자	
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>출판사:</h4> <h5 style='display:inline'>" + msg.documents[0].publisher + "</h5><br>");		//출판사
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>제작년도:</h4> <h5 style='display:inline'>" + msg.documents[0].datetime.slice(0,10) + "</h5><br>");		//일련번호
                        $("#bookInfo").append("<h4 class='text-primary'>줄거리</h4> <h5>" + msg.documents[0].contents + "...</h5>");		//줄거리
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>ISBN:</h4> <h5 style='display:inline'>" + msg.documents[0].isbn.slice(-13) + "</h5><br>");		//일련번호
                        $("#isbn").val(msg.documents[0].isbn.slice(-13));
                });   
            	
            	
//         		평가 작성,수정 시 구독 날짜 오늘 이후 비활성화 
        		start_date.max = new Date().toISOString().split("T")[0];
        		end_date.max = new Date().toISOString().split("T")[0];
        		
      		  })  
      		
//       	# '독서 완료'시 평가 작성 가능 
      		let submitFlag = false;
      		
      		let bookStatus = function(){
      			let select = document.getElementById("option");
      			let selectValue = select.options[document.getElementById("option").selectedIndex].value;
      			if(selectValue == 2){
      				submitFlag = true;
      				$("#insertStatus").hide();
      				
      			}else{
      				submitFlag = false;
      				$("#insertStatus").show();
      				
      				 $("#insertStatus").click(function () {	      					 
	      				insertStatus();
      				 })
      			}
      			console.log("flag : " + submitFlag);
      		}
			
      		let bookSubmit = function(){
      			let msg = document.getElementById("msg");
      			if(!submitFlag){
      				msg.innerHTML = "독서 완료 시에만 평가 작성이 가능합니다.";
      			}
      				
      			return submitFlag;
      		}
			
 	 </script>
</body>
</html>











