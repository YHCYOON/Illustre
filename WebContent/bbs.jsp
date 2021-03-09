<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@page import="user.UserDAO" %>
<%@page import="user.User" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="bbs.Bbs" %>
<%@page import="bbsComment.BbsCommentDAO" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/customBootstrap.css">
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
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
		userNickname = userDAO.getUserInfo(userID).getUserNickname();
	}
	int pageNumber = 1;
	try{
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	}catch(Exception e){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('올바르지 않은 페이지입니다');");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	BbsDAO bbsDAO = new BbsDAO();
	// 존재하는 게시글이 있는데 pageNumber 가 존재하는 페이지를 초과하면
	if(bbsDAO.getTotalPage() != 0){
		if(pageNumber > bbsDAO.getTotalPage()){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
	}else{	// 존재하는 게시글이 없는데 pageNumber 가 1이상이면 에러
		if(pageNumber > 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
	}
	UserDAO userDAO = new UserDAO();
%>
<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="main.jsp" class="navBarLogo">
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
	                <a href="login.jsp" class="btn btn-Skyblue btn-sm">로그인</a>
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
					ArrayList<Bbs> list = bbsDAO.getBbsList(pageNumber);
					for(int i = 0; i < list.size(); i++){
				%>
					<tr>
						<td><%=list.get(i).getBbsID() %></td>
						<td><a href="bbsView.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %>
							<%
								BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
								int countComment = bbsCommentDAO.countBbsComment(list.get(i).getBbsID());
								if(countComment > 0){
							%>
								&nbsp<i class="fas fa-comment" style="color:#A3A3A3;">&nbsp<%=countComment %></i></a></td>
							<%
								}
							%>
						<td><%=userDAO.getUserInfo(list.get(i).getUserID()).getUserNickname() %></td>
						<td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시 " + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<a href="bbsWrite.jsp" class="btn btn-Skyblue pull-right">글쓰기</a>
		</div>
		
		<!-- 페이징 처리  -->
		<div class="text-center">
			<ul class="pagination">
				<%
					int startPage = bbsDAO.getStartPage(pageNumber);
					int endPage = bbsDAO.getEndPage(pageNumber);
					int totalPage = bbsDAO.getTotalPage();
					if(pageNumber == 1){
				%>
		    		<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">이전</a></li>
		    	<%
					}else{	
		    	%>
		    		<li class="page-item"><a class="page-link" href="bbs.jsp?pageNumber=<%=pageNumber -1 %> " tabindex="-1">이전</a></li>
		    	<%
					}
		    		for(int iCount = startPage; iCount <= endPage; iCount++){
    					if(pageNumber == iCount){
		    	%>
		    				<li class="page-item active"><a class="page-link" href="bbs.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
		    			}else{
		    	%>		
		    				<li class="page-item"><a class="page-link" href="bbs.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
		    			}
		    		}
		    		if(pageNumber == totalPage){
				%>	
		    		<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
		    	<%
					}else{
		    	%>
		    		<li class="page-item"><a class="page-link" href="bbs.jsp?pageNumber=<%=pageNumber +1%>">다음</a></li>
		    	<%
					}
		    	%>	
			</ul>
		</div>
	</div>
    
</div>
</body>
</html>