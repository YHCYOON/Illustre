<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gallery.GalleryDAO" %>   
<%@page import="galleryLike.GalleryLikeDAO" %>   
<%@page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int galleryID = 0;
		if(request.getParameter("galleryID") != null){
			galleryID = Integer.parseInt(request.getParameter("galleryID"));
		}
		GalleryLikeDAO galleryLikeDAO = new GalleryLikeDAO();
		GalleryDAO galleryDAO = new GalleryDAO();
		int checkLike = galleryLikeDAO.checkLikeCount(userID, galleryID);
		if(checkLike == 0){		// 좋아요가 안되어있는 상태
			galleryLikeDAO.galleryPlusLike(userID, galleryID);	// galleryLike 테이블에 insert
			galleryDAO.galleryPlusLike(galleryID);		// gallery 테이블의 galleryAvailable + 1
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('좋아해 주셔서 감사합니다!');");
			script.println("location.href='galleryView.jsp?galleryID="+galleryID+"'");
			script.println("</script>");
		}else if(checkLike == 1){		// 이미 좋아요가 되어있는 상태
			galleryLikeDAO.galleryMinusLike(userID, galleryID);		// galleryLike 테이블에서 delete
			galleryDAO.galleryMinusLike(galleryID);		// gallery 테이블의 galleryAvailable - 1
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('좋아요가 취소되었습니다');");
			script.println("location.href='galleryView.jsp?galleryID="+galleryID+"'");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다. 다시 시도해주세요');");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>