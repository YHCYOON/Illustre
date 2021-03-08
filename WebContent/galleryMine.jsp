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
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
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
            	<a href="ranking.jsp?category=전체보기" class="btn btn-Skyblue">전체보기</a>
            	<a href="ranking.jsp?category=캐릭터 일러스트" class="btn btn-Skyblue">캐릭터 일러스트</a>
            	<a href="ranking.jsp?category=배경 일러스트" class="btn btn-Skyblue">배경 일러스트</a>
            	<a href="ranking.jsp?category=스케치" class="btn btn-Skyblue">스케치</a>
            </div>
        </div>
    </div>
    
    <!-- 카테고리 & 검색결과 -->
    <div class="middleSectionWrap">
        <div class="middleSection">
            <i class="fas fa-image fa-2x"></i><%=galleryCategory %>
        </div>
    </div>
    <!-- CardSection -->
	<div class="rankSectionTop">
<%
	ArrayList<Gallery> list = galleryDAO.getRanking(category);
	if(list.size() <= 3 ){		//  list 가 3개 이하일때
		for(int i = 0; i < list.size(); i++){
			Gallery gallery = new Gallery();
%>
		<div class="rankCard">
			<a class="rankImg" href="galleryView.jsp?galleryID=<%=list.get(i).getGalleryID()%>">
				<img src="<%=request.getContextPath() %>/upload/<%=list.get(i).getFileRealName()%>">
			</a>
			<div class="rank">
<%
			if(i == 0){
%>
				<div class="gold"><i class="fas fa-medal fa-5x"></i>
				</div>
<%
			}else if(i == 1){
%>			
				<div class="silver"><i class="fas fa-medal fa-5x"></i>
				</div>	
<% 
			}else if(i == 2){
%>			
				<div class="bronze"><i class="fas fa-medal fa-5x"></i>
				</div>		
<%
			}
%>
				<div class="rankContentWrap">
					<div class="rankTitle"><%=list.get(i).getGalleryTitle() %>
					</div>
					<div class="rankNicknameLike">
	    				<div class="rankNickname"><%=list.get(i).getUserNickname() %>
	    				</div>
						<div class="rankLike"><i class="fas fa-heart"></i> <%=list.get(i).getGalleryLikeCount() %>
						</div>
	            	</div>
        		</div>
    		</div>
		</div>
<%
		}
	}else{	// list가 3개 이상
		for(int i = 0; i < 3; i++){
			Gallery gallery = new Gallery();
%>
		<div class="rankCard">
			<a class="rankImg" href="galleryView.jsp?galleryID=<%=list.get(i).getGalleryID()%>">
				<img src="<%=request.getContextPath() %>/upload/<%=list.get(i).getFileRealName()%>">
			</a>
			<div class="rank">
<%
			if(i == 0){
%>
				<div class="gold"><i class="fas fa-medal fa-5x"></i>
				</div>
<%
			}else if(i == 1){
%>			
				<div class="silver"><i class="fas fa-medal fa-5x"></i>
				</div>	
<% 
			}else if(i == 2){
%>			
				<div class="bronze"><i class="fas fa-medal fa-5x"></i>
				</div>		
<%
			}
%>
				<div class="rankContentWrap">
					<div class="rankTitle"><%=list.get(i).getGalleryTitle() %>
					</div>
					<div class="rankNicknameLike">
	    				<div class="rankNickname"><%=list.get(i).getUserNickname() %>
	    				</div>
						<div class="rankLike"><i class="fas fa-heart"></i> <%=list.get(i).getGalleryLikeCount() %>
						</div>
	            	</div>
        		</div>
    		</div>
		</div>
<%			
		}
%>
   	</div>	
   	<div class="pictureCardSection">
<%		
		for(int i = 3; i < list.size(); i++){
			Gallery gallery = new Gallery();
%>
		<a class="pictureCard" href="galleryView.jsp?galleryID=<%=list.get(i).getGalleryID()%>">
			<div class="screen">
				<div class="hoverTitle"><%=list.get(i).getGalleryTitle() %></div>
				<div class="hoveruserNickname"><%=list.get(i).getUserNickname() %></div>
				<div class="hoverLike"><i class="fas fa-heart"><%=list.get(i).getGalleryLikeCount() %></i></div>
				<img id="pictureCard" class="cardImage" src="<%=request.getContextPath() %>/upload/<%=list.get(i).getFileRealName()%>">
			</div>
		</a>
<%
		}
	}
%>
	</div>
</div>        
</body>
</html>