<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 반응형 웹에 사용되는 메타태그 -->
	<meta name="viewport" content="width=device-width" >
	<link rel="stylesheet" href="css/login.css">
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>일러스트리 - 내가 그려가는 세상</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

<script>
	// 로그인 유효성 검사
	function loginTest(){
		var userID = $('#userID').val()
		var userPassword = $('#userPassword').val()
		if(userID == "" || userID == null){
			alert("아이디를 입력해주세요");
			$('#userID').focus();
			return;
		}
		else if(userPassword == "" || userPassword == null){
			alert("비밀번호를 입력해주세요");
			$('#userPassword').focus();
			return;
		}else{
			$('#loginForm').submit();
		}
	}
</script>
</head>
<body>
	<a href="main.jsp"  id="navLogo"> <img src="images/illustre_logo_white.png" alt="illustre"></a>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- 로고 -->
			<div class="fadeIn first">
				<img src="images/illustre_logo.png" id="icon" alt="illustre" />
			</div>
			<div class="fadeIn second">
				<div id="comment">내가 그려가는 세상</div>
			</div>

			<!-- 로그인 Form -->
			<form id="loginForm" action="loginAction.jsp" method="POST">
				<input type="text" id="userID" class="fadeIn third" name="userID" placeholder="ID"> 
				<input type="password" id="userPassword"	class="fadeIn fourth" name="userPassword" placeholder="Password">
				<input type="button" id="loginBtn" onclick="loginTest()" class="fadeIn fifth" value="로그인"> 
				<input type="button" id="joinBtn" onclick="location.href='join.jsp'" class="fadeIn fifth" value="회원가입">
			</form>

			<!-- 비밀번호 찾기 -->
			<div id="formFooter">
				<a class="underlineHover"  href="forgotPassword.jsp">Forgot Password?</a>
			</div>
		</div>
	</div>
</body>
</html>