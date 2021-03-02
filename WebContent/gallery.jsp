<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		GalleryDAO galleryDAO = new GalleryDAO();
    	String galleryCategory = "전체보기";
    	if(request.getParameter("galleryCategory") != null){
    		galleryCategory = (String) request.getParameter("galleryCategory");
    	}
    	// keyWord , searchWord 값이 default 일때 모든 파일을 보여줌
    	String keyWord = "fileName";
    	String searchWord = ".";
    	
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
						    <li role="presentation" ><a href="userUpdate.jsp" role="menuitem" tabindex="-1">회원정보 수정</a></li>
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
				<a class="pictureCard" href="/galleryView.jsp?galleryID=<%=list.get(i).getGalleryID()%>">
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
    %>	
	<!-- 페이징 처리  -->
		<div class="text-center">
			<ul class="pagination">
				<%
					int startPage = galleryDAO.getStartPage(pageNumber);
					int endPage = galleryDAO.getEndPage(pageNumber, galleryCategory, keyWord, searchWord);
					int totalPage = galleryDAO.getTotalPage(galleryCategory, keyWord, searchWord);
					if(pageNumber == 1){
				%>
		    		<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">이전</a></li>
		    	<%
					}else{	
		    	%>
		    		<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber -1 %> " tabindex="-1">이전</a></li>
		    	<%
					}
		    		for(int iCount = startPage; iCount <= endPage; iCount++){
    					if(pageNumber == iCount){
		    	%>
		    				<li class="page-item active"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
		    			}else{
		    	%>		
		    				<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=iCount%>"><%=iCount %></a></li>
		    	<%
		    			}
		    		}
		    		if(pageNumber == totalPage){
				%>	
		    		<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
		    	<%
					}else{
		    	%>
		    		<li class="page-item"><a class="page-link" href="gallery.jsp?pageNumber=<%=pageNumber +1%>">다음</a></li>
				<%
					}
		    		if(pageNumber > totalPage || pageNumber < 1 ){
		    			PrintWriter script = response.getWriter();
		    			script.println("<script>");
		    			script.println("alert('올바르지 않은 페이지 번호입니다');");
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