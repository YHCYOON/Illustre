<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   
<%@ page import="bbsComment.BbsCommentDAO" %> 
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
		int bbsID = 0;
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{
			if(request.getParameter("bbsCommentContent") == null || request.getParameter("bbsCommentContent") == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글을 입력해주세요');");
				script.println("history.back()");
				script.println("</script>");
			}else{
				BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
					bbsID = Integer.parseInt(request.getParameter("bbsID"));
					int result = bbsCommentDAO.writeBbsComment(bbsID, userID, request.getParameter("bbsCommentContent"));
					if(result == 1){
						PrintWriter script = response.getWriter();
						response.sendRedirect("bbsView.jsp?bbsID="+bbsID);
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('데이터베이스 오류입니다');");
						script.println("history.back()");
						script.println("</script>");
					}
			}
		}
	%>
</body>
</html>