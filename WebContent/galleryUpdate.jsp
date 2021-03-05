<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.util.ArrayList" %>
<%@page import="user.UserDAO" %>    
<%@page import="user.User" %>  
<%@page import="gallery.Gallery" %>
<%@page import="gallery.GalleryDAO" %>
<%@page import="galleryLike.GalleryLikeDAO" %>
<%@page import="galleryComment.GalleryComment" %>
<%@page import="galleryComment.GalleryCommentDAO" %>
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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	<title></title>
<script>
//이미지 첨부시 이름 보여주기
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
                $('.galleryImage').remove();	// 기존 이미지 삭제
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
	int galleryID = 0;
	// 받은 galleryID 파라미터값 galleryID에 넣음, galleryID가 int 값이 아닐때 예외처리
	try{
		if(request.getParameter("galleryID") != null){
			galleryID = Integer.parseInt(request.getParameter("galleryID"));
		}
	}catch(Exception e){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('올바르지 않은 접근입니다. 다시 시도해주세요');");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	
	GalleryDAO galleryDAO = new GalleryDAO();
	int checkGalleryAvailable = galleryDAO.checkGalleryAvailable(galleryID);
	// galleryID 가 1보다 작거나, 현재 존재하는 galleryID보다 크거나, galleryAvailable이 0인 게시글일때 alert발생 이후 history.back()
	if(galleryID < 1 || galleryID > galleryDAO.getGalleryID()-1 || checkGalleryAvailable == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 게시글입니다. 다시 시도해주세요');");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	
%>
<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="main.jsp" onclick="onClickMain()" class="navBarLogo">
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
	
	<%
		Gallery gallery = galleryDAO.getGalleryView(galleryID);
		GalleryCommentDAO galleryCommentDAO = new GalleryCommentDAO();
		ArrayList<GalleryComment> list = new ArrayList<GalleryComment>();
		list = galleryCommentDAO.getGalleryCommentList(galleryID);
	%>
	
    <div class="pictureRegistSectionWrap">
    	<!-- galleryView Form  -->
       	<form id="galleryRegistForm" class="pictureRegistSection" action="galleryUpdateAction.jsp?<%=galleryID %>=multipart" method="post" enctype="multipart/form-data">
            <div>
            	<img class="galleryImage" src="<%=request.getContextPath() %>/upload/<%=gallery.getFileRealName()%>">
            	<div class="filebox preview-image" style="margin-top:10px;">
                	<input class="upload-name" value="<%=gallery.getFileName() %>" disabled="disabled">
                	<label for="input-file">파일 첨부</label>
                    <input type="file" id="input-file" class="upload-hidden" name="fileName">
                </div>
				
				<!-- 댓글 부분 -->
				<%
					if(userID != null){
				%>
					<div style="margin-top:60px; font-size:18px;">댓글 (<%=list.size() %>)</div>
				<%
					}else{
				%>
					<div style="margin-top:20px; font-size:18px;">댓글 (<%=list.size() %>)</div>
				<%
					}
				%>
				
				<%
				for(int i = 0; i < list.size(); i++){
				%>
				<table class="table" style="border: 2px solid #dddddd; margin-top:10px;">
					<tbody>
						<tr>
							<%	// 로그인중인 회원일때 수정,삭제 버튼 표시
								if(userID != null && userID.equals(list.get(i).getUserID())){
							%>
							<td colspan="1" style="padding: 14px;"><%=list.get(i).getUserID()%></td>
							<td style="padding-top:10px; width:60px;"><a href="galleryCommentUpdate.jsp?galleryID=<%=list.get(i).getGalleryID() %>&galleryCommentID=<%=list.get(i).getGalleryCommentID()%>"><button type="button" class="btn btn-Skyblue btn-sm">수정</button></a></td>
							<td style="padding-top:10px; width:60px;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="galleryCommentDeleteAction.jsp?galleryID=<%=list.get(i).getGalleryID() %>&galleryCommentID=<%=list.get(i).getGalleryCommentID()%>">
							<button type="button" class="btn btn-Red btn-sm">삭제</button></a></td>
							<%
								}else{// 비회원은 수정,삭제 표시하지 않음
							%>
							<td colspan="3" style="padding: 14px;"><%=list.get(i).getUserID() %></td>
							<%
								}
							%>
						</tr>
						<tr>
							<td colspan="3"><%=list.get(i).getGalleryCommentDate() %></td>
						</tr>
						<tr>
							<td colspan="3"><%=list.get(i).getGalleryComment() %></td>
						</tr>
					</tbody>
				</table>
				<%
				}
				%>
           	</div>
            <div class="pictureRegistRight">
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">카테고리</label>
                    </div>
                    <select id="galleryCategory" name="galleryCategory" class="custom-select" select="<%=gallery.getGalleryCategory() %>">
                        <option value="카테고리를 선택하세요">카테고리를 선택하세요</option>
                        <option value="캐릭터 일러스트">캐릭터 일러스트</option>
                        <option value="배경 일러스트">배경 일러스트</option>
                        <option value="스케치">스케치</option>
                    </select>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">아티스트</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getUserNickname() %>" readonly >
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">제목</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryTitle() %>" >
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작성일자</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryDate() %>" readonly >
                </div>
                <div class="pictureContent">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작품설명</label>
                    </div>
                    <textarea id="galleryContent" name="galleryContent" class="form-control" rows="26" ><%=gallery.getGalleryContent() %></textarea>
                </div>
                <%
                if(userID.equals(galleryDAO.getGalleryUserID(galleryID))){	// 이 갤러리 게시글을 작성한 사람일때 수정/삭제 표시
                %>
                <div class="pictureRegistBtn" style="margin-top:15px; display:flex;">
                	<a href="galleryUpdateAction.jsp?galleryID=<%=galleryID %>" class="btn btn-Skyblue btn-block"  style="margin:0 10px 0 0;">수정하기</a>
                	<a onclick="return confirm('정말 삭제하시겠습니까?')" href="galleryDeleteAction.jsp?galleryID=<%=galleryID %>" class="btn btn-Skyblue btn-block"  style="margin:0 0 0 10px;">삭제</a>
                </div>
                <%
                }
                %>
                <div class="pictureRegistBtn" style="margin-top:15px;">
                	<%
                		GalleryLikeDAO galleryLikeDAO = new GalleryLikeDAO();
                		int checkLike = galleryLikeDAO.checkLikeCount(userID, galleryID);
                		if(checkLike == 0){
                	%>
                	<a href="galleryLikeAction.jsp?galleryID=<%=gallery.getGalleryID() %>" class="btn btn-Red btn-block">좋아요 <i class="fas fa-heart"> <%=gallery.getGalleryLikeCount() %></i></a>
                	<%
                		}else if(checkLike == 1){
                	%>
                	<a onclick="return confirm('좋아요를 취소하시겠습니까?')" href="galleryLikeAction.jsp?galleryID=<%=gallery.getGalleryID() %>" class="btn btn-noneHoverRed btn-block">좋아요 취소 <i class="fas fa-heart"> <%=gallery.getGalleryLikeCount() %></i></a>
                	<%
                		}else{
                		PrintWriter script = response.getWriter();
                		script.println("<script>");
                		script.println("alert('데이터베이스 오류입니다. 다시 시도해주세요');");
                		script.println("history.back()");
                		script.println("</script>");
                		}
                	%>
                </div>
            </div>
       	</form>
	</div>
	
</div>

</body>
</html>