<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹에 사용되는 메타태그 -->
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/forgotPassword.css">
<link rel="stylesheet" href="css/bootstrap.css">
<title>일러스트리 - 내가 그린 세상</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<script type="text/javascript">
	// 이메일 유효성 검사
	function emailCheck(userEmail) {
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		if (!reg_email.test(userEmail)) {
			return false;
		} else {
			return true;
		}
	}


	// 비밀번호 반환
	function findPassword(){
		var userID = $('#userID').val();
		var userName = $('#userName').val();
		var userEmail = $('#userEmail').val();
		$.ajax({
			type:"post",
			url : "./ForgotPasswordAction",
			data:{
				userID: userID,
				userName: userName,
				userEmail: userEmail
			},
			success: function(result){
				console.log(result)
				if(userID == "" || userID == null){
					alert("아이디를 입력해주세요");
					$('#userID').focus();
					return;
				}
				else if(userName == "" || userName == null){
					alert("이름을 입력해주세요");
					$('#userName').focus();
					return;
				}
				else if (userEmail == "" || userEmail == null || userEmail == 'undefined') {
					alert("이메일을 입력해주세요");
					$('#userEmail').focus();
					return;
				} 
				else if (!emailCheck(userEmail)) {
					$('#emailCheck').text("이메일 형식으로 입력해주세요!");
					$('#userEmail').focus();
					return;
				}
				else{
					$('#showPassword').attr('value', result);
					return;
				}
				
			}
		});
	};

</script>
</head>
<body>
	<a href="main.jsp" id="navLogo"> <img
		src="images/illustre_logo_white.png" alt="illustre"></a>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- 로고 -->
			<div class="fadeIn first">
				<img src="images/illustre_logo.png" id="icon" alt="illustre" />
			</div>
			<div class="fadeIn second">
				<div id="comment">내가 그려가는 세상</div>
			</div>

			<!-- 비밀번호 찾기 Form -->
			
				<input type="text" id="userID" class="fadeIn third" name="userID"	placeholder="ID">
				<div id="idCheck"></div>
				<input type="text" id="userName" class="fadeIn fourth"	name="userName" placeholder="이름">
				<div id="nameCheck"></div>
				<input type="text" id="userEmail" class="fadeIn fifth"	name="userEmail" placeholder="이메일">
				<div id="emailCheck"></div>
				<input type="text" id="showPassword" class="fadeIn sixth" value="" readonly>
				<div id="showPasswordCheck"></div>
				<input type="button" onclick="findPassword()" class="fadeIn seventh"	value="비밀번호 찾기">
			

			<!-- 비밀번호 찾기 -->
			<div id="formFooter">
				<a class="underlineHover"href="login.jsp">로그인</a>
			</div>

			
		</div>
	</div>
</body>
</html>