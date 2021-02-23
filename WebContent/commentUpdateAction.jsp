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
		int bbsID = 0;
		int bbsCommentID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(request.getParameter("bbsCommentID") != null){
			bbsCommentID = Integer.parseInt(request.getParameter("bbsCommentID"));
		}
		if(bbsID == 0 || bbsCommentID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
		String bbsComment = null;
		if(request.getParameter("bbsCommentContent") != null){
			bbsComment = request.getParameter("bbsCommentContent");
		}
		if(bbsComment == null || bbsComment == "" || bbsComment == " " || bbsComment == "  "  ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글을 작성해주세요');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
		if(!userID.equals(bbsCommentDAO.getBbsCommentUserID(bbsCommentID))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다');");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		else{
			int result = bbsCommentDAO.updateBbsComment(bbsID, bbsCommentID, request.getParameter("bbsCommentContent"));
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류입니다');");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				/* response.sendRedirect("view.jsp?bbsID="+bbsID); */
				script.println("<script>");
				script.println("alert('성공적으로 수정되었습니다');");
				script.println("location.href='bbsView.jsp?bbsID="+bbsID+"'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>