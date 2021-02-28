<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>    
<%@page import="user.User" %>
<%@page import="gallery.Gallery" %>    
<%@page import="gallery.GalleryDAO" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/customBootstrap.css">
	<link rel="stylesheet" href="css/gallery.css">
	<title>일러스트리 - 내가 그려가는 세상</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>
<%
		String userID = null;
		String userNickname = null;
		if (session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
			UserDAO userDAO = new UserDAO();
			User user = userDAO.getUserInfo(userID);
			userNickname = user.getUserNickname();
		}
	%>
<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="main.jsp" onclick="onClickMain()" class="navBarLogo">
                <img src="images/illustre_logo.png" alt="illustre">
            </a>
            <div class="navContent">
                <div class="gallery">
                    <a href="gallery.jsp">갤러리</a>
                </div>
                <div class="ranking">
                    <a href="ranking.jsp">랭킹</a>
                </div>
                <div class="pictureRegist">
                    <a href="galleryRegist.jsp">그림등록</a>
                </div>
                <div class="myPicture">
                    <a href="myPicture.jsp">나의그림</a>
                </div>
                <div class="community">
                    <a href="bbs.jsp">커뮤니티</a>
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
						    <li role="presentation" ><a href="userUpdate.jsp" role="menuitem" tabindex="-1">회원정보 수정</a></li>
						    <li role="presentation" class="divider"></li>
						    <li role="presentation"><a href="logoutAction.jsp" role="menuitem" tabindex="-1">로그아웃</a></li>
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
	                <a href="login.jsp" class="btn btn-Skyblue btn-sm">로그인</a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>
    <!-- 검색창  -->
    <div class="searchBar">
        <div class="searchBarContent">
            <div class="category">
                <button type="button" onclick="showAll()" name="showCategory" id="showAll" class="btn btn-Skyblue" value="all">전체보기
                </button>
                <button type="button" onclick="showCharacter()" name="showCategory" id="showChar" class="btn btn-Skyblue"
                        value="캐릭터 일러스트">캐릭터 일러스트
                </button>
                <button type="button" onclick="showBackground()" name="showCategory" id="showBackground" class="btn btn-Skyblue"
                        value="배경 일러스트">배경 일러스트
                </button>
                <button type="button" onclick="showSketch()" name="showCategory" id="showSketch" class="btn btn-Skyblue"
                        value="스케치">스케치
                </button>
            </div>
            <div class="search">
                <div class="searchCategory">
                    <select id="searchCategory" class="custom-select">
                        <option id="searchAll" value="searchAll">전체</option>
                        <option id="searchTitle" value="searchTitle">제목</option>
                        <option id="searchNickname" value="searchNickname">닉네임</option>
                        <option id="searchComment" value="searchComment">작품설명</option>
                    </select>
                </div>
                <input id="searchContent" class="form-control mr-sm-2" type="search" aria-label="Search">
                <button id="btnSearch" type="button" name='search' class="btn btn-Skyblue" onclick="searchContent()">검색</button>
            </div>
        </div>
    </div>
    
    <!-- 카테고리 & 검색결과 -->
    <div class="middleSectionWrap">
        <div class="middleSection">
            <i class="fas fa-image fa-2x"></i>
            <div class="pictureCount" id="pictureCategoryCount">전체보기 </div>
        </div>
    </div>
    
    <!-- CardSection -->
    <div class="pictureCardSection">
    	
     <a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a>
                                
                                <a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a>  <a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a><a class="pictureCard" href="/picturedetail/${picturenumber}">
                                <div class="screen">
                                    <div class="hoverTitle">안녕</div>
                                    <div class="hoveruserNickname">하세요</div>
                                    <div class="hoverLike">
                                        <i class="fas fa-heart"> ㅋㅋㅋㅋ</i>
                                    </div>
                                    <img id="pictureCard" class="cardImage" src="${imgURL}">
                                </div>
                                </a>    
    	
    	
    
    </div>
    
</div>	
</body>
</html>