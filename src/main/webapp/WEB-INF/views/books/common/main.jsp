<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mainpage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/appraisalbootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/star.css">
<style>
.rounded {
  width: 100%;
  background-color: #F8EAFF;
  border: 2px solid #680099;
  padding: 0.5rem;
  line-height: 1rem;
  border-radius: 0.5rem;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BiBlet</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">BiBlet</a>
    <div class="collapse navbar-collapse" id="navbarColor01">
    	<div class="form-group">
       		<form action="/search" class="d-flex flex-row">
				<input class="form-control me-sm-2 flex-grow-1" size="30" type="text" name="query" id="query" value="${query}" placeholder="제목, 저자 또는 출판사 검색">
				<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
    </div>
	 <div class="col-25 col-md-20 col-lg-2 col-xl-2">
		<div class="navbar-collapse collapse show" id="navbarColor01"
			 style="float:right;">
			 <ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/member/signup'">Signup</a></li>
			</ul>
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/member/login'">Login</a></li>
			</ul>
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/member/logout'">Logout</a></li>
			</ul>
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/member/findId'">ForgotID</a></li>
			</ul>
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/admin/signup'">AdminSignup</a></li>
			</ul>
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/admin/login'">AdminLogin</a></li>
			</ul>
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" onClick="location.href = '/MyPage'">MyPage</a></li>
			</ul>
		</div>
	</div>
  </div>	
</nav>		
		<header class="masthead" style="background-image: url('/resources/image/home-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                  
                        <div class="page-heading">
                        <c:if test="${!empty myID}">
                            <h1>${myID}님 안녕하세요</h1>
                            <br>
                            <c:if test="${!empty myCommentCount}">
                            	<span class="subheading">지금까지 ${myCommentCount}개의 평가를 작성하였어요!</span>
                            </c:if>
                        </c:if>
                            
                        </div>
                    </div>
                </div>
            </div>
        </header>
        
<main class="mb-4">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-md-10 col-lg-8 col-xl-8">
			
				<div class='rounded'>
                <c:if test="${!empty myID}">	
				<div class="container px-4 px-lg-5">
                	<div class="row gx-4 gx-lg-5 justify-content-center">
                    	<div class="col-md-10 col-lg-8 col-xl-7">
                       		<div class="small text-center text-muted">
                        	<c:if test="${!empty allCommentCount}">
								<h2 style="color:#8A13C1;">${myID}이 찜한 도서</h2>
							</c:if>
                        	</div>
                   		 </div>
                	</div>
	            </div>
	            <br>
				<ul id="myLike" class="list-inline text-center"></ul>
				</c:if>
				</div>
				
				<br>
				
				<div class='rounded'>
					<div class="container px-4 px-lg-5">
                		<div class="row gx-4 gx-lg-5 justify-content-center">
                    		<div class="col-md-10 col-lg-8 col-xl-7">
                        		<div class="small text-center text-muted">
                       
								<h2 style="color:#8A13C1;">최근 코멘트</h2>
						
                        		</div>
                    		</div>
                		</div>
            		</div>
	
					<div class="container">
						<div class="row">
							<div class="col"></div>
							<div class="col-11">
								<div class="card text-white bg-secondary mb-3" style="max-width: 100rem;">
									<div class="card-body">
						  			<table class="table table-hover" style="width: 100%;">
									<c:if test="${!empty latestList}">
									<thead>
									<tr>
										<th scope="col"><div>제목</div></th>
										<th scope="col"><div>회원</div></th>
										<th scope="col"><div>별점</div></th>
										<th scope="col"><div>평가</div></th>
									</tr>
									</thead>
			 						<tbody>
									<c:forEach var="list" items="${latestList}">
									<tr class="table-light">
										<td id="bookName${list.isbn}"><div></div></td>
										<td><div>${list.mem_id}</div></td>
										<td>
										<div>
										<c:if test="${list.star==1 }">★☆☆☆☆</c:if> 
										<c:if test="${list.star==2 }">★★☆☆☆</c:if> 
										<c:if test="${list.star==3 }">★★★☆☆</c:if> 
										<c:if test="${list.star==4 }">★★★★☆</c:if> 
										<c:if test="${list.star==5 }">★★★★★</c:if>	
										</div>
										</td>
										<td><div>${list.book_comment}</div></td>
						
									</tr>
									</c:forEach>
									</tbody>
									</c:if>
									</table>
					  				</div>
								</div>
							</div>
							<div style="margin-top: 100px;" class="col"></div>
						</div>
					</div>
				</div>
				
				<br>
					
				<div class='rounded'>
					<div class="container px-4 px-lg-5">
                		<div class="row gx-4 gx-lg-5 justify-content-center">
                    		<div class="col-md-10 col-lg-8 col-xl-7">
                        		<div class="small text-center text-muted">
                       
								<h2 style="color:#8A13C1;">인기도서</h2>
								<br>
								<div id="popularList"></div>
                        		</div>
                    		</div>
                		</div>
            		</div>
		
					
				
                </div>
                
                    </div>
                </div>
            </div>
        </main>
        
		
	<footer class="border-top">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="small text-center text-muted fst-italic">
                        <c:if test="${!empty allCommentCount}">
							<h2>지금 까지 총  ${allCommentCount}개의 평가가 쌓였어요!</h2>
						</c:if>
                        </div>
                  </div>
                </div>
            </div>
     </footer>
		
	
		
	
	
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script>
			$(document).ready(function(){
				    
				 // 최근평가 isbn for문으로 담기
				<c:if test="${!empty latestList}">
					<c:forEach var="latestList" items="${latestList}">
						latestList(${latestList.isbn})
					</c:forEach>
				</c:if>
				
				// 인기 도서 불러오기
				<c:if test="${!empty popularList}">
					<c:forEach var="popularList" items="${popularList}">
						popularList(${popularList})
					</c:forEach>
				</c:if>	
				
				// 로그인한 회원의 도서 정보
				<c:if test="${!empty myBookInfo}">
					<c:forEach var="myBookInfo" items="${myBookInfo}">
						myBookInfo(${myBookInfo.isbn})
					</c:forEach>
				</c:if>
			});
			
			// 인기도서 불러오기(1개)
			function popularList(isbn){
				 
				$.ajax({	//카카오 검색요청 / [요청]
			        method: "GET",
			        traditional: true,
			        async: false,	//앞의 요청의 대한 응답이 올 때 까지 기다리기(false: 순서대로, true: 코드 중에 실행)
			        url: "https://dapi.kakao.com/v3/search/book",
			        data: { query: isbn},
			        headers: {Authorization: "KakaoAK 6f9ab74953bbcacc4423564a74af264e"} 
			    })
			    .done(function (msg) {	//검색 결과 담기 / [응답]
			    	console.log(msg);
			        $("#popularList").append("<img src='" + msg.documents[0].thumbnail + "'/>");	//표지
			    });   
			}
			
			
			// '찜' 도서 목록 불러오기
			function myBookInfo(isbn){
					
				$.ajax({	//카카오 검색요청 / [요청]
			        method: "GET",
			        traditional: true,
			        async: false,	//앞의 요청의 대한 응답이 올 때 까지 기다리기(false: 순서대로, true: 코드 중에 실행)
			        url: "https://dapi.kakao.com/v3/search/book",
			        data: { query: isbn },
			        headers: { Authorization: "KakaoAK 6f9ab74953bbcacc4423564a74af264e" } 
			    })
			    .done(function (msg) {	//검색 결과 담기 / [응답]
			    	console.log(msg);
			    	var html="";
			    	html +="<li style='width:20%;' class='list-inline-item'>";
					html +="<img src='" + msg.documents[0].thumbnail + "'/>";
					html +="<br>"+msg.documents[0].title+"</li>";
		            $("#myLike").append(html);	//제목
			    });   
			}
			
			// 최근 평가 도서 불러오기(1개)
			function latestList(isbn){
				console.log(isbn);
				$.ajax({	//카카오 검색요청 / [요청]
			        method: "GET",
			        traditional: true,
			        async: false,	//앞의 요청의 대한 응답이 올 때 까지 기다리기(false: 순서대로, true: 코드 중에 실행)
			        url: "https://dapi.kakao.com/v3/search/book",
			        data: { query: isbn },
			        headers: {Authorization: "KakaoAK 6f9ab74953bbcacc4423564a74af264e"} 
			    })
			    .done(function (msg) {	//검색 결과 담기 / [응답]
			    	console.log(msg);
			        $("#bookName" + isbn).append(msg.documents[0].title);	//표지
			    });   
			}	
		</script>
	</body>
</html>

