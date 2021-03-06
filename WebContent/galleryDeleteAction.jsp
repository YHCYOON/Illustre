<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gallery.GalleryDAO"%>
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
			return;
		}
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
		GalleryDAO galleryDAO = new GalleryDAO();
		if(!userID.equals(galleryDAO.getGalleryUserID(galleryID))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다');");
			script.println("history.back()");
			script.println("</script>");
		}else{
			int result = galleryDAO.deleteGallery(galleryID);
			if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('성공적으로 삭제했습니다');");
				script.println("location.href='gallery.jsp'");
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