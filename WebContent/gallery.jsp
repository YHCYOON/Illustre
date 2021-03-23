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
	<title>일러스트리 - 내가 그린 세상</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
</head>
<body>
<%
		// 세션이 존재하면 해당 사용자의 userID와 userNickname를 가져옴
		String userID = null;
		String userNickname = null;
		if (session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
			UserDAO userDAO = new UserDAO();
			User user = userDAO.getUserInfo(userID);
			userNickname = user.getUserNickname();
		}
		// 넘어온 pageNumber 파라미터를 pageNumber에 대입
		int pageNumber = 1;
		try{
			if(request.getParameter("pageNumber") != null){
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}
		}catch(Exception e){
			// 넘어온 pageNumber 파라미터가 정수가 아닐때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
		// 기본 galleryCategory 를 전체보기로 설정
		GalleryDAO galleryDAO = new GalleryDAO();
    	String galleryCategory = "전체보기";
    	try{
    		// 넘어온 파라미터가 있을때
	    	if(request.getParameter("galleryCategory") != null){
	    		// 그 파라미터가 캐릭터 일러스트 , 배경 일러스트, 스케치이면 galleryCategory 에 대입
	    		if(request.getParameter("galleryCategory").equals("캐릭터 일러스트") || request.getParameter("galleryCategory").equals("배경 일러스트") || 
		    		request.getParameter("galleryCategory").equals("스케치")){
		    		galleryCategory = (String) request.getParameter("galleryCategory");
		    	}
	    	}
    	}catch(Exception e){
    		// 셋중에 하나가 아니면 예외처리
    		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 카테고리입니다');");
			script.println("history.back()");
			script.println("</script>");
    	}
    	// keyWord , searchWord 값이 default 일때 모든 파일을 보여줌
    	String keyWord = "fileName";
    	String searchWord = ".";
    	// 넘어온 keyWord, searchWord 를 대입
    	if(request.getParameter("keyWord") != null){
    		keyWord = (String) request.getParameter("keyWord");
    	}
    	if(request.getParameter("searchWord") != null){
    		searchWord = (String) request.getParameter("searchWord");
    	}
    	
		ArrayList<Gallery> list = galleryDAO.getGalleryList(pageNumber, galleryCategory, keyWord, searchWord);
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
    <!-- 검색창  -->
    <div class="searchBar">
        <div class="searchBarContent">
            <div class="category">
            	<a href="gallery.jsp?galleryCategory=전체보기" class="btn btn-Skyblue">전체보기</a>
            	<a href="gallery.jsp?galleryCategory=캐릭터 일러스트" class="btn btn-Skyblue">캐릭터 일러스트</a>
            	<a href="gallery.jsp?galleryCategory=배경 일러스트" class="btn btn-Skyblue">배경 일러스트</a>
            	<a href="gallery.jsp?galleryCategory=스케치" class="btn btn-Skyblue">스케치</a>
            </div>
            <form class="search" method="get" action="gallery.jsp?keyWord=<%=request.getParameter("keyWord")%>&searchWord=<%=request.getParameter("searchWord")%>">
                <div class="searchCategory">
                    <select id="searchCategory" class="custom-select" name="keyWord">
                        <!--<option id="searchAll" value="all">전체</option>-->
                        <option id="searchTitle" value="galleryTitle">제목</option>
                        <option id="searchNickname" value="userNickname">닉네임</option>
                        <option id="searchComment" value="galleryContent">작품설명</option>
                    </select>
                </div>
                <input id="searchContent" class="form-control mr-sm-2" type="search" aria-label="Search" name="searchWord">
                <input type="submit" id="btnSearch" class="btn btn-Skyblue" value="검색">
            </form>
        </div>
    </div>
    
    <!-- 카테고리 & 검색결과 -->
    <div class="middleSectionWrap">
        <div class="middleSection">
            <i class="fas fa-image fa-2x"></i>
            <%
            if(keyWord.equals("fileName")){
           	%>	
           	<div class="pictureCount" id="pictureCategoryCount"><%=galleryCategory %> (<%=galleryDAO.countTotalPage(galleryCategory, keyWord, searchWord)%>) </div>
           	<%
            }else{
            %>
            <div class="pictureCount" id="pictureCategoryCount"><%=searchWord %>로 검색한 결과 (<%=galleryDAO.countTotalPage(galleryCategory, keyWord, searchWord)%>) </div>
            <%
            }
            %>
        </div>
    </div>
    
    <!-- CardSection -->
    <div class="pictureCardSection">
    <%
    	try{
    		for(int i = 0; i < list.size(); i++){
    %>
				<a class="pictureCard" href="galleryView.jsp?galleryID=<%=list.get(i).getGalleryID()%>">
					<div class="screen">
						<div class="hoverTitle"><%=list.get(i).getGalleryTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></div>
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
					int startPage = galleryDAO.getStartPage(pageNumber);
					int endPage = galleryDAO.getEndPage(pageNumber, galleryCategory, keyWord, searchWord);
					int totalPage = galleryDAO.getTotalPage(galleryCategory, keyWord, searchWord);
					
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
						if(keyWord.equals("fileName") && searchWord.equals(".")){	// 검색값이 없을때
							if(galleryCategory.equals("전체보기")){	// 카테고리가 전체보기(default)일때
				%>				
								<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber -1%>">이전</a></li>
				<%
							}else{	// 카테고리가 default가 아니면 galleryCategory를 파라미터로 전달
				%>
								<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber -1%>&galleryCategory=<%=galleryCategory%>">이전</a></li>
				<% 			
							}
						}else{	// 검색값이 있으면 keyWord, searchWord를 파라미터로 전달
				%>
						<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber -1%>&keyWord=<%=keyWord%>&searchWord=<%=searchWord%>">이전</a></li>
				<%
						}
					}
		    		
					// 페이지 개수 처리
					for(int iCount = startPage; iCount <= endPage; iCount++){
    					if(pageNumber == iCount){	// 해당 페이지일때
    						if(keyWord.equals("fileName") && searchWord.equals(".")){	// 검색값이 없을때
    							if(galleryCategory.equals("전체보기")){	// 카테고리가 전체보기(default)일때
		    	%>
		    					<li class="page-item active"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
    							}else{	// 카테고리가 default가 아니면 galleryCategory를 파라미터로 전달
    			%>				
    							<li class="page-item active"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>&galleryCategory=<%=galleryCategory%>"><%=iCount %></a></li>
		    	<%
		    					}
    						}else{	// 검색값이 있으면 keyWord, searchWord를 파라미터로 전달
		    	%>		
    							<li class="page-item active"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>&keyWord=<%=keyWord%>&searchWord=<%=searchWord%>"><%=iCount %></a></li>
		    	<%
		    				}
		    			}else{	// 해당 페이지가 아닐때
		    				if(keyWord.equals("fileName") && searchWord.equals(".")){	// 검색값이 없을때
    							if(galleryCategory.equals("전체보기")){	// 카테고리가 전체보기(default)일때
		    	%>
		    					<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
    							}else{	// 카테고리가 default가 아니면 galleryCategory를 파라미터로 전달
    			%>				
    							<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>&galleryCategory=<%=galleryCategory%>"><%=iCount %></a></li>
		    	<%
		    					}
    						}else{	// 검색값이 있으면 keyWord, searchWord를 파라미터로 전달
		    	%>		
    							<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>&keyWord=<%=keyWord%>&searchWord=<%=searchWord%>"><%=iCount %></a></li>
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
						if(keyWord.equals("fileName") && searchWord.equals(".")){	// 검색값이 없을때
							if(galleryCategory.equals("전체보기")){
				%>				
								<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber +1%>">다음</a></li>
				<%
							}else{
				%>
								<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber +1%>&galleryCategory=<%=galleryCategory%>">다음</a></li>
				<% 			
							}
						}else{
				%>
						<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber +1%>&keyWord=<%=keyWord%>&searchWord=<%=searchWord%>">다음</a></li>
				<%
						}
					}
		    		if(pageNumber > totalPage){
		    			PrintWriter script = response.getWriter();
		    			script.println("<script>");
		    			script.println("alert('올바르지 않은 접근입니다');");
		    			script.println("history.back()");
		    			script.println("</script>");
		    		}
				%>
					
			</ul>
		</div>
		
    </div>
    
</div>	
</body>
</html>