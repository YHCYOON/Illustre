<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="user.UserDAO" %>    
<%@page import="user.User" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/galleryRegist.css">
	<link rel="stylesheet" href="css/bootstrap.css">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<title></title>
</head>
<body>
<%
	String userID = null;
	String userNickname = null;
	if(session.getAttribute("UserID") != null){
		userID = (String) session.getAttribute("UserID");
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUserInfo(userID);
		userNickname = user.getUserNickname();
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다');");
		script.println("location.href='login.jsp'");
		script.println("</script>");
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
  						<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
  						회원관리<span class="caret"></span></button>
		  				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
						    <li role="presentation"><a href="userUpdate.jsp" role="menuitem" tabindex="-1">회원정보 수정</a></li>
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
	                <a href="login.jsp"><button type="button" style="background-color:white;" class="btn btn-default btn-sm">로그인</button></a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>

    <div class="pictureRegistSectionWrap">
        <div class="pictureRegistSection">
            <div class="pictureRegistLeft">
                <div class="checkImage">
                    <img id="urlImg">
                </div>
                <div class="UrlSection">
                    <div class="inputURL">
                        <input type="text" id="inputURL" class="form-control" placeholder="URL을 입력하세요">
                    </div>
                    <div class="checkURL">
                        <button type="button" onclick="Show_Img()" class="btn btn-default btn-sm">이미지 확인</button>
                    </div>
                </div>
            </div>

            <div class="pictureRegistRight">
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">카테고리</label>
                    </div>
                    <select id="category" class="custom-select">
                        <option selected>카테고리를 선택하세요</option>
                        <option value="캐릭터 일러스트">캐릭터 일러스트</option>
                        <option value="배경 일러스트">배경 일러스트</option>
                        <option value="스케치">스케치</option>
                    </select>
                </div>
                <div class="pictureTitle">
                    <div class="input-group-prepend">
                        <label class="input-group-text">제목</label>
                        <input type="text" id="title" class="form-control">
                    </div>
                </div>
                <div class="pictureComment">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작품설명</label>
                    </div>
                    <textarea id="comment" class="form-control" rows="28"></textarea>
                </div>
                <div class="pictureRegistBtn">
                    <button onclick="Picture_Regist()" type="button" class="btn btn-primary btn-lg btn-block">등록하기</button>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>