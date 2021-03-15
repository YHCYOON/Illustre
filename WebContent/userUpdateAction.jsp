<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>    
<%@ page import="user.UserDAO" %>    
<%@ page import="java.io.PrintWriter" %> 
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="session"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userNickname"/>
<jsp:setProperty name="user" property="userEmail"/>
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
		String userNickname = null;
		if(session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
		}
		// 넘어오는 userNickname 파라미터가 있으면 userNickname 에 대입
		if(request.getParameter("userNickname") != null){
			userNickname = (String) request.getParameter("userNickname");
		}
		// URL로 userUpdateAction 접근하는거 방지 - 넘어오는 userNickname 파라미터가 있어야함
		if(userNickname == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// UserID 세션값이 없을때 로그인 페이지로 이동
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요');");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else {
			UserDAO userDAO = new UserDAO();
			int userNicknameCheck = userDAO.userNicknameCheck(userNickname);
			// userNickname 가 이미 존재할때
			if(userNicknameCheck != 0){
				// userNickname이 해당 user의 닉네임이 아니면
				if(!userNickname.equals(user.getUserNickname())){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 닉네임입니다');");
					script.println("history.back()");
					script.println("</script>");
					return;
				}
				// userNickname의 수정이 없으면
				else{
					int result = userDAO.updateUserInfo(user);
					if(result == 1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('수정 완료되었습니다');");
						script.println("location.href = 'main.jsp'");
						script.println("</script>");
						return;
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('데이터베이스 오류입니다');");
						script.println("history.back()");
						script.println("</script>");
						return;
					}
				}
			}
			// userNickname 가 존재하지 않을때 
			else  {
				int result = userDAO.updateUserInfo(user);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정 완료되었습니다');");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
					return;
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류입니다');");
					script.println("history.back()");
					script.println("</script>");
					return;
				}
			}
		}
	%>
</body>
</html>