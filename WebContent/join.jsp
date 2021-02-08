<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 반응형 웹에 사용되는 메타태그 -->
	<meta name="viewport" content="width=device-width" >
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
	
	// 아이디 중복 체크
	$(function(){
		$('#userID').blur(function(){
			var userID = $('#userID').val();
			$.ajax({
				type:"post",
				url:"./IDCheckAction",
				data:{userID : userID},
				success: function(result){
					var blank_pattern = /^\s+|\s+$/g;
					var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
					if(userID == "" || userID == null ){
						$('#idCheck').css('color','red');
						$('#idCheck').text("아이디를 입력해주세요!");
						return;
					}
					else if( blank_pattern.test(userID) == true){
						$('#idCheck').css('color','red');
						$('#idCheck').text("공백은 사용할수 없습니다!");
						return;
					}
					else if( special_pattern.test(userID) == true ){
						$('#idCheck').css('color','red');
						$('#idCheck').text("특수문자는 사용할수 없습니다!");
						return;
					}else{
						 if(result == 1){
						    $('#idCheck').css('color','red');
							$('#idCheck').text("이미 존재하는 아이디입니다!");
						}
						 else if(result ==0){
							$('#idCheck').css('color','blue');
							$('#idCheck').text("사용 가능한 아이디입니다!");
						}
						else{
							$('#idCheck').css('color','red');
							$('#idCheck').text("데이터베이스 오류입니다!");
						}
					}
				}
			});
		});
	});
	
	$(function(){
		$('#userPassword').blur(function(){
			var userPassword = $('#userPassword').val();
			if (userPassword == ""){
				$('#passwordCheck').text("비밀번호를 입력해주세요!");
			}
		});
	});
	
	// 닉네임 중복체크
	$(function(){
		$('#userNickname').blur(function(){
			var userNickname = $('#userNickname').val();
			$.ajax({
				type:"post",
				url:"./NicknameCheckAction",
				data:{userNickname : userNickname},
				success: function(result){
					var blank_pattern = /^\s+|\s+$/g;
					var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
					if(userNickname == "" || userNickname == null ){
						$('#nicknameCheck').css('color','red');
						$('#nicknameCheck').text("닉네임을 입력해주세요!");
						return;
					}
					else if( blank_pattern.test(userNickname) == true){
						$('#nicknameCheck').css('color','red');
						$('#nicknameCheck').text("공백은 사용할수 없습니다!");
						return;
					}
					else if( special_pattern.test(userNickname) == true ){
						$('#nicknameCheck').css('color','red');
						$('#nicknameCheck').text("특수문자는 사용할수 없습니다!");
						return;
					}else{
						 if(result == 1){
							$('#nicknameCheck').css('color','red');
							$('#nicknameCheck').text("이미 존재하는 닉네임입니다!");
							return;
						}
						 else if(result ==0){
							$('#nicknameCheck').css('color','blue');
							$('#nicknameCheck').text("사용 가능한 닉네임입니다!");
							return;
						}
						else{
							$('#nicknameCheck').css('color','red');
							$('#nicknameCheck').text("데이터베이스 오류입니다!");
							return;							
						}
					}
				}
			});
		});
	});
	

	
	
	
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
			$('#emailCheck').text("이메일 형식으로 입력해주세요!");
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
				<div id="idCheck"></div> 
				<input type="password" id="userPassword" class="fadeIn fourth" name="userPassword" placeholder="Password">
				<div id="passwordCheck"></div> 
				<input type="text" id="userName" class="fadeIn fifth"	name="userName" placeholder="이름">
				<div id="nameCheck"></div> 
				<input type="text" id="userNickname" class="fadeIn sixth"	name="userNickname" placeholder="닉네임">
				<div id="nicknameCheck"></div> 
				<input type="text" id="userEmail" class="fadeIn seventh"	name="userEmail" placeholder="이메일">
				<div id="emailCheck"></div> 
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