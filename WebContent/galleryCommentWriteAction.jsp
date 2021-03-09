<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="galleryComment.GalleryCommentDAO" %>
<%@page import="gallery.GalleryDAO" %>
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
			script.println("location.href='login.jsp'");
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
		String galleryComment = request.getParameter("galleryCommentContent");
		if(galleryComment.equals(null) || galleryComment.equals("") || galleryComment.equals(" ")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글을 입력해주세요');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}else{
			GalleryCommentDAO galleryCommentDAO = new GalleryCommentDAO();
			int result = galleryCommentDAO.writeGalleryComment(galleryID, userID, galleryComment);
			if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글이 등록되었습니다');");
				script.println("location.href='galleryView.jsp?galleryID="+galleryID+"'");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류입니다');");
				script.println("history.back()");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>