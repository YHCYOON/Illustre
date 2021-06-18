<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/customBootstrap.css">
	<link rel="stylesheet" href="css/main.css">
	<title>일러스트리 - 내가 그린 세상</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>
	<%
		// UserID 세션값이 있으면 userID 에 대입
		String userID = null;
		String userNickname = null;
		if (session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
			UserDAO userDAO = new UserDAO();
			// 해당 userID 의 user 객체를 가져옴
			User user = userDAO.getUserInfo(userID);
			// userNickname 에 해당 객체의 userNickname 값을 대입
			userNickname = user.getUserNickname();
		}
	%>
<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="main" class="navBarLogo">
                <img src="images/illustre_logo.png" alt="illustre">
            </a>
            <div class="navContent">
                <div class="gallery">
                    <a href="gallery">갤러리</a>
                </div>
                <div class="ranking">
                    <a href="ranking">랭킹</a>
                </div>
                <div class="pictureRegist">
                    <a href="galleryRegist">그림등록</a>
                </div>
                <div class="myPicture">
                    <a href="galleryMine">나의그림</a>
                </div>
                <div class="community">
                    <a href="bbs">커뮤니티</a>
                </div>
            </div>
            <%
            	if(userID != null){
            %>
	            <div class="helloUser">
	                <div class="hello">안녕하세요</div>
	                <div class="user"><%=userNickname %>님!</div>
	            </div>
	            <div class="logOutBtn">
	                <div class="dropdown">
  						<button class="btn btn-Skyblue dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
  						회원관리<span class="caret"></span></button>
		  				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
						    <li role="presentation"><a href="userUpdate" role="menuitem" tabindex="-1">회원정보 수정</a></li>
						    <li role="presentation" class="divider"></li>
						    <li role="presentation"><a href="logoutAction" role="menuitem" tabindex="-1">로그아웃</a></li>
						</ul>
					</div>
	            </div>
            <%
            	}else{
            %>
            	<div class="helloUser">
	                <div class="hello">안녕하세요</div>
	                <div class="user">로그인이 필요합니다</div>
	            </div>
	            <div class="logOutBtn">
	                <a href="login" class="btn btn-Skyblue btn-sm">로그인</a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>
    <!-- 일러스트리 설명 점보트론 -->
	<div class="container">
			<div class="jumbotron" style="background-color:white; margin:0px; padding: 20px 40px 15px 20px;">
				<div class="illustre">일러스트리 - 내가 그린 세상</div>
				<div class="illustreInfo">자유롭게 그림을 공유하고 다른 사용자들과 소통할 수 있는 일러스트 공유 커뮤니티입니다</div>
				<button type="button" class="btn btn-Skyblue btn-lg" data-toggle="modal" data-target="#myModal">자세히 알아보기</button>
			</div>
	</div>
	<!-- 캐러셀 -->
	<div class="container" >
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/1.jpg">
				</div>
				<div class="item">
					<img src="images/2.jpg">
				</div>
				<div class="item">
					<img src="images/3.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span>
			</a> 
			<a class="right carousel-control" href="#myCarousel" data-slide="next"> <span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<!-- 모달 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
	    	<div class="modal-content">
	     		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        		<h4 class="modal-title" id="myModalLabel">일러스트리 소개</h4>
	      		</div>
	     	 	<div class="modal-body">
	     	 		<div style="text-align:center;"><img src="images/illustre_logo_underline.png" height="70"/></div>
	       	 		<h5 style="text-align:center; font-weight:bold;">나와 다른 사용자들의 그림을 공유할 수 있고 자유롭게 의견을 나눌 수 있는</h5>
	       	 		<h5 style="text-align:center; font-weight:bold;">일러스트 공유 사이트입니다</h5>
	       	 		<h3></h3>
	       	 		<h4 style="font-weight:bold;">사용 기술</h4>
	       	 		<h5>> Front-End : HTML, CSS, JAVASCRIPT, JQUERY, Bootstrap</h5>
	       	 		<h5>> Back-End : JAVA, JSP, TOMCAT v8.5, MYSQL, HeidiSQL, Putty, FileZilla</h5>
	       	 		<h3></h3>
	       	 		<h4 style="font-weight:bold;">프로젝트 주소</h4>
	       	 		<h5>> Project homepage: <a href="http://yhcyoon.cafe24.com">yhcyoon.cafe24.com</a></h5>
	       	 		<h5>> GitHub Repository: <a href="https://github.com/YHCYOON/Illustre">https://github.com/YHCYOON/Illustre</a></h5>
	       	 		<h3></h3>
	       	 		<h4 style="font-weight:bold;">핵심 기능</h4>
	       	 		<h5>> 이미지 파일을 포함하는 게시글을 등록할 수 있습니다.</h5>
					<h5>> 게시글을 카테고리 별로 볼 수 있으며 검색기능을 구현했습니다.</h5>
					<h5>> 갤러리 게시판과 커뮤니티 게시판에 페이지네이션 기능을 구현했습니다.</h5>
					<h5>> 게시글에 사용자마다 한번씩 좋아요를 할 수 있습니다.</h5>
					<h5>> 게시글마다 댓글 기능을 구현했습니다.</h5>
					<h5>> 좋아요가 많은 순서대로 그림을 볼 수 있는 랭킹 페이지를 구현했습니다.</h5>
					<h5>> 본인이 등록한 그림을 볼 수 있는 나의그림 페이지를 구현했습니다.</h5>
					<h5>> 모든 게시글과 댓글은 작성자의 세션과 일치할 때 수정 및 삭제가 가능합니다.</h5>
					<h5>> 로그인, 로그아웃 기능을 구현했습니다.</h5>
					<h5>> 회원가입 페이지에서 비동기 통신방식인 ajax를 이용해 페이지 이동없이도</h5>
					<h5>&nbsp&nbsp&nbsp아이디와 닉네임의 중복검사를 할 수 있습니다.</h5>
					<h5>> 회원 관리 창에서 회원 정보 수정을 할 수 있습니다.</h5>
					<h5>> 비밀번호 찾기 기능을 구현했습니다.</h5>
					<h5>> URL 파라미터 입력시 여러 에러상황에서의 예외처리를 하였습니다.</h5>
					<h5>> 404, 500 에러를 처리하는 페이지를 구현했습니다.</h5>
	      		</div>
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	     		</div>
	   		</div>
		</div>
	</div>
</div>
</body>
</html>