<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>

<!doctype html>
<head>
<meta charset="utf-8">
<title>SooRyeo Univ.</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gothic+A1&family=IBM+Plex+Sans+KR&family=Nanum+Gothic&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR:wght@200..900&display=swap" rel="stylesheet">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>




<style type="text/css">


html {
  height: 100%;
}

.login-box {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 600px;
  height: 400px;
  padding: 40px;
  transform: translate(-50%, -50%);
  background: white;
  box-sizing: border-box;
  box-shadow: 0 15px 25px rgba(0,0,0,.4);
  border-radius: 10px;
}

.form-control:focus {

  outline:"1px solid #175F30;"

}

.login-box h2 {
  margin-left: 33%;
  padding: 0;
  color: black;
  font-weight: bold;
}

body {
  font-family: 'Noto Sans KR', sans-serif;
  color: #222;
  line-height: 1.5em;
  padding: 0; margin: 0;
  font-weight: 300;
  /* 수직 수평 중앙 */
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}


a {
  color: #222;
  text-decoration: none;
}

.item,
.item10 {
  /* border: 1px solid red; */
  margin-bottom: 10px;
  position: relative;
}


.item input[type=text],
.item input[type=email],
.item10 input[type=text] {
  border: 1px solid lightgray;
  height: 40px;
  width: inherit;
  border-radius: 5px;
  padding: 10px;
  box-sizing: border-box;
  padding-left: 40px;
  outline: none;
  transition: 0.3s;
}
.item .material-icons,
.item10 .material-icons10 {
  /* border: 1px solid blue; */
  position: absolute;
  top: 0;
  left: 0;
  color: gray;
  font-size: 20px;
  width: 40px;
  height: 40px;
  line-height: 40px;
  text-align: center;
  transition: 0.3s;
}
.item input:focus,
.item10 input:focus {
  border: 1px solid #175F30 ;
  box-shadow: 0 0 5px #175F30;
}
.item input:focus + .material-icons,
.item10 input:focus + .material-icons10 {
  color: #175F30 ;
}
.item input:focus::placeholder,
.item10  input:focus::placeholder {
  visibility: hidden;
}
<%--===================================== --%>

video { 
      positon: fixed;
      top: 0;
      left: 0;
      min-width: 100%;
      min-height: 100%;
      width: auto;
      height: auto;
      z-index: 997;
      filter: brightness(70%);
}


.jb-box { width: 100%; overflow: hidden; margin: 0px auto; position: relative; }
.jb-text { position: absolute; top: 60%; width: 100%; }
.img  { margin-top: -24px; text-align: center; font-size: 60px; color: #ffffff; position: absolute; top: 10%; left: 42%;}

</style>

<script type="text/javascript">

$(document).ready(function() {
	
	   const method = "${requestScope.method}";
	   
	   if(method == "GET") {
		   
		   $("span.errorid-pwdFind").hide();
		   $("span.erroremail-pwdFind").hide();
		   $("input#id-pwdFind").focus();
		   
		   const id = $("input#id-pwdFind").val().trim();
		   const email = $("input#email-pwdFind").val();
		    
		   $("input#id-pwdFind").on('blur' , function() {
		      $("span.errorid-pwdFind").hide();
		   });
		
		   
		   $("input#email-pwdFind").on('blur' , function() {
		      $("span.erroremail-idFind").hide();
		   });
		
		
		   // 찾기 버튼 클릭 시 goFind(); 함수 호출
		   $("button#btn-success-pwdFind").click(function(){
		      goFind();
		   });
		
		   // 이메일 입력칸에서 goFind(); 함수 호출
		   $("input#email-pwdFind").bind("keyup", function(e){
		       if(e.keyCode == 13) {
		            goFind();
		       }
		    });
		   
	   }
	   
	   if(method == "POST") {
		   
		   $("input:text[name='id']").val("${requestScope.id}");
	   }
	   
	   
	   // 회원이 존재하지 않을 떼
	   if( ${requestScope.isUserExist == false} ) {
		   
		   $("div.item").hide();
		   $("div.item2").hide();
		   $("div.item3").hide();		   
	   }
	   
	   if(${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}) {
		   
		   $("div.item").hide();
		   $("div.item2").hide();
		   $("div.item3").hide();	
	   }
	   
	   // === 인증하기 버튼 클릭 시 이벤트 처리해주기 시작 === //
	   $("button.btn-success").click(function() {
	   	
	   	const input_confirmCode = $("input:text[name='input_confirmCode']").val().trim();
	   	
	   	if(input_confirmCode == "") {
	   		alert("인증코드를 입력하세요!");
	   		return; // 함수 종료
	   	}
	   	
	   	const frm = document.verifyCertificationFrm;
	   	frm.userCertificationCode.value = input_confirmCode; // 입력받은 인증코드 넣기
	   	frm.userid.value = $("input:text[name='id']").val();
		frm.memberType.value = $("input:radio[name='memberType']").val();
	   	
	   	frm.action = "<%=ctxPath%>/member/verifyCertification.lms";
	   	frm.method = "post";
	   	frm.submit();
	   	
	   }); <%-- $("button.btn-info").click(function() {}) --%>
	   // === 인증하기 버튼 클릭 시 이벤트 처리해주기 끝 === //

	   
	   
	   
	   
});



function goFind() {
   
    const id = $("input#id-pwdFind").val().trim();
    const email = $("input#email-pwdFind").val();

    const regExp_id = new RegExp(/^\d{9}$/);
    const id_bool = regExp_id.test(id);
    
    if(id == "" || !id_bool) {
        $("span.errorid-pwdFind").show();
        $("input#id-pwdFind").val("").focus();
        return;
    }

    
    const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i)
    const email_bool = regExp_email.test(email);

    if(!email_bool) {
        $("span.erroremail-pwdFind").show();
        $("input#email-pwdFind").val("").focus();
        return;
    }
    
    
    const frm = document.pwdFindFrm;
    frm.method = "post";
    frm.action = "<%=ctxPath%>/member/pwdfind.lms";
    frm.submit();
    
};  <%-- end of function goFind()------------------ --%>




</script>


<body>

  <div class="jb-box">
  
    <video muted autoplay loop>
       <source src="<%= ctxPath%>/resources/video/campus.mp4" type="video/mp4">
    </video>
    <div class="img"><img src="<%= ctxPath%>/resources/images/mainlogo-white.png" style="width:100%; height:300px;"/></div>
    <div class="jb-text">
	    <div class="login-box">
	    
	      <h2>비밀번호 찾기</h2>
	      
	        <form name="pwdFindFrm">
	        
             <div class="w-100" style="margin-left: 21%; margin-top: 10%;">
             
             
		       <div class="item3" style="display:flex; color: #000000; font-size: 12pt; padding-bottom: 3%; font-weight: bold;">
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
     
               <div class="item" style="width: 300px;">
                 <input type="text" id="id-pwdFind" name="id" placeholder="ID">
                 <span class="material-icons">
                   <i class="fa-regular fa-user"></i>
                 </span>
                 <span class="errorid-pwdFind" style="color: red; font-weight: bold;">아이디를 입력해주세요!</span> 
               </div>

               
               <div class="item" style="width: 300px;">
                 <input type="text" id="email-pwdFind" name="email" placeholder="EMAIL">
                 <span class="material-icons">
                   <i class="fa-regular fa-envelope"></i>
                 </span>
                 <span class="erroremail-pwdFind" style="color: red; font-weight: bold;">이메일을 올바르게 입력하세요!</span>
               </div>
     
             </div> 
     
             <div class="item2 my-3 text-center">
               <button type="button" id="btn-success-pwdFind" class="btn btn-success" style="width: 300px;">찾기</button>
             </div>
             
         </form>
         
        <div class="my-3 text-center" id="div_findResult">

		<c:if test="${requestScope.isUserExist == false}">
			 <div class="my-3 text-center">
			 	<br>
                <div style="text-align: center; font-weight: bold; margin-bottom: 5%; color: red; ">사용자 정보가 없습니다.</div>
                <button type="button" id="goMain" class="btn btn-success" style="width: 150px;">메인으로</button>
             </div>
		</c:if>
		
		
		<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
		
				<div style="text-align: center; font-weight: bold; margin-bottom: 5%;">
					인증코드가 ${requestScope.email}로 발송되었습니다.<br>인증코드를 입력해주세요.
				</div>
				<div class="item10">
					<input type="text" id="input_confirmCode" name="input_confirmCode" />
		            <span class="material-icons10" style="margin-left: 24.5%;">
		              <i class="fa-solid fa-key"></i>
		            </span>
		        </div>
				<br>
				<button type="button" class="btn btn-success">인증하기</button>
			
		</c:if>
		
		
		<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
			<span style="color: red;">메일 발송에 실패했습니다.</span>
		</c:if>
		
		</div>
	  
	   </div>
	   
   </div>
   

  </div>
  
<%-- 인증하기 form --%>
<form name="verifyCertificationFrm">
	<input type="hidden" name="userCertificationCode" />
	<input type="hidden" name="userid" />
	<input type="hidden" name="memberType" />
</form>
  


</body>