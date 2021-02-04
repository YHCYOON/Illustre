<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

	// 회원가입 유효성 검사
	function joinTest(){
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
			$('#joinForm').submit();
		}
	}
</script>
</head>
<body>
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
			<form id="joinForm" action="joinAction.jsp" method="POST">
				<input type="text" id="userID" class="fadeIn third" name="userID" placeholder="ID"> 
				<input type="password" id="userPassword" class="fadeIn fourth" name="userPassword" placeholder="Password">
				<input type="text" id="userName" class="fadeIn fifth"	name="userName" placeholder="이름">
				<input type="text" id="userNickname" class="fadeIn sixth"	name="userNickname" placeholder="닉네임">
				<input type="text" id="userEmail" class="fadeIn seventh"	name="userEmail" placeholder="이메일">
				<div id="emailError"></div> 
				<input type="button" onclick="joinTest()" class="fadeIn eighth" value="회원가입">
			</form>

			<!-- 비밀번호 찾기 -->
			<div id="formFooter">
				<a class="underlineHover" href="#">Forgot Password?</a>
			</div>
		</div>
	</div>
</body>
</html>