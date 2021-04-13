<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   
<%@ page import="bbsComment.BbsCommentDAO" %> 
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
		int bbsID = 0;
		// 로그인 안되어 있으면 로그인페이지로 이동
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login'");
			script.println("</script>");
		}else{
			// 로그인 되어있으면 넘어온 파라미터들 유효성검사
			if(request.getParameter("bbsCommentContent") == null || request.getParameter("bbsCommentContent") == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글을 입력해주세요');");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 유효성 검사 후 writeBbsComment 메서드 실행
				BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
					bbsID = Integer.parseInt(request.getParameter("bbsID"));
					int result = bbsCommentDAO.writeBbsComment(bbsID, userID, request.getParameter("bbsCommentContent"));
					if(result == 1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('댓글이 등록되었습니다');");
						script.println("location.href='bbsView?bbsID="+bbsID+"'");
						script.println("</script>");
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