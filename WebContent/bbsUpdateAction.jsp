<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bbs.Bbs" %>    
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
		// UserID 세션이 있으면 userID에 대입
		String userID = null;
		if(session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
		}
		// userID 가 없으면 로그인 페이지로 이동
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login.jsp'");
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
			// bbsID 파라미터가 정수가 아닐때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 넘어온 bbsID 파라미터가 없을때 접근에러
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		try{
			Bbs bbs = new BbsDAO().getBbs(bbsID);
			// 해당 게시글의 userID와 접속중인 유저의 userID 가 일치하지 않으면 수정 권한이 없음
			if(! userID.equals(bbs.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정 권한이 없습니다');");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 넘어오는 파라미터값들이 없으면 alert
				if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle") == " " || 
					request.getParameter("bbsContent") == " "){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력하지 않은 항목이 있습니다');");
					script.println("history.back()");
					script.println("</script>");
				}else{
					// 게시글 수정 메서드 실행
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.updateBbs(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('데이터베이스 오류입니다');");
						script.println("history.back()");
						script.println("</script>");
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('게시글이 수정되었습니다');");
						script.println("location.href='bbsView.jsp?bbsID="+bbsID+"'");
						script.println("</script>");
					}
				}
			}
		}catch(Exception e){
			// 게시글이 존재하지 않을때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
		
	%>
</body>
</html>