<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>   
<%@page import="bbsComment.BbsCommentDAO" %> 
<%response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일러스트리 - 내가 그린 세상</title>
</head>
<body>
	<%
		// UserID 세션값이 있으면 userID 에 대입
		String userID = null;
		if(session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
		}
		// UserID 세션값이 없을때 로그인 페이지로 이동
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		// 넘어온 bbsCommentID 파라미터를 bbsCommentID 에 대입
		int bbsCommentID = 0;
		try{
			if(request.getParameter("bbsCommentID") != null){
				bbsCommentID = Integer.parseInt(request.getParameter("bbsCommentID"));
			}
		}catch(Exception e){
			// 넘어온 bbsCommentID 가 정수가 아닐때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 넘어온 bbsCommentID 파라미터가 없을때 접근에러 alert
		if(bbsCommentID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 넘어온 bbsID 파라미터를 bbsID에 대입
		int bbsID = 0;
		try{
			if(request.getParameter("bbsID") != null){
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
		}catch(Exception e){
			// bbsID가 정수가 아닐때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		try{
			// 해당 댓글의 userID와 접속중인 사용자의 userID 가 일치하지 않으면 권한이 없음
			BbsCommentDAO bbsCommentDAO = new BbsCommentDAO();
			if(!userID.equals(bbsCommentDAO.getBbsCommentUserID(bbsCommentID))){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다');");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}else{
				// 게시글 삭제 메서드 실행
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
		}catch(Exception e){
			// 존재하지 않는 게시글일때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 게시글입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>