<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>    
<%@page import="bbs.Bbs" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="user.User" %>
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
	<title>일러스트리 - 내가 그린 세상</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>
<%
	//UserID 세션이 있으면 userID 에 대입
	String userID = null;
	String userNickname= null;
	if(session.getAttribute("UserID") != null){
		userID = (String) session.getAttribute("UserID");
		UserDAO userDAO = new UserDAO();
		userNickname = userDAO.getNickname(userID);
	}
	// 넘어온 bbsID 파라미터를 bbsID 에 대입
	int bbsID = 0;
	try{
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
	}catch(Exception e){
		// bbsID 가 정수가 아닐때 예외처리
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 페이지입니다');");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	// 넘어온 bbsID 파라미터가 없으면 접근에러 alert
	if(bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('올바르지 않은 접근입니다');");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	UserDAO userDAO = new UserDAO();
	
	try{
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
						    <li role="presentation"><a href="userUpdate" role="menuitem" tabindex="-1" >회원정보 수정</a></li>
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
							<td colspan="2"><%=userDAO.getUserInfo(bbs.getUserID()).getUserNickname() %></td>
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
				<a href="bbs" class="btn btn-Green">목록</a>
				<%
					// 해당 글을 작성한 사용자일때 수정, 삭제 버튼 표시
					if(userID != null && userID.equals(bbs.getUserID())){
				%>
					<a href="bbsUpdate?bbsID=<%=bbsID%>" class="btn btn-Skyblue">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="bbsDeleteAction?bbsID=<%=bbsID%>" class="btn btn-Red">삭제</a>
				<% 
					}
				%>
		</div>
		
		<% 
			// 접속중인 userID 일때
			if(userID != null){
		%>
		<form method="post" action="commentWriteAction?bbsID=<%=bbsID %>">
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
							<%	// 로그인중인 회원일때 수정,삭제 버튼 표시
								if(userID != null && userID.equals(list.get(i).getUserID())){
							%>
							<td colspan="1" style="padding: 14px;"><%=userDAO.getUserInfo(list.get(i).getUserID()).getUserNickname() %></td>
							<td style="padding-top:10px; width:60px;"><a href="commentUpdate?bbsID=<%=list.get(i).getBbsID() %>&bbsCommentID=<%=list.get(i).getBbsCommentID()%>">
								<button type="button" class="btn btn-Skyblue btn-sm">수정</button></a>
							</td>
							<td style="padding-top:10px; width:60px;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction?bbsID=<%=list.get(i).getBbsID() %>&bbsCommentID=<%=list.get(i).getBbsCommentID()%>">
								<button type="button" class="btn btn-Red btn-sm">삭제</button></a>
							</td>
							<%
								}else{	// 비회원은 수정,삭제 표시하지 않음
							%>
							<td colspan="3" style="padding: 14px;"><%=userDAO.getUserInfo(list.get(i).getUserID()).getUserNickname() %></td>
							<%
								}
							%>
						</tr>
						<tr>
							<td colspan="3"><%=list.get(i).getBbsCommentDate().substring(0, 11) + list.get(i).getBbsCommentDate().substring(11, 13) + "시 " + list.get(i).getBbsCommentDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td colspan="3"><%=list.get(i).getBbsComment().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
						</tr>
					</tbody>
				</table>
		<%
			}
		%>		
				
			</div>
		</div>
	</div>
<%
	}catch(Exception e){
		// 존재하지 않는 bbsID 일때 예외처리
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 페이지입니다');");
		script.println("history.back()");
		script.println("</script>");
	}
%>  	
</body>
</html>