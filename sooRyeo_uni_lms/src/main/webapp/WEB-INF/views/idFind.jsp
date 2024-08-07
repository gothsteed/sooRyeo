<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
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

.item {
  /* border: 1px solid red; */
  margin-bottom: 10px;
  position: relative;
}
.item input[type=text],
.item input[type=email]{
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
.item .material-icons {
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
.item input:focus {
  border: 1px solid #175F30 ;
  box-shadow: 0 0 5px #175F30;
}
.item input:focus + .material-icons {
  color: #175F30 ;
}
.item input:focus::placeholder {
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

$(document).ready(function(){
	
   const method = "${requestScope.method}";
   
   if(method == "GET") {
	   
	   $("span.errorname-idFind").hide();
	   $("span.erroremail-idFind").hide();
	   $("button#goMain").hide();
	   $("input#name-idFind").focus();
	   
	    const name = $("input#name-idFind").val().trim();
	    const email = $("input#email-idFind").val();
	    
	   $("input#name-idFind").on('blur' , function() {
	      $("span.errorname-idFind").hide();
	   });

	   
	   $("input#email-idFind").on('blur' , function() {
	      $("span.erroremail-idFind").hide();
	   });


	   // 찾기 버튼 클릭 시 goFind(); 함수 호출
	   $("button#btn-success-idFind").click(function(){
	      goFind();
	   });

	   // 이메일 입력칸에서 goFind(); 함수 호출
	   $("input#email-idFind").bind("keyup", function(e){
	       if(e.keyCode == 13) {
	            goFind();
	       }
	    });
	   
    }
   
  
    if(method == "POST") {
    	
    	const userid = "${requestScope.userid}";
    	
    	const msg = $("div#result-msg");
    	
    	if(userid == "" || userid == null) {
    		
    	    $("input#name-idFind").hide();
    	    $("input#email-idFind").hide();
    		$("span.errorname-idFind").hide();
    		$("span.erroremail-idFind").hide();
    		$("button#btn-success-idFind").hide();
    		$("input.form-check-input").hide();
    		$("label.form-check-label").hide();
    		$("i.fa-regular").hide();
    		$("i.fa-solid").hide();
    	
    		
    		msg.text("없는 아이디입니다.");
    		$("button#goMain").show();
    		
            $("button#goMain").click(function(){
                location.href = "<%=ctxPath%>";
                
             });
    		
    	}else {
    		
    	    $("input#name-idFind").hide();
    	    $("input#email-idFind").hide();
    		$("span.errorname-idFind").hide();
    		$("span.erroremail-idFind").hide();
    		$("button#btn-success-idFind").hide();
    		$("input.form-check-input").hide();
    		$("label.form-check-label").hide();
    		$("i.fa-regular").hide();
    		$("i.fa-solid").hide();
    		
    		
    		msg.text("회원님의 아이디 : ${requestScope.userid}" );
    		$("button#goMain").show();
    		
            // 메인으로 버튼 클릭 시 메인페이지로 
            $("button#goMain").click(function(){
              location.href = "<%=ctxPath%>";
              
            });

    	}
    }
  

});





function goFind() {
   
    const name = $("input#name-idFind").val().trim();
    const email = $("input#email-idFind").val();
    
    if(name == "") {
        $("span.errorname-idFind").show();
        $("input#name-idFind").focus();
        return;
    }

    
    const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i)
    const bool = regExp_email.test(email);

    if(!bool) {
        $("span.erroremail-idFind").show();
        $("input#email-idFind").val("").focus();
        return;
    }
    
    
    const frm = document.idFindFrm;
    frm.method = "post";
    frm.action = "<%=ctxPath%>/member/idfind.lms";
    frm.submit();
    
}; // end of function goFind()------------------

</script>



<body>

  <div class="jb-box">
  
    <video muted autoplay loop>
       <source src="<%= ctxPath%>/resources/video/campus.mp4" type="video/mp4">
    </video>
    <div class="img"><img src="<%= ctxPath%>/resources/images/mainlogo-white.png" style="width:100%; height:300px;"/></div>
    <div class="jb-text">
       <div class="login-box">
       
         <h2>아이디 찾기</h2>
     
         <form name="idFindFrm">
             <div class="w-100" style="margin-left: 21%; margin-top: 10%;">
             
             
		        <div style="display:flex; color: #000000; font-size: 12pt; padding-bottom: 3%; font-weight: bold;">
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
                 <input type="text" id="name-idFind" name="name" placeholder="NAME">
                 <span class="material-icons">
                   <i class="fa-solid fa-pencil"></i>
                 </span>
                 <span class="errorname-idFind" style="color: red; font-weight: bold;">성명을 입력해주세요!</span> 
               </div>
               
               <div class="item" style="width: 300px;">
                 <input type="text" id="email-idFind" name="email" placeholder="EMAIL">
                 <span class="material-icons">
                   <i class="fa-regular fa-envelope"></i>
                 </span>
                 <span class="erroremail-idFind" style="color: red; font-weight: bold;">이메일을 올바르게 입력하세요!</span>
               </div>
     
             </div> 
     
             <div class="my-3 text-center">
               <button type="button" id="btn-success-idFind" class="btn btn-success" style="width: 300px;">찾기</button>
             </div>
             
             <div class="idfind my-3 text-center">
                <div id="result-msg" style="text-align: center; font-weight: bold; margin-bottom: 5%;"></div>
                <button type="button" id="goMain" class="btn btn-success" style="width: 150px;">메인으로</button>
             </div>
             
             
         </form>
     
      </div>
      
   </div>
   

  </div>
  


</body>


</html>