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
	<title>일러스트리 - 내가 그린 세상</title>
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
			script.println("location.href='login'");
			script.println("</script>");
		}
		int galleryID = 0;
		// 받은 galleryID 파라미터값 galleryID에 넣음, galleryID가 int 값이 아닐때 예외처리
		try{
			if(request.getParameter("galleryID") != null){
				galleryID = Integer.parseInt(request.getParameter("galleryID"));
			}
		}catch(Exception e){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다. 다시 시도해주세요');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		
		GalleryDAO galleryDAO = new GalleryDAO();
		int checkGalleryAvailable = galleryDAO.checkGalleryAvailable(galleryID);
		// galleryID 가 1보다 작거나, 현재 존재하는 galleryID보다 크거나, galleryAvailable이 0인 게시글일때 alert발생 이후 history.back()
		if(galleryID < 1 || galleryID > galleryDAO.getGalleryID()-1 || checkGalleryAvailable == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 게시글입니다. 다시 시도해주세요');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		
		GalleryLikeDAO galleryLikeDAO = new GalleryLikeDAO();
		
		int checkLike = galleryLikeDAO.checkLikeCount(userID, galleryID);
		
		if(checkLike == 0){		// 좋아요가 안되어있는 상태
			galleryLikeDAO.galleryPlusLike(userID, galleryID);	// galleryLike 테이블에 insert
			galleryDAO.galleryPlusLike(galleryID);		// gallery 테이블의 galleryAvailable + 1
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('좋아해 주셔서 감사합니다!');");
			script.println("location.href='galleryView?galleryID="+galleryID+"'");
			script.println("</script>");
		}else if(checkLike == 1){		// 이미 좋아요가 되어있는 상태
			galleryLikeDAO.galleryMinusLike(userID, galleryID);		// galleryLike 테이블에서 delete
			galleryDAO.galleryMinusLike(galleryID);		// gallery 테이블의 galleryAvailable - 1
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('좋아요가 취소되었습니다');");
			script.println("location.href='galleryView?galleryID="+galleryID+"'");
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