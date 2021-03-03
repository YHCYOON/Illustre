<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="user.UserDAO" %>    
<%@page import="user.User" %>  
<%request.setCharacterEncoding("UTF-8"); %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/galleryRegist.css">
	<link rel="stylesheet" href="css/customBootstrap.css">
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
	/* int galleryID = 0;
	if(request.getParameter("galleryID") != null){
		galleryID = Integer.parseInt(request.getParameter("galleryID"));
	}
	if(galleryID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 페이지입니다');");
		script.println("history.back()");
		script.println("</script>");
	} */
	
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
	                <a href="login.jsp" class="btn btn-Skyblue btn-sm">로그인</a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>

    <div class="pictureRegistSectionWrap">
    	<!-- 그림등록 Form  -->
       	<div id="galleryRegistForm" class="pictureRegistSection">
            <div class="pictureRegistLeft">
                <div class="filebox preview-image">
                </div>
            </div>

            <div class="pictureRegistRight">
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">카테고리</label>
                    </div>
                    <input type="text" class="custom-viewContent" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">아티스트</label>
                    </div>
                    <input type="text" class="custom-viewContent" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">제목</label>
                    </div>
                    <input type="text" class="custom-viewContent" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작성일자</label>
                    </div>
                    <input type="text" class="custom-viewContent" readonly>
                </div>
                <div class="pictureContent">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작품설명</label>
                    </div>
                    <textarea id="galleryContent" name="galleryContent" class="form-control" rows="26" readonly></textarea>
                </div>
                <div class="pictureRegistBtn">
                	<input type="button" onclick="galleryRegist()" class="btn btn-Skyblue btn-lg btn-block" value="그림 등록하기">
                </div>
            </div>
       	</div>
	</div>
</div>

</body>
</html>