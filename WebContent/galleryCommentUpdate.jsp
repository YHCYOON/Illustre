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
	<title>일러스트리 - 내가 그린 세상</title>
	
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
	int galleryCommentID = 0;
	// 받은 galleryCommentID 파라미터값을 galleryCommentID에 넣음, galleryCommentID가 int값이 아닐때 예외처리
	try{
		if(request.getParameter("galleryCommentID") != null){
			galleryCommentID = Integer.parseInt(request.getParameter("galleryCommentID"));
		}
	}catch(Exception e){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('올바르지 않은 접근입니다. 다시 시도해주세요');");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	GalleryCommentDAO galleryCommentDAO = new GalleryCommentDAO();
	int checkGalleryCommentAvailable = galleryCommentDAO.checkGalleryCommentAvailable(galleryCommentID);
	// galleryCommentID 가 1보다 작거나, 현재 존재하는 galleryCommentID 보다 크거나, galleryCommentAvailable 이 0인 댓글일때 alert 이후 history.back()
	if(galleryCommentID < 1 || galleryCommentID > galleryCommentDAO.getGalleryCommentID()-1 || checkGalleryCommentAvailable == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 댓글입니다. 다시 시도해주세요');");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	UserDAO userDAO = new UserDAO();
%>

<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="main" onclick="onClickMain()" class="navBarLogo">
                <img src="images/illustre_logo.png" alt="illustre">
            </a>
            <div class="navContent">
                <div class="gallery">
                    <a href="gallery">갤러리</a>
                </div>
                <div class="ranking">
                    <a href="ranking">랭킹</a>
                </div>
                <div class="pictureRegist">
                    <a href="galleryRegist">그림등록</a>
                </div>
                <div class="myPicture">
                    <a href="galleryMine">나의그림</a>
                </div>
                <div class="community">
                    <a href="bbs">커뮤니티</a>
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
						    <li role="presentation"><a href="userUpdate" role="menuitem" tabindex="-1">회원정보 수정</a></li>
						    <li role="presentation" class="divider"></li>
						    <li role="presentation"><a href="logoutAction" role="menuitem" tabindex="-1">로그아웃</a></li>
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
	                <a href="login" class="btn btn-Skyblue btn-sm">로그인</a>
	            </div>
            <%
            	}
            %>
        </div>
    </nav>
	
	<%
		Gallery gallery = galleryDAO.getGalleryView(galleryID);
		ArrayList<GalleryComment> list = new ArrayList<GalleryComment>();
		list = galleryCommentDAO.getGalleryCommentList(galleryID);
	%>
	
    <div class="pictureRegistSectionWrap">
    	<!-- galleryView Form  -->
       	<div id="galleryRegistForm" class="pictureRegistSection">
            <div>
            	<img class="galleryImage" src="<%=request.getContextPath() %>/upload/<%=gallery.getFileRealName()%>">
				<!-- 댓글 입력부분 -->
				<% 
				if(userID != null){
				%>
				<form method="post" action="galleryCommentWriteAction?galleryID=<%=galleryID %>">
					<table class="table" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;">
						<tbody>
							<tr>	
								<td colspan="2"><textarea class="form-control" placeholder="<%=userNickname %>님의 생각은 어떠신가요?" name="galleryCommentContent" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="btn btn-Skyblue pull-right" value="댓글 작성하기">
				</form>
				<%
					}else{
				%>
				<table class="table" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;">
					<tbody>
						<tr>	
							<td colspan="2"><textarea class="form-control" placeholder="로그인이 필요합니다" name="bbsContent" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<%
				}	
				if(userID != null){	// userID 세션이 있을때 css 처리
				%>
					<div style="margin-top:60px; font-size:18px;">댓글 (<%=list.size() %>)</div>
				<%
				}else{
				%>
					<div style="margin-top:20px; font-size:18px;">댓글 (<%=list.size() %>)</div>
				<%
				}
				for(int i = 0; i < list.size(); i++){
				%>
				<table class="table" style="border: 2px solid #dddddd; margin-top:10px;">
					<tbody>
						<tr>
							<%	// 로그인중인 회원일때 수정,삭제 버튼 표시
								if(userID != null && userID.equals(list.get(i).getUserID())){
							%>
							<td colspan="1" style="padding: 14px;"><%=list.get(i).getUserID()%></td>
							<td style="padding-top:10px; width:60px;"><a href="galleryCommentUpdate?galleryID=<%=galleryID%>&galleryCommentID=<%=list.get(i).getGalleryCommentID()%>"><button type="button" class="btn btn-Skyblue btn-sm">수정</button></a></td>
							<td style="padding-top:10px; width:60px;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="galleryCommentDeleteAction?galleryID=<%=list.get(i).getGalleryID() %>&galleryCommentID=<%=list.get(i).getGalleryCommentID()%>">
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
								<td colspan="3"><%=list.get(i).getGalleryCommentDate().substring(0, 11) + list.get(i).getGalleryCommentDate().substring(11, 13) + "시 " + list.get(i).getGalleryCommentDate().substring(14, 16) + "분" %></td>
							</tr>
							<%
								if(galleryCommentID == list.get(i).getGalleryCommentID()){	// 수정하기 누른 galleryCommentID 값이 등록되어있는 galleryCommentID값과 같을때
							%>
							<tr>
								<td colspan="3">
									<form method="post" action="galleryCommentUpdateAction?galleryID=<%=galleryID%>&galleryCommentID=<%=galleryCommentID%>">
										<table class="table" style="text-align: center; border: 1px solid #dddddd; margin-top: 20px;">
											<tbody>
												<tr>
													<td colspan="2"><textarea class="form-control" placeholder="<%=list.get(i).getGalleryComment()%>"
													name="galleryCommentContent" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
												</tr>
											</tbody>
										</table>
										<input type="submit" class="btn btn-Skyblue pull-right" value="댓글 수정하기">
									</form>
								</td>
							</tr>
							<%
								}else{
							%>
							<tr>
								<td colspan="3"><%=list.get(i).getGalleryComment() %></td>
							</tr>
							<%
							}
							%>
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
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryCategory() %>" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">아티스트</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getUserNickname() %>" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">제목</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryTitle() %>" readonly>
                </div>
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작성일자</label>
                    </div>
                    <input type="text" class="custom-viewContent" value="<%=gallery.getGalleryDate() %>" readonly>
                </div>
                <div class="pictureContent">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작품설명</label>
                    </div>
                    <textarea id="galleryContent" name="galleryContent" class="form-control" rows="26" readonly><%=gallery.getGalleryContent() %></textarea>
                </div>
                <%
                if(userID.equals(userDAO.getUserInfo(galleryDAO.getGalleryView(galleryID).getUserID()).getUserID())){	// 이 갤러리 게시글을 작성한 사람일때 수정/삭제 표시
                %>
                <div class="pictureRegistBtn" style="margin-top:15px; display:flex;">
                	<a href="galleryUpdate?galleryID=<%=galleryID %>" class="btn btn-Skyblue btn-block"  style="margin:0 10px 0 0;">수정</a>
                	<a onclick="return confirm('정말 삭제하시겠습니까?')" href="galleryDeleteAction?galleryID=<%=galleryID %>" class="btn btn-Skyblue btn-block"  style="margin:0 0 0 10px;">삭제</a>
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
                	<a href="galleryLikeAction?galleryID=<%=gallery.getGalleryID() %>" class="btn btn-Red btn-block">좋아요 <i class="fas fa-heart"> <%=gallery.getGalleryLikeCount() %></i></a>
                	<%
                		}else if(checkLike == 1){
                	%>
                	<a onclick="return confirm('좋아요를 취소하시겠습니까?')" href="galleryLikeAction?galleryID=<%=gallery.getGalleryID() %>" class="btn btn-noneHoverRed btn-block">좋아요 취소 <i class="fas fa-heart"> <%=gallery.getGalleryLikeCount() %></i></a>
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
       	</div>
	</div>
	
</div>

</body>
</html>