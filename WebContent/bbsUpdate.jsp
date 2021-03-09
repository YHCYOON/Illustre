<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<%@page import="bbs.Bbs" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/customBootstrap.css">
	<link rel="stylesheet" href="css/write.css">
	<title>일러스트리 - 내가 그린 세상</title>
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다');");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(! userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정 권한이 없습니다');");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}else{
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
		                    <a href="galleryMine.jsp">나의그림</a>
		                </div>
		                <div class="community">
		                    <a href="bbs.jsp">커뮤니티</a>
		                </div>
		            </div>
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
			            </div>
		    </nav>
		    <div class="container">
				<div class="row">
					<form method="post" action="bbsUpdateAction.jsp?bbsID=<%=bbsID%>">
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
							<thead>
								<tr>
									<td colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글수정 양식</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="2"><input type="text" class="form-control" value="<%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %>" name="bbsTitle" maxlength="50"></td>
								</tr>
								<tr>	
									<td colspan="2"><textarea class="form-control" name="bbsContent" maxlength="2048" style="height: 350px; resize: none;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></textarea></td>
								</tr>
							</tbody>
						</table>
						<input type="submit" class="btn btn-Skyblue pull-right" value="수정하기">
					</form>
				</div>
			</div>
    </div>
	<%
		}
	%>
	
</body>
</html>