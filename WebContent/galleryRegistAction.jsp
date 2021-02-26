<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gallery.GalleryDAO" %>
<%@page import="user.UserDAO" %>
<%@page import="java.io.File" %>
<%@page import="java.io.PrintWriter" %>
<!-- 파일 이름이 동일한게 나오면 자동으로 다른것으로 바꿔줌 -->
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 실제로 파일 업로드 하기 위한 클래스 -->
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
    
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
		}else{
			try{
				// 해당 폴더에 이미지를 저장
				String uploadDir = this.getClass().getResource("").getPath();
				uploadDir = uploadDir.substring(1, uploadDir.indexOf(".metadata"))+"Illustre/WebContent/upload"; 
				// 총 100MB 까지 저장 가능하게 함
				int maxSize = 100 * 1024 * 1024;
				String encoding = "UTF-8";
				// 사용자가 전송한 파일정보를 토대로 업로드 장소에 파일 업로드를 수행할수 있게 함
				MultipartRequest multi = new MultipartRequest(request, uploadDir, maxSize, encoding, new DefaultFileRenamePolicy());
				
				// 중복된 파일 이름이 있기에 fileRealName 이 실제로 서버에 저장된 경로이자 파일
				// fileName 은 사용자가 올린 파일의 이름
				String fileName = multi.getOriginalFileName("fileName");
				// 실제 서버에 업로드 된 파일시스템 이름
				String fileRealName = multi.getFilesystemName("fileName");
				
				String galleryCategory = multi.getParameter("galleryCategory");
				String galleryTitle = multi.getParameter("galleryTitle");
				String galleryContent = multi.getParameter("galleryContent");
				
				// MYSQL 에 업로드하는 메서드
				GalleryDAO galleryDAO = new GalleryDAO();
				int result = galleryDAO.upload(userID, multi.getParameter("galleryCategory"), multi.getParameter("galleryTitle"), multi.getParameter("galleryContent"), fileName, fileRealName);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류입니다');");
					script.println("history.back()");
					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('그림을 성공적으로 등록했습니다');");
					script.println("location.href='main.jsp'");
					script.println("</script>");
				}
			}
			catch(Exception e){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('올바르지 않은 접근입니다');");
			script.println("location.href='galleryRegist.jsp'");
			script.println("</script>");
			}
		}
		
		
		
		
	%>
</body>
</html>