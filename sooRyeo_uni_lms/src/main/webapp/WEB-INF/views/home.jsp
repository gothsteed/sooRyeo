<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>SooRyeo Univ.</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gothic+A1&family=IBM+Plex+Sans+KR&family=Nanum+Gothic&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR:wght@200..900&display=swap" rel="stylesheet">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath %>/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath %>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<style type="text/css">
video { 
		positon: fixed;
		top: 0;
		left: 0;
		min-width: 100%;
		min-height: 100%;
		width: auto;
		height: auto;
		z-index: -1;
		filter: brightness(70%);
      }
      
.jb-box { width: 100%; overflow: hidden; margin: 0px auto; position: relative; }
.jb-text { position: absolute; top: 10%; width: 100%; }
.jb-text p { margin-top: -24px; text-align: center; font-size: 60px; color: #ffffff; }

* {
  box-sizing: border-box;
}

body {
	padding: 0; margin: 0;
  	display: flex;
  	justify-content: center;
  	align-items: center;
}

.wave {
  word-spacing: 5px;
  overflow: hidden;
  margin-top: -24px; text-align: center; font-size: 65px; color: #ffffff;
}

.letter {
  display: inline-block;
  transform: translateY(100%);
  animation: reveal 3s cubic-bezier(0.77, 0, 0.175, 1) forwards;
  font-family: "Gothic A1", sans-serif;
  font-weight: 900;
  font-style: normal;
}

@keyframes reveal {
  0% {
    transform: translateY(100%);
  }
  100% {
    transform: translateY(0);
  }
}


   /* -- CSS 로딩화면 구현 시작(bootstrap 에서 가져옴) 시작 -- */    
   div.spinner {
   
     border: 12px solid #f3f3f3;
     border-radius: 50%;
     border : 12px dotted green;
      
     width: 150px;
     height: 150px;
     -webkit-animation: spin 2s linear infinite; /* Safari */
     animation: spin 2s linear infinite;
   }
   
   @-webkit-keyframes spin {
     0% { -webkit-transform: rotate(0deg); }
     100% { -webkit-transform: rotate(360deg); }
   }
   
   @keyframes spin {
     0% { transform: rotate(0deg); }
     100% { transform: rotate(360deg); }
   }
   
   
   .overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(255, 255, 255, 0.5); /* 흰색 배경 (투명도 포함) */
    display: flex; /* 스피너를 중앙에 배치하기 위해 flex 사용 */
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    z-index: 9999; /* 다른 요소 위에 표시 */
	}
   /* -- CSS 로딩화면 구현 시작(bootstrap 에서 가져옴) 끝 -- */
   
</style>	

<script type="text/javascript">

$(document).ready(function(){
	
	$("div.overlay").hide();
	
	$("input#password").keyup(function(key){
	    if(key.keyCode == 13) {
	    	handleLogin(); 
	    }
	 });
	
	$("input#id").keyup(function(key){
	    if(key.keyCode == 13) {
	    	handleLogin(); 
	    }
	 });
	

	
	// === 로그인을 하지 않은 상태일 때 
	//     로컬스토리지(localStorage)에 저장된 key가 'saveid' 인 userid 값을 불러와서 
	//     input 태그 userid 에 넣어주기 ===
	
	if(${empty sessionScope.loginuser}) {
		
		const loginUserid = localStorage.getItem('idsave');
		// 외부 js에서 로컬 스토리지에 값을 넣었을 때 => requestScope, sessionScope 사용 불가
		
		//console.log("확인용 loginUserid : " + loginUserid);
		
		if(loginUserid != null) {
			$("input#id").val(loginUserid);
			$("input:checkbox[id='idsave']").prop("checked", true);
		}
	
	}
	
	
}); // end of $(document).ready



function handleLogin() {
	
	$("div.overlay").show();
    
	const memberType = document.querySelector('input[name="memberType"]:checked').value;
    const form = $('#loginForm');
    
   
    let actionUrl = "";
    if (memberType == "student") {
        actionUrl = "<%= ctxPath %>/student/login.lms";
    } else if (memberType == "professor") {
        actionUrl = "<%= ctxPath %>/professor/login.lms";
    } else if (memberType == "admin") {
        actionUrl = "<%= ctxPath %>/admin/login.lms";
    }
    
    
    // 아이디 저장 체크 시
    if($("input:checkbox[id='idsave']").prop("checked")) {
       
        localStorage.setItem('idsave', $("input#id").val());
        localStorage.setItem('memberType', $("input:radio[name='memberType']:checked").val());
        
    } else {
        localStorage.removeItem('idsave');
        localStorage.removeItem('memberType');
    }
    
    
    
    
    
    $.ajax({
        url: actionUrl,
        type: 'POST',
        data: form.serialize(),
        dataType:"json",
        success: function(response) {
            // Handle success scenario
        if (response.isSuccess) {
        	$("div.overlay").hide(); // 스피너 숨기기

            // 스피너가 숨겨진 후 잠시 대기한 후 알림 표시
            setTimeout(function() {
                alert("성공");
                console.log(response.redirectUrl);
                window.location.href = response.redirectUrl; 
            }, 100); // 100ms 후에 알림 표시
        } else {
        	$("div.overlay").hide(); // 스피너 숨기기

            // 스피너가 숨겨진 후 잠시 대기한 후 알림 표시
            setTimeout(function() {
                alert("실패");
            }, 100); // 100ms 후에 알림 표시
        }
        },
        error: function(xhr, status, error) {
            // Handle error scenario
            $("div.overlay").hide();
            alert('Login failed: ' + error);
        }
    });
}

$("input#spinner").spinner( {
    spin: function(event, ui) {
       if(ui.value > 100) {
          $(this).spinner("value", 100);
          return false;
       }
       else if(ui.value < 1) {
          $(this).spinner("value", 1);
          return false;
       }
    }
} );// end of $("input#spinner").spinner({});----------------
 
 
 


</script>
</head>

<body>
  <div class="jb-box">
    <video muted autoplay loop>
    	<source src="<%=ctxPath%>/resources/video/campus.mp4" type="video/mp4">
    </video>
   
    <div class="jb-text">
      	<p><img class="img-fluid" src="<%=ctxPath%>/resources/images/mainlogo-white.png" style="width:17%; height:300px;"/></p>
	
		
		<h2 class="title wave">
 		 	<span class="letter">수려대학교에 오신 것을 환영합니다.</span>
		</h2>
		
		<section class="container pt-10 pb-20">
        	<div class="row justify-content-center">
	            <div class="col-lg-6 col-xl-5 col-md-8 col-sm-9">
	                <div class="brd-around g-brd-gray-light-v6 g-bg-white rounded-0 g-px-30 g-py-50 mb-1">
	                    <header class="text-center mb-4" style="margin-top: 20%;">
	                        <h1><span style="color:white;">LOGIN</span></h1>
	                    </header>
						
						<form id="loginForm">
							<div style="display:flex; color:white; font-size: 12pt; padding-top: 3%; padding-bottom: 3%;">
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="memberType" id="inlineRadio1" value="student" checked>
								  <label class="form-check-label" for="inlineRadio1">학생</label>
								</div>
								<div class="form-check form-check-inline pl-3">
								  <input class="form-check-input" type="radio" name="memberType" id="inlineRadio2" value="professor">
								  <label class="form-check-label" for="inlineRadio2">교수</label>
								</div>
								<div class="form-check form-check-inline pl-3">
								  <input class="form-check-input" type="radio" name="memberType" id="inlineRadio3" value="admin">
								  <label class="form-check-label" for="inlineRadio3">관리자</label>
								</div>
							</div>
							
	                        <div class="mb-4">
	                            <div class="input-group">
	                                <input type="text" name="id" id="id" class="form-control g-color-gray-dark-v3 g-brd-gray-light-v7 g-py-15 g-px-15 rounded-0" placeholder="수려대학교 ID" autofocus="autofocus">
	                            </div>
	                        </div>
	                        <div class="mb-4">
	                            <div class="input-group g-brd-primary--focus mb-4">
	                                <input type="password" name="password" id="password" class="form-control g-color-gray-dark-v3 g-brd-gray-light-v7 g-py-15 g-px-15 rounded-0" placeholder="비밀번호">
	                            </div>
	                        </div>
						
						
                        <div class="row justify-content-between mb-4">
                            <div class="col-4">
                                <div class="form-check">
								    <input class="form-check-inline" type="checkbox" id="idsave" name="idsave" value="saveOk">
								    <label id="RemeberMeLabel" for="idsave" class="form-check-label" style="color:white;">ID 기억</label>
                                </div>
                            </div>
                            <div class="col-7 align-self-center text-right g-px-0 g-pr-15 ">
                                <a class="text-white" href="<%= ctxPath%>/member/idfind.lms">아이디(학번) 찾기 /</a>
                                <a class="text-white" href="<%= ctxPath%>/member/pwdfind.lms">비밀번호 찾기</a>
                            </div>
                        </div>
                       	<div class="d-grid gap-2 col-4 mx-auto">
						  <button id="login" class="btn btn-success btn-lg" style="font-size:16pt; font-weight: bold; margin-bottom: 15%;" type="button" onclick="handleLogin()">로그인</button>
						</div>
						</form>
                    </div>
                </div>
              </div>
          </section>

		<footer class="g-brd-top-only g-color-white g-pb-40 g-pt-20 g-bg-white" style="border-color: #ffffff !important; margin-top: 3%;">
        	<!-- 주소 -->
            <div class="container">
                <div class="row g-mt-20 g-hidden-md-down">
                    <div class="col-3 text-center">
                        <img class="img-fluid" src="<%=ctxPath%>/resources/images/mainlogo-white.png" style="height: 70px; width: 70px;">
                    </div>
                    <div style="text-align: center;">
                        <address class="text-white"><strong>수려캠퍼스 | </strong>서울특별시 마포구 서교동 447-5 풍성빌딩 2,3,4층</address>
                    </div>
                    <div class="col-xl-3 col-9 offset-lg-max-3">
                        <address class="text-white"><strong class="g-color-gray-dark-v3 g-pr-3">IT 상담 / 문의</strong> : 02-336-8546</address>
                    </div>
                    <div class="col-12" style="margin-top: 0%;">
                        <p style="font-size:9pt; color:white;">Copyright© 2024 SOORYEO NATIONAL UNIVERSITY. All rights reserved.</p>
                    </div>
                </div>
       		 <!-- 주소 end -->
            </div>
        </footer>
    </div>
  </div>
  
  
   <%-- CSS 로딩화면 구현한 것--%>

   <div class="overlay">
      <div id="spinner" class="spinner" style="margin: auto"></div>
   </div>
   
</body>
</html>
