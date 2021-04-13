<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<%@page import="bbs.BbsDAO" %>
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
			script.println("location.href='login'");
			script.println("</script>");
		}else{
			// 넘어온 파라미터가 없을 때 
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle") == "" 
					|| request.getParameter("bbsContent") == "" ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력하지 않은 항목이 있습니다');");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 게시글 작성 메서드 실행
				BbsDAO bbsDAO = new BbsDAO();
				int result =bbsDAO.write(request.getParameter("bbsTitle"), request.getParameter("bbsContent"), userID);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류입니다');");
					script.println("history.back()");
					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글을 성공적으로 등록했습니다');");
					script.println("location.href='bbs'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>