<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO" %>    
<%@page import="bbs.Bbs" %>    
<%@page import="java.io.PrintWriter" %>    
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
		if(userID == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요');");
			script.println("location.href = 'login'");
			script.println("</script>");
		}
		// 넘어온 bbsID 파라미터를 bbsID에 대입
		int bbsID = 0;
		try{
			if(request.getParameter("bbsID") != null){
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
		}catch(Exception e){
			// bbsID 가 정수가 아닐때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 넘어온 bbsID 파라미터가 없으면 접근에러 alert
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다');");
			script.println("location.href = 'bbs'");
			script.println("</script>");
			return;
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		try{
			// 해당 글의 userID 와 현재 접속중인 userID 가 일치하지 않으면 권한이 없음
			if(!userID.equals(bbs.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다');");
				script.println("location.href = 'bbs'");
				script.println("</script>");
			}else{
				// 일치하면 게시글 삭제 메서드 실행
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.deleteBbs(bbsID);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다');");
					script.println("history.back()");
					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글을 성공적으로 삭제했습니다');");
					script.println("location.href = 'bbs'");
					script.println("</script>");
				}
			}
		}catch(Exception e){
			// 존재하지 않는 bbsID일때 예외처리
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 페이지입니다');");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>