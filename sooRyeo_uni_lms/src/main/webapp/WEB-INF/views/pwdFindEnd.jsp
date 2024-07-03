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

.item {
  /* border: 1px solid red; */
  margin-bottom: 10px;
  position: relative;
}
.item input[type=password] {
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
.item input:focus,
input:focus {
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
	
	  $("input#pwd").focus();
	
	   	   const method = "${requestScope.method}";
	   

	   
		$("button#btn-success-pwdFindEnd").click(function() {
			
			const pwd = $("input:password[name='pwd']").val();
			const pwd2 =  $("input:password[name='pwd2']").val(); // input:password[id='pwd2']
			
			if(pwd != pwd2) {
				alert("비밀번호가 일치하지 않습니다.");
				$("input:password[name='pwd']").val("");
				$("input:password[name='pwd2']").val("");
				$("input:password[name='pwd']").focus();
				return; // 함수 종료
				
			} else {
				const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
	            // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성 
	             
	        	const bool = regExp_pwd.test(pwd);   
	            
	            if(!bool) {
	            	// 암호가 정규표현식에 위배된 경우
	                alert("비밀번호는 8글자 이상 15글자 이하 영문자, 숫자, 특수기호가 혼합되어야 합니다.");
	                $("input:password[name='pwd']").val("");
	                $("input:password[name='pwd2']").val("");
	                $("input:password[name='pwd']").focus();
	                return; // 함수 종료
	                
	            } else {
	        		// 암호가 정규표현식에 맞는 경우
	        		const frm = document.pwdFindEndFrm;
	        		frm.action = "<%=ctxPath%>/member/pwdFindEnd.lms";
	        		frm.method = "post";
	        		frm.submit();
	        	}
			}
			
		});
 
});

</script>


<body>

  <div class="jb-box">
  
    <video muted autoplay loop>
       <source src="<%= ctxPath%>/resources/video/campus.mp4" type="video/mp4">
    </video>
    <div class="img"><img src="<%= ctxPath%>/resources/images/mainlogo-white.png" style="width:100%; height:300px;"/></div>
    <div class="jb-text">
	    <div class="login-box">
	    
	      <h2>비밀번호 변경</h2>
	      
	        <form name="pwdFindEndFrm">
	        
             <div class="w-100" style="margin-left: 21%; margin-top: 10%;">
             
               <div class="item" style="width: 300px;">
                 <input type="password" id="pwd" name="pwd" placeholder="password">
                 <span class="material-icons">
                   <i class="fa-solid fa-lock"></i>
                 </span>
                 <span class="pwdUpdate" style="color: red; font-weight: bold;"></span> 
               </div>

               
               <div class="item" style="width: 300px;">
                 <input type="password" name="pwd2" placeholder="passwordCheck">
                 <span class="material-icons">
                  	<i class="fa-solid fa-lock"></i>
                 </span>
                 <span class="pwdUpdate2" style="color: red; font-weight: bold;"></span>
               </div>
               
               <input type="hidden" name="userid" value="${requestScope.userid}">
               <input type="hidden" name="memberType" value="${requestScope.memberType}">
     
             </div> 
     
             <div class="item2 my-3 text-center">
               <button type="button" id="btn-success-pwdFindEnd" class="btn btn-success" style="width: 300px;">변경하기</button>
             </div>
             
         </form>
         
	   </div>
	   
   </div>
   

  </div>
  

  


</body>