<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 반응형 웹에 사용되는 메타태그 -->
	<meta name="viewport" content="width=device-width" , initial-scale="1">
	<link rel="stylesheet" href="css/join.css">
	<title>일러스트리 - 내가 그려가는 세상</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>

<script>
	// 이메일 유효성 검사
	function emailCheck(userEmail){                                                 
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		if(!reg_email.test(userEmail)) {                            
			return false;         
		}                            
		else {                       
			return true;        
     	}                            
	}         

	// 회원정보 수정 유효성 검사
	function userUpdateTest(){
		var userID = $('#userID').val();
		var userPassword = $('#userPassword').val();
		var userName = $('#userName').val();
		var userNickname = $('#userNickname').val();
		var userEmail = $('#userEmail').val();
		
		if(userID == ""){
			alert("아이디를 입력해주세요");
			$('#userID').focus();
			return;
		}
		else if(userPassword == ""){
			alert("비밀번호를 입력해주세요");
			$('#userPassword').focus();
			return;
		}
		else if(userName == ""){
			alert("이름을 입력해주세요");
			$('#userName').focus();
			return;
		}
		else if(userNickname == ""){
			alert("닉네임을 입력해주세요");
			$('#userNickname').focus();
			return;
		}
		else if(userEmail == "" || userEmail == 'undefined'){
			alert("이메일을 입력해주세요");
			$('#userEmail').focus();
			return;
		}
		else if(! emailCheck(userEmail)){
			$('#emailError').text("이메일 형식으로 입력해주세요!");
			$('#userEmail').focus();
			return;
		}
		else{
			$('#userUpdateForm').submit();
		}
	}
</script>
</head>
<body>
	<%
		String userID = null;
		if( session.getAttribute("UserID") != null){
			userID = (String) session.getAttribute("UserID");
		}
	%>
	
	<%
		if(userID != null){
			User user = new UserDAO().getUserInfo(userID);
			
	%>
	<a href="main.jsp" id="navLogo"> <img src="images/illustre_logo_white.png" alt="illustre"></a>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- 로고 -->
			<div class="fadeIn first">
				<img src="images/illustre_logo.png" id="icon" alt="illustre" />
			</div>
			<div class="fadeIn second">
				<div id="comment">내가 그려가는 세상</div>
			</div>

			<!-- 회원가입 Form -->
			<form id="userUpdateForm" action="userUpdateAction.jsp" method="POST">
				<input type="text" id="userID" class="fadeIn third" name="userID" value="<%=user.getUserID() %>" readonly> 
				<input type="password" id="userPassword" class="fadeIn fourth" name="userPassword" value="<%=user.getUserPassword() %>">
				<input type="text" id="userName" class="fadeIn fifth"	name="userName" value="<%=user.getUserName() %>">
				<input type="text" id="userNickname" class="fadeIn sixth"	name="userNickname" value="<%=user.getUserNickname() %>">
				<input type="text" id="userEmail" class="fadeIn seventh"	name="userEmail" value="<%=user.getUserEmail() %>">
				<div id="emailError"></div> 
				<input type="button" onclick="userUpdateTest()" class="fadeIn eighth" value="회원정보 수정">
			</form>
		</div>
	</div>
	<%
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다')");
			script.println("location.href='login.jsp");
			script.println("</script>");
		}
	%>
	
</body>
</html>