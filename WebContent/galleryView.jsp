<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="user.UserDAO" %>    
<%@page import="user.User" %>  
<%@page import="gallery.Gallery" %>
<%@page import="gallery.GalleryDAO" %>
<%@page import="galleryLike.GalleryLikeDAO" %>
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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
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
	int galleryID = 0;
	if(request.getParameter("galleryID") != null){
		galleryID = Integer.parseInt(request.getParameter("galleryID"));
	}
	if(galleryID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 페이지입니다');");
		script.println("history.back()");
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
	
	<%
		GalleryDAO galleryDAO = new GalleryDAO();
		Gallery gallery = galleryDAO.getGalleryView(galleryID);
	%>
	
    <div class="pictureRegistSectionWrap">
    	<!-- galleryView Form  -->
       	<div id="galleryRegistForm" class="pictureRegistSection">
            <div>
            	<img class="galleryImage" src="<%=request.getContextPath() %>/upload/<%=gallery.getFileRealName()%>">
				<!-- 댓글 입력부분 -->
				<% 
				if(userID != null){
				%>
				<form method="post" action="galleryCommentWriteAction.jsp?galleryID=<%=galleryID %>">
					<table class="table" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;">
						<tbody>
							<tr>	
								<td colspan="2"><textarea class="form-control" placeholder="<%=userNickname %>님의 생각은 어떠신가요?" name="galleryCommentContent" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="btn btn-Skyblue pull-right" value="댓글 작성하기">
				</form>
				<%
					}else{
				%>
				<table class="table" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;">
					<tbody>
						<tr>	
							<td colspan="2"><textarea class="form-control" placeholder="로그인이 필요합니다" name="bbsContent" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<%
					}	
				%>
				<!-- 댓글 부분 -->
				<%
					if(userID != null){
				%>
					<div style="margin-top:60px; font-size:18px;">댓글 (222)</div>
				<%
					}else{
				%>
					<div style="margin-top:20px; font-size:18px;">댓글 (222)</div>
				<%
					}
				%>
				<table class="table" style="border: 2px solid #dddddd; margin-top:10px;">
					<tbody>
						<tr>
							<td colspan="1" style="padding: 14px;">123123</td>
							<td style="padding-top:10px; width:60px;"><a href="commentUpdate.jsp?"><button type="button" class="btn btn-Skyblue btn-sm">수정</button></a></td>
							<td style="padding-top:10px; width:60px;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction.jsp">
							<button type="button" class="btn btn-Red btn-sm">삭제</button></a></td>
						</tr>
						<tr>
							<td colspan="3">123</td>
						</tr>
						<tr>
							<td colspan="3">123</td>
						</tr>
					</tbody>
				</table>
				
           	</div>
            <div class="pictureRegistRight">
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">카테고리</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryCategory() %>" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">아티스트</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getUserNickname() %>" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">제목</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryTitle() %>" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작성일자</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryDate() %>" readonly>
                </div>
                <div class="pictureContent">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작품설명</label>
                    </div>
                    <textarea id="galleryContent" name="galleryContent" class="form-control" rows="26" readonly><%=gallery.getGalleryContent() %></textarea>
                </div>
                <div class="pictureRegistBtn" style="margin-top:15px;">
                	<a href="bbs.jsp" class="btn btn-noneHoverSkyBlue btn-block">Favorite에 추가</a>
                </div>
                <div class="pictureRegistBtn" style="margin-top:15px;">
                	<%
                		GalleryLikeDAO galleryLikeDAO = new GalleryLikeDAO();
                		int checkLike = galleryLikeDAO.checkLikeCount(userID, galleryID);
                		if(checkLike == 0){
                	%>
                	<a href="galleryLikeAction.jsp?galleryID=<%=gallery.getGalleryID() %>" class="btn btn-Red btn-block">좋아요 <i class="fas fa-heart"> <%=gallery.getGalleryLikeCount() %></i></a>
                	<%
                		}else if(checkLike == 1){
                	%>
                	<a onclick="return confirm('좋아요를 취소하시겠습니까?')" href="galleryLikeAction.jsp?galleryID=<%=gallery.getGalleryID() %>" class="btn btn-noneHoverRed btn-block">좋아요 <i class="fas fa-heart"> <%=gallery.getGalleryLikeCount() %></i></a>
                	<%
                		}else{
                		PrintWriter script = response.getWriter();
                		script.println("<script>");
                		script.println("alert('데이터베이스 오류입니다. 다시 시도해주세요');");
                		script.println("history.back()");
                		script.println("</script>");
                		}
                	%>
                </div>
            </div>
       	</div>
	</div>
	
</div>

</body>
</html>