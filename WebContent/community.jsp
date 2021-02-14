<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="bbs.Bbs" %>
<%@page import="java.util.ArrayList" %>
<%request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/writeBootstrap.css">
	<link rel="stylesheet" href="css/community.css">
	<title></title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>

<%
	String userID = null;
	String userNickname = null;
	if(session.getAttribute("UserID") != null){
		userID = (String) session.getAttribute("UserID");
		UserDAO userDAO = new UserDAO();
		userNickname = userDAO.getNickname(userID);
	}
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
                    <a href="regist.jsp">그림등록</a>
                </div>
                <div class="myPicture">
                    <a href="myPicture.jsp">나의그림</a>
                </div>
                <div class="community">
                    <a href="community.jsp">커뮤니티</a>
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
						    <li role="presentation"><a href="userUpdate.jsp" role="menuitem" tabindex="-1" >회원정보 수정</a></li>
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
	                <a href="login.jsp"><button type="button" style="background-color:white;" class="btn btn-outline-primary btn-sm">로그인</button></a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>
    <div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<td style="background-color: #eeeeee; text-align: center;">번호</td>
						<td style="background-color: #eeeeee; text-align: center;">제목</td>
						<td style="background-color: #eeeeee; text-align: center;">작성자</td>
						<td style="background-color: #eeeeee; text-align: center;">작성일</td>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getBbsList(pageNumber);
					for(int i = 0; i < list.size(); i++){
				%>
					<tr>
						<td><%=list.get(i).getBbsID() %></td>
						<td><a href="#"><%=list.get(i).getBbsTitle() %></a></td>
						<td><%=list.get(i).getUserID() %></td>
						<td><%=list.get(i).getBbsDate() %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<a href="write.jsp" class="btn btn-default pull-right">글쓰기</a>
		</div>
	</div>
    
</div>
</body>
</html>