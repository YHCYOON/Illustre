<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>   
<%@page import="bbsComment.BbsCommentDAO" %> 
<%response.setCharacterEncoding("UTF-8"); %>
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
		int bbsCommentID = 0;
		if(request.getParameter("bbsCommentID") != null){
			bbsCommentID = Integer.parseInt(request.getParameter("bbsCommentID"));
		}
		if(bbsCommentID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
		if(!userID.equals(bbsCommentDAO.getBbsCommentUserID(bbsCommentID))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다');");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}else{
			int result = bbsCommentDAO.deleteBbsComment(bbsCommentID);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류입니다');");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글이 삭제되었습니다');");
				script.println("location.href='bbsView.jsp?bbsID="+bbsID+"'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>