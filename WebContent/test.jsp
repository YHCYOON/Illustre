<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>illustre - 일러스트리</title>

    <!-- <link href="{{ url_for('static', filename='pictureRegist.css') }}" rel="stylesheet" id="login-css"> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
          integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>


    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <style>
        * {
    font-family: 'Nanum Gothic', sans-serif;
}

wrap {
    min-width: 1330px;
}

/* Navbar */
.navBar {
    height: 70px;
    background-color: white;
    position: sticky;
    top: 0px;
    z-index: 3;
}

.navBarContent {
    height: 70px;
    width: 1330px;
    margin: auto;
    display: flex;
}

.navBarLogo {
    height: 70px;
    width: 162px;
    padding-top: 18px;
    display: inline-block;
}

.navContent {
    width: 1000px;
    height: 70px;
    display: flex;
    font-size: 18px;
    padding-top: 12px;
    padding-left: 20px;
    text-align: center;
}

.showPicture, .ranking, .pictureRegist, .myPicture, .favorite {
    display: inline-block;
    margin: auto;
}

.showPicture > a:link, .ranking > a:link, .pictureRegist > a:link, .myPicture > a:link, .favorite > a:link {
    color: #414141;
    text-decoration: none;
}

.showPicture > a:visited, .ranking > a:visited, .pictureRegist > a:visited, .myPicture > a:visited, .favorite > a:visited {
    color: #414141;
    text-decoration: none;
}

.showPicture > a:hover, .ranking > a:hover, .pictureRegist > a:hover, .myPicture > a:hover, .favorite > a:hover {
    color: #414141;
    border: rgba(28, 175, 244, 0.8) solid;
    border-width: 0 0 12px 0;

}

.helloUser {
    width: 200px;
    padding: 18px 10px 10px 0;
    text-align: right;
    font-size: 14px;
}

.logOutBtn {
    padding-top: 23px;
}

.btn {
    color: #1CAFF4 !important;
    border-color: #1CAFF4 !important;
}

.btn:hover {
    color: #ffffff !important;
    background-color: #1CAFF4;
}

.pictureLike > .btn {
    color: #FC4949 !important;
    border-color: #FC4949 !important;
}

.pictureLike > .btn:hover {
    color: #ffffff !important;
    background-color: #FC4949;
}

/* Picture Regist Section */

.pictureRegistSectionWrap {
    height: 899px;
    background-color: #f4f4f4;
    padding-top: 10px;
}

.pictureRegistSection {
    width: 1330px;
    margin: auto;
    display: flex;
}

/* Picture Regist Left */

.pictureRegistLeft {
    height: 880px;
    width: 880px;
    display: inline-block;
}

.checkImage > img {
    height: 830px;
    width: 880px;
}

.UrlSection {
    margin-top: 10px;
    display: flex;
}

.inputURL {
    width: 750px;
}

.checkURL {
    width: 130px;
    padding-left: 8px;
}

.checkURL > .btn {
    height: 38px;
    width: 120px;
}


/* Picture Regist Right */
.pictureRegistRight {
    height: 888px;
    width: 550px;
    padding-left: 20px;
}

.pictureCategory {
    display: flex
}

.pictureCategory > .custom-select {
    width: 330px;
    margin-left: 10px;
    border: 0;
    border-radius: 5px;
}

.pictureTitle, .pictureComment, .pictureRegistBtn {
    margin-top: 10px;
}

.pictureTitle > .input-group-prepend > .form-control {
    width: 330px;
    border: 0;
    border-radius: 5px;
}

.input-group-text {
    background-color: #D0D0D0;
    border: 0;
    width: 96.14px;
}

.pictureTitle > .input-group-prepend > .form-control {
    margin-left: 10px;
}

.pictureComment > .input-group-text {
    width: 428px;
}

.pictureComment > textarea {
    margin-top: 8px;
    border: 0;
    border-radius: 5px;
    resize: none;
}

.pictureRegistBtn > .btn {
    background-color: #1CAFF4;
    color: white !important;
    border-color: #1CAFF4 !important;
}

.pictureRegistBtn > .btn:hover {
    color: #ffffff !important;
    background-color: #0A8BD9;
}
    </style>

    <script>

        // 입력한 URL 에 따른 이미지가 출력되었나 확인합니다
        let imageError = true;

        $(window).on('load', function () {
            $("#urlImg").on('error', function () {
                imageError = true;
            })
        })

        // 입력한 URL 을 이미지로 띄워주는 함수
        function Show_Img(){
            let image = $("#inputURL").val();
            imageError = false;
            $("#urlImg").attr("src", image);
        }

        // 등록일자 구하는 함수
        function getTodayDate(){
            let today = new Date();

            let year = today.getFullYear();
            let month = today.getMonth();
            let date = today.getDate();
            let hour = today.getHours();
            let minute = today.getMinutes();
            let second = today.getSeconds();

            return year + "." + ("0"+(month+1)).slice(-2) + "." + ("0"+(date)).slice(-2) + " " + ("0"+(hour)).slice(-2) + ":" + ("0"+(minute)).slice(-2) + ":" + ("0"+(second)).slice(-2)
        }

        // 그림정보 등록하는 함수
        function Picture_Regist(){

            //입력한 값들을 가져옵니다
            let imgURL = $("#inputURL").val();
            let category = $("#category").val();
            let title = $("#title").val();
            let comment = $("#comment").val();
            let date = getTodayDate();
            let nickname = "{{ nickname }}"
            let userkey = "{{ userkey }}";


            // 값들을 하나라도 입력하지 않았을 때 alert를 띄웁니다
            if (imgURL == ""){
                alert("URL을 입력해주세요");
                $("#imgURL").focus();
                return
            }else if(category == "카테고리를 선택하세요"){
                alert("카테고리를 선택해주세요");
                $("#category").focus();
                return
            }else if(title == ""){
                alert("제목을 입력해주세요");
                $("#title").focus();
                return
            }else if(comment == ""){
                alert("작품설명을 입력해주세요")
                $("#comment").focus();
                return
            }else if(imageError){
                alert("올바른 이미지 URL을 입력해주세요");
                $("#imgURL").focus();
                return
            }

            // POST /pictureRegist 에 저장을 요청합니다
            $.ajax({
                type: "POST",
                url: "/pictureregist",
                data: {
                    imgURL_give : imgURL,
                    category_give : category,
                    title_give : title,
                    comment_give : comment,
                    date_give : date,
                    nickname_give : nickname,
                    userkey_give : userkey,
                    picturenumber_give : {{ picturenumber }},
                },
                success: function(response){
                    if(response["result"] == "success"){
                        alert(response["msg"]);

                        window.location.reload();
                    }
                }
            })
        }

        // 로그아웃해서 세션 버리는 함수
        function onClickLogOut() {
            $.ajax({
                url: '/logout',
                method: 'POST',
                data: {},
                success: function (response) {
                    $(location).attr('href', '/');
                }
            })
        }

        // Nav Bar 로고 , 작품보기
        function onClickMain() {
            $(location).attr('href', '/');
        }

        // Nav Bar 랭킹
        function onClickRanking() {
            $(location).attr('href', '/rank/전체랭킹');
        }

        // Nav Bar 그림등록
        function onClickPictureRegist() {
            $(location).attr('href', '/pictureregist');
        }

        // Nav Bar 나의그림
        function onClickMypicture() {
            $(location).attr('href', '/mypicture');
        }

        // Nav Bar 갤러리
        function onClickGallery() {
            $(location).attr('href', '#');
        }
    </script>
</head>
<body>
<div class="wrap">
    <nav class="navBar">
        <div class="navBarContent">
            <a href="#" onclick="onClickMain()" class="navBarLogo">
                <img src="../static/illustre_logo.png" alt="illustre">
            </a>
            <div class="navContent">
                <div class="showPicture">
                    <a href="#" onclick="onClickMain()">&nbsp&nbsp&nbsp&nbsp 작품보기 &nbsp&nbsp&nbsp&nbsp</a>
                </div>
                <div class="ranking">
                    <a href="#" onclick="onClickRanking()">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 랭킹 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                </div>
                <div class="pictureRegist">
                    <a href="#" onclick="onClickPictureRegist()">&nbsp&nbsp&nbsp&nbsp 그림등록 &nbsp&nbsp&nbsp&nbsp</a>
                </div>
                <div class="myPicture">
                    <a href="#" onclick="onClickMypicture()">&nbsp&nbsp&nbsp&nbsp 나의그림 &nbsp&nbsp&nbsp&nbsp</a>
                </div>
                <div class="favorite">
                    <a href="#" onclick="onClickGallery()">&nbsp&nbsp&nbsp&nbsp 갤러리 &nbsp&nbsp&nbsp&nbsp</a>
                </div>
            </div>
            <div class="helloUser">
                <div class="hello">안녕하세요</div>
                <div class="user">{{ nickname }}님!</div>
            </div>
            <div class="logOutBtn">
                <button type="button" onclick="onClickLogOut()" class="btn btn-outline-primary btn-sm">로그아웃</button>
            </div>
        </div>
    </nav>

    <div class="pictureRegistSectionWrap">
        <div class="pictureRegistSection">
            <div class="pictureRegistLeft">
                <div class="checkImage">
                    <img id="urlImg">
                </div>
                <div class="UrlSection">
                    <div class="inputURL">
                        <input type="text" id="inputURL" class="form-control" placeholder="URL을 입력하세요">
                    </div>
                    <div class="checkURL">
                        <button type="button" onclick="Show_Img()" class="btn btn-outline-primary btn-sm">이미지 확인</button>
                    </div>
                </div>
            </div>

            <div class="pictureRegistRight">
                <div class="pictureCategory">
                    <div class="input-group-prepend">
                        <label class="input-group-text">카테고리</label>
                    </div>
                    <select id="category" class="custom-select">
                        <option selected>카테고리를 선택하세요</option>
                        <option value="캐릭터 일러스트">캐릭터 일러스트</option>
                        <option value="배경 일러스트">배경 일러스트</option>
                        <option value="스케치">스케치</option>
                    </select>
                </div>
                <div class="pictureTitle">
                    <div class="input-group-prepend">
                        <label class="input-group-text">제목</label>
                        <input type="text" id="title" class="form-control">
                    </div>
                </div>
                <div class="pictureComment">
                    <div class="input-group-prepend">
                        <label class="input-group-text">작품설명</label>
                    </div>
                    <textarea id="comment" class="form-control" rows="28"></textarea>
                </div>
                <div class="pictureRegistBtn">
                    <button onclick="Picture_Regist()" type="button" class="btn btn-primary btn-lg btn-block">저장</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>