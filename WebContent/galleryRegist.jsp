<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="user.UserDAO" %>    
<%@page import="user.User" %>  
<%request.setCharacterEncoding("UTF-8"); %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="css/galleryRegist.css">
	<link rel="stylesheet" href="css/customBootstrap.css">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<title></title>
	
<script>
	// 이미지 첨부시 이름 보여주기
	$(document).ready(function(){
	   var fileTarget = $('.filebox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            // 파일명 추출
	            var filename = $(this)[0].files[0].name;
	        } 

	        else {
	            // Old IE 파일명 추출
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        };

	        $(this).siblings('.upload-name').val(filename);
	    });

	    // 이미지 첨부시 미리보기 
	    var imgTarget = $('.preview-image .upload-hidden');

	    imgTarget.on('change', function(){
	        var parent = $(this).parent();
	        parent.children('.upload-display').remove();

	        if(window.FileReader){
	        	//image 파일만
	            if (!$(this)[0].files[0].type.match(/image\//)) 
	            	return;
	            
	            var reader = new FileReader();
	            reader.onload = function(e){
	                var src = e.target.result;
	                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
	            }
	            reader.readAsDataURL($(this)[0].files[0]);
	        }

	        else {
	            $(this)[0].select();
	            $(this)[0].blur();
	            var imgSrc = document.selection.createRange().text;
	            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

	            var img = $(this).siblings('.upload-display').find('img');
	            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
	        }
	    });
	});
	
	// 입력 항목 유효성 검사 
	function galleryRegist(){
		var galleryCategory = $('#galleryCategory').val();
		var galleryTitle = $('#galleryTitle').val();
		var galleryContent = $('#galleryContent').val();
		var imgFile = $('#input-file').val();
		var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
		var maxSize = 100 * 1024 * 1024;
		
		if($('#input-file').val() == ""){
			alert('그림을 첨부해주세요');
			$('#input-file').focus();
			return;
		}
		if(imgFile != "" && imgFile != null){
			fileSize = document.getElementById("input-file").files[0].size;
			if(!imgFile.match(fileForm)){
				alert('이미지 파일만 첨부해주세요');
				return;
			}else if(fileSize > maxSize){
				alert('파일 사이즈는 100MB까지 가능합니다');
				return;
			}
		}
		
		if(galleryCategory == "카테고리를 선택하세요"){
			alert('카테고리를 선택해주세요');
			galleryCategory.focus();
		}else if(galleryTitle == null || galleryTitle == "" || galleryTitle == " "){
			alert('제목을 입력해주세요');
			galleryTitle.focus();
		}else if(galleryContent == null || galleryContent == "" || galleryContent == " "){
			alert('작품 설명을 입력해주세요');
			galleryContent.focus();
		}
		else{
			$('#galleryRegistForm').submit();
		}
	}
	  
</script>
</head>
<body>
<%
	String userID = null;
	String userNickname = null;
	if(session.getAttribute("UserID") != null){
		userID = (String) session.getAttribute("UserID");
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUserInfo(userID);
		userNickname = user.getUserNickname();
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다');");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
%>
<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="main.jsp" class="navBarLogo">
                <img src="images/illustre_logo.png" alt="illustre">
            </a>
            <div class="navContent">
                <div class="gallery">
                    <a href="gallery.jsp">갤러리</a>
                </div>
                <div class="ranking">
                    <a href="ranking.jsp">랭킹</a>
                </div>
                <div class="pictureRegist">
                    <a href="galleryRegist.jsp">그림등록</a>
                </div>
                <div class="myPicture">
                    <a href="myPicture.jsp">나의그림</a>
                </div>
                <div class="community">
                    <a href="bbs.jsp">커뮤니티</a>
                </div>
            </div>
            <%
            	if(userID != null){
            %>
	            <div class="helloUser">
	                <div class="hello">안녕하세요</div>
	                <div class="user"><%=userNickname %>님!</div>
	            </div>
	            <div class="logOutBtn">
	                <div class="dropdown">
  						<button class="btn btn-Skyblue dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
  						회원관리<span class="caret"></span></button>
		  				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
						    <li role="presentation"><a href="userUpdate.jsp" role="menuitem" tabindex="-1">회원정보 수정</a></li>
						    <li role="presentation" class="divider"></li>
						    <li role="presentation"><a href="logoutAction.jsp" role="menuitem" tabindex="-1">로그아웃</a></li>
						</ul>
					</div>
	            </div>
            <%
            	}else{
            %>
            	<div class="helloUser">
	                <div class="hello">안녕하세요</div>
	                <div class="user">로그인이 필요합니다</div>
	            </div>
	            <div class="logOutBtn">
	                <a href="login.jsp" class="btn btn-Skyblue btn-sm">로그인</a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>

    <div class="pictureRegistSectionWrap">
    	<!-- 그림등록 Form  -->
       	<form id="galleryRegistForm" action="galleryRegistAction.jsp" method="post" enctype="multipart/form-data" class="pictureRegistSection">
            <div class="pictureRegistLeft">
                <div class="filebox preview-image">
                	<input class="upload-name" value="파일을 첨부해주세요" disabled="disabled">
                	
                	<label for="input-file">파일 첨부</label>
                    <input type="file" id="input-file" class="upload-hidden" name="fileName">
                </div>
            </div>

            <div class="pictureRegistRight">
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">카테고리</label>
                    </div>
                    <select id="galleryCategory" name="galleryCategory" class="custom-select">
                        <option value="카테고리를 선택하세요">카테고리를 선택하세요</option>
                        <option value="캐릭터 일러스트">캐릭터 일러스트</option>
                        <option value="배경 일러스트">배경 일러스트</option>
                        <option value="스케치">스케치</option>
                    </select>
                </div>
                <div class="pictureTitle">
                    <div class="input-group-prepend">
                        <label class="input-group-text">제목</label>
                        <input type="text" id="galleryTitle" name="galleryTitle" class="form-control">
                    </div>
                </div>
                <div class="pictureComment">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작품설명</label>
                    </div>
                    <textarea id="galleryContent" name="galleryContent" class="form-control" rows="26"></textarea>
                </div>
                <div class="pictureRegistBtn">
                	<input type="button" onclick="galleryRegist()" class="btn btn-noneHoverSkyBlue btn-lg btn-block" value="그림 등록하기">
                </div>
            </div>
       	</form>
	</div>
</div>

</body>
</html>