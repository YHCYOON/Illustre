<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>    
<%@ page import="user.UserDAO" %>    
<%@ page import="java.io.PrintWriter" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="session"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
	<meta charset="UTF-8">
	<title>일러스트리 - 내가 그린 세상</title>
</head>
<body>
		
	<%
		// UserID 세션값이 있으면 userID 에 대입
		String userID = null;
		String userPassword = null;
		if(session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
		}
		// UserID 세션값이 있으면 로그인 할수 없음
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 넘어오는 userPassword 값이 있으면 userPassword 에 대입
		if(request.getParameter("userPassword") != null){
			userPassword = (String) request.getParameter("userPassword");
		}
		// URL 로 joinAction 접근하는 거 방지 - 넘어오는 userPassowrd 값이 있어야함
		if(userPassword == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 로그인 메서드 호출
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){
			session.setAttribute("UserID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 비밀번호입니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 존재하지 않습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>