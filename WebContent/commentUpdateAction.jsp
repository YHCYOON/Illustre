<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>   
<%@page import="java.util.ArrayList" %>
<%@page import="bbsComment.BbsComment" %>
<%@page import="bbsComment.BbsCommentDAO" %>
<%request.setCharacterEncoding("UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일러스트리 - 내가 그린 세상</title>
</head>
<body>
	<%
		// 현재 로그인 되어있는 userID인지 검사
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
		}
		// 넘어온 bbsID, bbsCommentID 파라미터를 대입
		int bbsID = 0;
		int bbsCommentID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(request.getParameter("bbsCommentID") != null){
			bbsCommentID = Integer.parseInt(request.getParameter("bbsCommentID"));
		}
		// 넘어온 파라미터가 없으면 에러 처리후 페이지 이동
		if(bbsID == 0 || bbsCommentID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
		// 넘어온 bbsComment 파라미터를 대입
		String bbsComment = null;
		if(request.getParameter("bbsCommentContent") != null){
			bbsComment = request.getParameter("bbsCommentContent");
		}
		// bbsComment가 없거나 공백이면 댓글 작성 alert 
		if(bbsComment == null || bbsComment == "" || bbsComment == " " || bbsComment == "  "  ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글을 작성해주세요');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// bbsCommentID 와 userID 가 일치하지 않으면 수정 권한이 없음
		BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
		if(!userID.equals(bbsCommentDAO.getBbsCommentUserID(bbsCommentID))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다');");
			script.println("location.href='bbs'");
			script.println("</script>");
		}else{
			// userID가 일치하면 updateBbsComment 메서드 실행
			int result = bbsCommentDAO.updateBbsComment(bbsID, bbsCommentID, request.getParameter("bbsCommentContent"));
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류입니다');");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('성공적으로 수정되었습니다');");
				script.println("location.href='bbsView?bbsID="+bbsID+"'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>