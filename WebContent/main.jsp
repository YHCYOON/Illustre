<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width", initial-scale="1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/main.css">
	<title>일러스트리 - 내가 그려가는 세상</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>
<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="main.jsp" onclick="onClickMain()" class="navBarLogo">
                <img src="images/illustre_logo.png" alt="illustre">
            </a>
            <div class="navContent">
                <div class="gallery">
                    <a href="gallery.jsp">&nbsp&nbsp&nbsp&nbsp 갤러리 &nbsp&nbsp&nbsp&nbsp</a>
                </div>
                <div class="ranking">
                    <a href="ranking.jsp">&nbsp&nbsp&nbsp&nbsp&nbsp 랭킹 &nbsp&nbsp&nbsp&nbsp&nbsp</a>
                </div>
                <div class="pictureRegist">
                    <a href="regist.jsp">&nbsp&nbsp&nbsp 그림등록 &nbsp&nbsp&nbsp</a>
                </div>
                <div class="myPicture">
                    <a href="myPicture.jsp">&nbsp&nbsp&nbsp 나의그림 &nbsp&nbsp&nbsp</a>
                </div>
                <div class="community">
                    <a href="community.jsp">&nbsp&nbsp&nbsp 커뮤니티 &nbsp&nbsp&nbsp</a>
                </div>
            </div>
            <div class="helloUser">
                <div class="hello">안녕하세요</div>
                <div class="user">{{ nickname }}님!</div>
            </div>
            <div class="logOutBtn">
                <button type="button" style="background-color:white;" onclick="onClickLogOut()" class="btn btn-outline-primary btn-sm">회원관리</button>
            </div>
        </div>
    </nav>
    <!-- 일러스트리 설명 점보트론 -->
	<div class="container">
			<div class="jumbotron" style="background-color:white; margin:0px; padding: 20px 40px 40px 20px;">
				<div class="illustre">일러스트리 - 내가 그려가는 세상</div>
				<div class="illustreInfo">자유롭게 그림을 공유하고 다른 사용자들과 소통할 수 있는 일러스트 공유 커뮤니티입니다</div>
				<button type="button" style="background-color:white;" class="btn btn-outline btn-lg" data-toggle="modal" data-target="#myModal">자세히 알아보기</button>
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
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
	    	<div class="modal-content">
	     		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        		<h4 class="modal-title" id="myModalLabel">일러스트리 소개</h4>
	      		</div>
	     	 	<div class="modal-body">
	       	 	안녕하세요
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