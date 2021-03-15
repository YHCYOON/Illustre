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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	<title>일러스트리 - 내가 그린 세상</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<body>
	<%
		// UserID 세션값이 있으면 userID 에 대입
		String userID = null;
		String userNickname = null;
		if (session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
			UserDAO userDAO = new UserDAO();
			// 해당 userID 의 user 객체를 가져옴
			User user = userDAO.getUserInfo(userID);
			// userNickname 에 해당 객체의 userNickname 값을 대입
			userNickname = user.getUserNickname();
		}
		
		// 디폴트 galleryCategory 값은 전체보기
		GalleryDAO galleryDAO = new GalleryDAO();
    	String galleryCategory = "전체보기";
    	try{
    		// 넘어오는 galleryCategory 파라미터가 있을때
	    	if(request.getParameter("galleryCategory") != null){
	    		// 파라미터가 캐릭터 일러스트, 배경 일러스트, 스케치 일때 galleryCategory 에 대입
	    		if(request.getParameter("galleryCategory").equals("캐릭터 일러스트") || request.getParameter("galleryCategory").equals("배경 일러스트") || 
		    		request.getParameter("galleryCategory").equals("스케치")){
		    		galleryCategory = (String) request.getParameter("galleryCategory");
		    	}
	    	}
    	}catch(Exception e){
    		// 예외처리
    		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 카테고리입니다');");
			script.println("history.back()");
			script.println("</script>");
    	}
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
    <!-- 카테고리  -->
    <div class="searchBar">
        <div class="searchBarContent">
            <div class="category">
            	<a href="ranking.jsp?galleryCategory=전체보기" class="btn btn-Skyblue">전체보기</a>
            	<a href="ranking.jsp?galleryCategory=캐릭터 일러스트" class="btn btn-Skyblue">캐릭터 일러스트</a>
            	<a href="ranking.jsp?galleryCategory=배경 일러스트" class="btn btn-Skyblue">배경 일러스트</a>
            	<a href="ranking.jsp?galleryCategory=스케치" class="btn btn-Skyblue">스케치</a>
            </div>
        </div>
    </div>
    
    <!-- 카테고리 & 검색결과 -->
    <div class="middleSectionWrap">
        <div class="middleSection">
            <i class="fas fa-trophy fa-2x"></i><%=galleryCategory %>
        </div>
    </div>
    <!-- CardSection -->
	<div class="rankSectionTop">
<%
	// galleryCategory 별로 getRanking 메서드를 이용해 Gallery 객체의 배열을 가져옴
	ArrayList<Gallery> list = galleryDAO.getRanking(galleryCategory);
	//list 가 3개 이하일때
	if(list.size() <= 3 ){		
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
					<div class="rankTitle"><%=list.get(i).getGalleryTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %>
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
					<div class="rankTitle"><%=list.get(i).getGalleryTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %>
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
				<div class="hoverTitle"><%=list.get(i).getGalleryTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></div>
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