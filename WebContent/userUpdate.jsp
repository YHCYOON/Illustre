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
	<meta name="viewport" content="width=device-width" >
	<link rel="stylesheet" href="css/join.css">
	<title>일러스트리 - 내가 그려가는 세상</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>

<script>
//이메일 유효성 검사
function emailCheck(userEmail){                                                 
	var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(!reg_email.test(userEmail)) {                            
		return false;         
	}                            
	else {                       
		return true;        
 	}                            
}         

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
				var userNickname = $('#userNickname').val();
				if(userNickname == "" || userNickname == null ){
					$('#nicknameCheck').css('color','red');
					$('#nicknameCheck').text("닉네임을 입력해주세요!");
					
				}
				else if( blank_pattern.test(userNickname) == true){
					$('#nicknameCheck').css('color','red');
					$('#nicknameCheck').text("공백은 사용할수 없습니다!");
				}
				else if( special_pattern.test(userNickname) == true ){
					$('#nicknameCheck').css('color','red');
					$('#nicknameCheck').text("특수문자는 사용할수 없습니다!");
				
				}else{
					 if(result == 1){
				     	$('#nicknameCheck').css('color','red');
						$('#nicknameCheck').text("이미 존재하는 닉네임입니다!");
					}
					 else if(result ==0){
						$('#nicknameCheck').css('color','blue');
						$('#nicknameCheck').text("사용 가능한 닉네임입니다!");
					}
					else{
						$('#nicknameCheck').css('color','red');
						$('#nicknameCheck').text("데이터베이스 오류입니다!");
					}
				}
			}
		});
	});
});

// 회원정보 수정 유효성 검사
function userUpdateTest(){
	var userPassword = $('#userPassword').val();
	var userName = $('#userName').val();
	var userNickname = $('#userNickname').val();
	var userEmail = $('#userEmail').val();
	var blank_pattern = /^\s+|\s+$/g;
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	
	if(userPassword == "" || userPassword == null){
		alert("비밀번호를 입력해주세요");
		$('#userPassword').focus();
		return;
	}
	else if(blank_pattern.test(userPassword) == true ){
		alert("비밀번호에 공백을 사용할수 없습니다");
		$('#userPassword').focus();
		return;
	}
	else if(special_pattern.test(userPassword) == true){
		alert("비밀번호에 특수문자를 사용할수 없습니다");
		$('#userPassword').focus();
		return;
	}
	else if(userName == "" || userName == null){
		alert("이름을 입력해주세요");
		$('#userName').focus();
		return;
	}
	else if(blank_pattern.test(userName) == true ){
		alert("이름에 공백을 사용할수 없습니다");
		$('#userName').focus();
		return;
	}
	else if(special_pattern.test(userName) == true){
		alert("이름에 특수문자를 사용할수 없습니다");
		$('#userName').focus();
		return;
	}
	else if(userNickname == "" || userNickname == null){
		alert("닉네임을 입력해주세요");
		$('#userNickname').focus();
		return;
	}
	else if(blank_pattern.test(userNickname) == true ){
		alert("닉네임에 공백을 사용할수 없습니다");
		$('#userNickname').focus();
		return;
	}
	else if(special_pattern.test(userNickname) == true){
		alert("닉네임에 특수문자를 사용할수 없습니다");
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
		if(userID ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			User user = userDAO.getUserInfo(userID);
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
				<div id="idCheck"></div> 
				<input type="password" id="userPassword" class="fadeIn fourth" name="userPassword" placeholder="비밀번호" value="<%=user.getUserPassword() %>">
				<div id="passwordCheck"></div> 
				<input type="text" id="userName" class="fadeIn fifth"	name="userName" placeholder="이름" value="<%=user.getUserName() %>">
				<div id="nameCheck"></div> 
				<input type="text" id="userNickname" class="fadeIn sixth"	name="userNickname" placeholder="닉네임" value="<%=user.getUserNickname() %>">
				<div id="nicknameCheck"></div> 
				<input type="text" id="userEmail" class="fadeIn seventh"	name="userEmail" placeholder="이메일" value="<%=user.getUserEmail() %>">
				<div id="emailCheck"></div> 
				<input type="button" onclick="userUpdateTest()" class="fadeIn eighth" value="회원정보 수정">
			</form>
		</div>
	</div>
	
	<%
		}
	%>
	
	
	
</body>
</html>