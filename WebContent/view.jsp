<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>    
<%@page import="bbs.Bbs" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="user.UserDAO" %>
<%@page import="bbsComment.BbsComment" %>
<%@page import="bbsComment.BbsCommentDAO" %>

<%@page import="java.util.ArrayList" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/customBootstrap.css">
	<link rel="stylesheet" href="css/community.css">
	<title></title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>
<%
	String userID = null;
	String userNickname= null;
	if(session.getAttribute("UserID") != null){
		userID = (String) session.getAttribute("UserID");
		UserDAO userDAO = new UserDAO();
		userNickname = userDAO.getNickname(userID);
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
  						<button class="btn btn-Skyblue dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
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
	                <a href="login.jsp"><button type="button" style="background-color:white;" class="btn btn-Skyblue btn-sm">로그인</button></a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>
    
    <div class="container">
		<div class="row">
				<table class="table" style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<td colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시 " + bbs.getBbsDate().substring(14, 16) + "분" %></td>
						</tr>
						
						<tr>
							<td style="width: 20%;">내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
							
						</tr>
					</tbody>
				</table>
				<a href="community.jsp" class="btn btn-Skyblue">목록</a>
				<%
					if(userID != null && userID.equals(bbs.getUserID())){
				%>
					<a href="bbsUpdate.jsp?bbsID=<%=bbsID%>" class="btn btn-Skyblue">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-Red">삭제</a>
				<% 
					}
				%>
		</div>
		
		<% 
			if(userID != null){
		%>
		<form method="post" action="commentWriteAction.jsp?bbsID=<%=bbsID %>">
			<table class="table" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;">
				<tbody>
					<tr>	
						<td colspan="2"><textarea class="form-control" placeholder="<%=userNickname %>님의 생각은 어떠신가요?" name="bbsCommentContent" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-Skyblue pull-right" value="댓글 작성하기">
		</form>
		</div>
		<%
			}else{
		%>
		<form action="login.jsp">
			<table class="table" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;">
				<tbody>
					<tr>	
						<td colspan="2"><textarea class="form-control" placeholder="로그인이 필요합니다" name="bbsContent" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
					</tr>
				</tbody>
			</table>
		</form>
		<%
			}	
		%>
		<%
			ArrayList<BbsComment> list = new ArrayList<BbsComment>();
			BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
			list = bbsCommentDAO.getBbsComment(bbsID);
		%>
		<!-- 댓글 부분  -->
		<div class="container">
			<div class="row">
				<div style="font-size:18px;">댓글 (<%=list.size() %>)</div>
		<%
			for(int i = 0; i <list.size(); i++ ){
		%>
				<table class="table" style="border: 2px solid #dddddd; margin-top:10px;">
					<tbody>
						<tr>
							<%
								if(userID != null && userID.equals(list.get(i).getUserID())){
							%>
							<td colspan="1" style="padding: 14px;"><%=list.get(i).getUserID() %></td>
							<td style="padding-top:10px; width:60px;"><a href="commentUpdate.jsp?bbsID=<%=list.get(i).getBbsID() %>&bbsCommentID=<%=list.get(i).getBbsCommentID()%>"><button type="button" class="btn btn-Skyblue btn-sm">수정</button></a></td>
							<td style="padding-top:10px; width:60px;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction.jsp?bbsID=<%=list.get(i).getBbsID() %>&bbsCommentID=<%=list.get(i).getBbsCommentID()%>">
							<button type="button" class="btn btn-Red btn-sm">삭제</button></a></td>
							<%
								}else{
							%>
							<td colspan="3" style="padding: 14px;"><%=list.get(i).getUserID() %></td>
							<%
								}
							%>
						</tr>
						<tr>
							<td colspan="3"><%=list.get(i).getBbsCommentDate().substring(0, 11) + list.get(i).getBbsCommentDate().substring(11, 13) + "시 " + list.get(i).getBbsCommentDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td colspan="3"><%=list.get(i).getBbsComment() %></td>
						</tr>
					</tbody>
				</table>
		<%
			}
		%>		
				
			</div>
		</div>
	</div>
    	
</body>
</html>