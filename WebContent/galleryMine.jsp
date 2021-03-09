<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>    
<%@page import="user.User" %>
<%@page import="gallery.Gallery" %>    
<%@page import="gallery.GalleryDAO" %>  
<%@page import="java.util.ArrayList" %> 
<%@page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %> 
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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		GalleryDAO galleryDAO = new GalleryDAO();
    	String galleryCategory = "전체보기";
    	try{
	    	if(request.getParameter("galleryCategory") != null){
	    		galleryCategory = (String) request.getParameter("galleryCategory");
	    	}
    	}catch(Exception e){
    		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 카테고리입니다');");
			script.println("history.back()");
			script.println("</script>");
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
			script.println("location.href='galleryMine.jsp'");
			script.println("</script>");
		}
		
		// pageNumber 가 존재하는 페이지 이상이고 존재하는 그림이 0이 아니면
		if(galleryDAO.getGalleryMineTotalPage(galleryCategory, userID) != 0){
			if(pageNumber > galleryDAO.getGalleryMineTotalPage(galleryCategory, userID)){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 페이지입니다');");
				script.println("history.back()");
				script.println("</script>");
			}
		}else{	// 존재하는 그림이 없는데 pageNumber 가 1이상이면 에러
			if(pageNumber > 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 페이지입니다');");
				script.println("history.back()");
				script.println("</script>");
			}
		}
		
		ArrayList<Gallery> list = galleryDAO.getGalleryMine(userID, galleryCategory, pageNumber);
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
        </div>
    </nav>
    <!-- 카테고리  -->
    <div class="searchBar">
        <div class="searchBarContent">
            <div class="category">
            	<a href="galleryMine.jsp?galleryCategory=전체보기" class="btn btn-Skyblue">전체보기</a>
            	<a href="galleryMine.jsp?galleryCategory=캐릭터 일러스트" class="btn btn-Skyblue">캐릭터 일러스트</a>
            	<a href="galleryMine.jsp?galleryCategory=배경 일러스트" class="btn btn-Skyblue">배경 일러스트</a>
            	<a href="galleryMine.jsp?galleryCategory=스케치" class="btn btn-Skyblue">스케치</a>
            </div>
        </div>
    </div>
    
    <!-- 카테고리 & 검색결과 -->
    <div class="middleSectionWrap">
        <div class="middleSection">
            <i class="fas fa-image fa-2x"></i>
            <div class="pictureCount" id="pictureCategoryCount"><%=userNickname%>님의 그림 - <%=galleryCategory %> (<%=galleryDAO.countGalleryMineTotalPage(galleryCategory, userID)%>)</div>
        </div>
    </div>
    <!-- CardSection -->
	<!-- CardSection -->
    <div class="pictureCardSection">
    <%
    	try{
    		for(int i = 0; i < list.size(); i++){
    %>
				<a class="pictureCard" href="galleryView.jsp?galleryID=<%=list.get(i).getGalleryID()%>">
					<div class="screen">
						<div class="hoverTitle"><%=list.get(i).getGalleryTitle() %></div>
						<div class="hoveruserNickname"><%=list.get(i).getUserNickname() %></div>
						<div class="hoverLike">
						<i class="fas fa-heart"><%=list.get(i).getGalleryLikeCount() %></i>
						</div>
						<img id="pictureCard" class="cardImage" src="<%=request.getContextPath() %>/upload/<%=list.get(i).getFileRealName()%>">
					</div>
				</a>
   <%
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	// list가 없을떄 pageNumber = 0
    	if(list.size() == 0){
    		pageNumber = 0;
    	}
    %>	
	<!-- 페이징 처리  -->
		<div class="text-center">
			<ul class="pagination">
				<%
					int startPage = galleryDAO.getGalleryMineStartPage(pageNumber);
					int endPage = galleryDAO.getGalleryMineEndPage(pageNumber, galleryCategory, userID);
					int totalPage = galleryDAO.getGalleryMineTotalPage(galleryCategory, userID);
					
					// 페이징 이전버튼 처리
				
					if(pageNumber == 0){
				%>
					<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">이전</a></li>
					<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">다음</a></li>
				<%
					return;
					}
					if(pageNumber == 1){
				%>
		    		<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">이전</a></li>
		    	<%
					}else{
						if(galleryCategory.equals("전체보기")){	// 카테고리가 전체보기(default)일때
				%>				
							<li class="page-item"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=pageNumber -1%>">이전</a></li>
				<%
						}else{	// 카테고리가 default가 아니면 galleryCategory를 파라미터로 전달
				%>
							<li class="page-item"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=pageNumber -1%>&galleryCategory=<%=galleryCategory%>">이전</a></li>
				<% 			
						}
					}
				%>
				<%
					// 페이지 개수 처리
					for(int iCount = startPage; iCount <= endPage; iCount++){
    					if(pageNumber == iCount){	// 해당 페이지일때
    						if(galleryCategory.equals("전체보기")){	// 카테고리가 전체보기(default)일때
		    	%>
	    					<li class="page-item active"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
   							}else{	// 카테고리가 default가 아니면 galleryCategory를 파라미터로 전달
    			%>				
   							<li class="page-item active"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=iCount%>&galleryCategory=<%=galleryCategory%>"><%=iCount %></a></li>
		    	<%
	    					}
   						}else{	// 해당 페이지가 아닐때
   							if(galleryCategory.equals("전체보기")){	// 카테고리가 전체보기(default)일때
		    	%>
	    					<li class="page-item"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
   							}else{	// 카테고리가 default가 아니면 galleryCategory를 파라미터로 전달
    			%>				
   							<li class="page-item"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=iCount%>&galleryCategory=<%=galleryCategory%>"><%=iCount %></a></li>
		    	<%
		    				}
						}
					}
    					
					// 페이징 다음 버튼 처리
		    		if(pageNumber == totalPage){
				%>	
		    		<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
		    	<%
					}else{
						if(galleryCategory.equals("전체보기")){
				%>				
						<li class="page-item"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=pageNumber +1%>">다음</a></li>
				<%
						}else{
				%>
						<li class="page-item"><a class="page-link" href="galleryMine.jsp?pageNumber=<%=pageNumber +1%>&galleryCategory=<%=galleryCategory%>">다음</a></li>
				<% 			
						}
					}
				%>
			</ul>
		</div>
		
    </div>
</div>        
</body>
</html>