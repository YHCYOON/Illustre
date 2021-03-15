<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>    
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="session"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userNickname" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일러스트리 - 내가 그린 세상</title>
</head>
<body>
	<%
		String userID = null;
		String userNickname = null;
		if(request.getParameter("userID") != null){
			userID = (String) request.getParameter("userID");
		}
		if(request.getParameter("userNickname") != null){
			userNickname = (String) request.getParameter("userNickname");
		}
		// URL 로 joinAction 접근하는 거 방지
		if(userID == null || userNickname == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		UserDAO userDAO = new UserDAO();
		// userID , userNickname 중복검사
		int userIDCheckResult = userDAO.userIDCheck(userID);
		int userNicknameCheckResult = userDAO.userNicknameCheck(userNickname);
		if(userIDCheckResult == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}else if(userNicknameCheckResult == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 닉네임입니다')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}else{
			int result = userDAO.join(user);
			if(result == -1){		// PRIMARY KEY 중복으로 에러
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다')");
				script.println("history.back()");
				script.println("</script>");
				return;
			}else{
				session.setAttribute("UserID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>