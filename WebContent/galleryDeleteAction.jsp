<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gallery.GalleryDAO"%>
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
		// 로그인 유무 검사
		String userID = null;
		if(session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
		}
		// 로그인 안되어 있으면 로그인페이지로 이동
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login'");
			script.println("</script>");
			return;
		}
		// 넘겨받은 galleryID 파라미터가 없으면 에러
		int galleryID = 0;
		if(request.getParameter("galleryID") != null){
			galleryID = Integer.parseInt(request.getParameter("galleryID"));
		}
		if(galleryID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다. 다시 시도해주세요');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 갤러리의 userID와 현재 접속중인 userID가 일치하지 않으면 권한이 없음 
		GalleryDAO galleryDAO = new GalleryDAO();
		if(!userID.equals(galleryDAO.getGalleryView(galleryID).getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다');");
			script.println("history.back()");
			script.println("</script>");
		}else{ // userID가 일치하면 deleteGallery메서드 실행
			int result = galleryDAO.deleteGallery(galleryID);
			if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('성공적으로 삭제했습니다');");
				script.println("location.href='gallery'");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류입니다. 다시 시도해주세요');");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>