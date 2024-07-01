<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>     

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<style type="text/css">

div#info {
   border: solid 1px red;
   width: 50%;
   margin-left: 45%;
}
span.error {
   color: red;
   font-weight: bold;
   font-size: 9pt;
}

</style>


<div class="container">
  <div class="card mb-3 shadow p-3 mb-5 bg-body-tertiary rounded" style="max-width: 1000px;">
     <div class="myInfo row g-0 ">
         <div class="card-body">
           
         <form class="profile-form">
            <div class="d-flex">
               <img src="<%=ctxPath%>/resources/images/koala.png" class="img-fluid rounded-start" style="width:15%; margin-left:5%;" />
               <div style="width:25%;" class="prodInputName" style="padding-bottom: 10px; margin-left:5%;">이미지파일 미리보기</div>
               <div><img id="previewImg" width="150" /></div>
               <input class="form-control" type="file" id="formFile" style="width:30%; margin-top: 10%;">
            </div>
               
            <div class="card-body">
               <div class="row" style="width:100%; padding-bottom: 5%;">
                  <div class="col-sm-6 m-b30 mb-3">
                     <label class="form-label">성명</label> 
                     <input type="text" id="profName" disabled name="name" class="form-control" value="${requestScope.professor.name}">
                  </div>
                  <div class="col-sm-6 m-b30"> 
                     <label class="form-label">비밀번호</label>
                     <span class="error">숫자/문자/특수문자 포함 형태의 8~15자리로 입력해주세요.</span> 
                     <input type="password" id="profPwd" name="pwd" class="form-control" />
                   	         <%-- 비밀번호중복체크 --%>
                             <span id="pwdcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3">비밀번호 중복확인</button></span>
                             <span id="pwdCheckResult"></span>
                  </div>
                  <div class="col-sm-6 m-b30 mb-3">
                     <label class="form-label">학과</label> 
                     <input type="text" id="profDepart" disabled name="department_name" class="form-control" value="${requestScope.professor.department.department_name}">
                  </div>
                  <div class="col-sm-6 m-b30">
                     <label class="form-label">연락처</label>
                     <span class="error">올바른 연락처 형식이 아닙니다.</span>
                     <input type="text" id="profTel" name="tel" class="form-control" value="${requestScope.professor.tel}">
                             <%-- 이메일중복체크 --%>
                             <span id="telcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3">연락처 중복확인</button></span>
                             <span id="telCheckResult"></span>
                  </div>
                  <div class="col-sm-6 m-b30">
                     <label class="form-label">이메일</label> 
                     <span class="error">이메일 형식에 맞지 않습니다.</span>
                     <input type="text" id="profEmail" name="email" class="form-control" value="${requestScope.professor.email}">
                             <%-- 이메일중복체크 --%>
                             <span id="emailcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3">이메일 중복확인</button></span>
                             <span id="emailCheckResult"></span>
                  </div>
                  <div class="col-sm-6 m-b30">
                     <label class="form-label">연구실 주소</label> 
                     <span class="error">주소를 입력하세요.</span>
                     <input type="text" id="postcode" name="postcode" class="form-control w-25 mb-1" readonly value="">
                     <input type="text" id="address" name="address" class="form-control mb-1" readonly value="${requestScope.professor.office_address}">
                     <input type="text" id="detailaddress" name="detailaddress" class="form-control mb-1" value="${requestScope.professor.office_address}">
                     <input type="text" id="extraaddress" name="extraaddress" class="form-control" readonly value="${requestScope.professor.office_address}">
                             <%-- 이메일중복체크 --%>
                             <span id="zipcodeSearch"><button type="button" class="btn btn-outline-success btn-sm mt-3">우편번호 찾기</button></span>
                  </div>
               </div>
            </div>
            <div class="card-footer" style="padding-left:800px;">
               <button class="btn btn-success" id="updateBtn" onclick="">수정하기</button>
            </div>
         </form>
      
         </div>
        </div>
   </div>
</div>


<script type="text/javascript">


$(document).ready(function() {
   
	let b_emailcheck_click = false;
	// "이메일중복확인" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

	let b_pwdcheck_click = false;
	// "비밀번호중복확인" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도
	
	let b_telcheck_click = false;
	// "연락처중복확인" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도
	
	let b_addresscheck_click = false;
	// "우편번호" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도
	
   $("span.error").hide();
   
   $("input#profPwd").bind("change", function(e){// 비밀번호 유효성검사

       const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
       // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성       
       const prev_pwd = $(e.target).val();
	   // 기존 비밀번호
       
       const bool = regExp_pwd.test($(e.target).val());

       if(!bool) {
           // 암호가 정규표현식에 위배된 경우 
           $(e.target).val("");
           $(e.target).parent().find("span.error").show();
       }
       else {
           // 암호가 정규표현식에 맞는 경우 
           $(e.target).parent().find("span.error").hide();
       }
   });// 아이디가 profPwd 인 태그 값이 변했을때("change") 이벤트를 처리해주는 것이다.
   
   
   $("input#profTel").bind("change", function(e){// 연락처 유효성검사

       const regExp_tel = new RegExp(/^\d{2,3}-\d{3,4}-\d{4}$/);  
       // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성       
       const prev_tel = $(e.target).val();
	   // 기존 비밀번호
       
       const bool = regExp_pwd.test($(e.target).val());

       if(!bool) {
           // 암호가 정규표현식에 위배된 경우 
           $(e.target).val("");
           $(e.target).parent().find("span.error").show();
       }
       else {
           // 암호가 정규표현식에 맞는 경우 
           $(e.target).parent().find("span.error").hide();
       }
   });// 아이디가 profPwd 인 태그 값이 변했을때("change") 이벤트를 처리해주는 것이다.
   
   
   $("input#profPwd").bind("change", function(e){// 비밀번호 유효성검사

       const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
       // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성       
       const prev_pwd = $(e.target).val();
	   // 기존 비밀번호
       
       const bool = regExp_pwd.test($(e.target).val());

       if(!bool) {
           // 암호가 정규표현식에 위배된 경우 
           $(e.target).val("");
           $(e.target).parent().find("span.error").show();
       }
       else {
           // 암호가 정규표현식에 맞는 경우 
           $(e.target).parent().find("span.error").hide();
       }
   });// 아이디가 profPwd 인 태그 값이 변했을때("change") 이벤트를 처리해주는 것이다.
   
   
   $("input#profPwd").bind("change", function(e){// 비밀번호 유효성검사

       const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
       // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성       
       const prev_pwd = $(e.target).val();
	   // 기존 비밀번호
       
       const bool = regExp_pwd.test($(e.target).val());

       if(!bool) {
           // 암호가 정규표현식에 위배된 경우 
           $(e.target).val("");
           $(e.target).parent().find("span.error").show();
       }
       else {
           // 암호가 정규표현식에 맞는 경우 
           $(e.target).parent().find("span.error").hide();
       }
   });// 아이디가 profPwd 인 태그 값이 변했을때("change") 이벤트를 처리해주는 것이다.
   
   
   
   $("span#pwdcheck").click(function(){
	   
	   b_pwdcheck_click = true;
	   
       $.ajax({
           url:"${pageContext.request.contextPath}/professor/pwdDuplicateCheck.lms",
           data:{"pwd":$("input#profPwd").val()}, // data 속성은 http://localhost:9090/MyMVC/member/idDuplicateCheck.up 로 전송해야할 데이터를 말한다.
           type:"post", // type 을 생략하면 type : "get" 이 디폴트로 선언된다.
           
           async:true,  // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                        // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
           
           dataType : "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                              // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                              // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.

           success:function(json){
        	   console.log(JSON.stringify(json));
               
               if(json.n != 0){
                   // 입력한 userid 가 이미 데이터베이스에 저장되어 있다면
                   $("span#pwdCheckResult").html("해당 비밀번호는 이미 사용중 이므로 다른 비밀번호를 입력하세요").css({"color":"red"});
                   $("input#profPwd").val("");
                   b_pwdcheck_click = false;
               }
               else{

                   const pwd = $("input#profPwd").val().trim();

                   if( pwd == ""){
                       $("span#pwdCheckResult").html("비밀번호 값이 존재하지 않습니다!!").css({"color":"red"});
                       b_pwdcheck_click = false;
                   }

                   else{
                       // 입력한 userid 가 이미 데이터베이스에 없다면
                       $("span#pwdCheckResult").html("해당 비밀번호는 사용가능합니다.").css({"color":"navy"});
                   }
                   
               }


           },
           
           error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }

       });
	   
	   
   });// end of $("span#idcheck").click(function()
   
   
   
   
   
   
   
   
});// end of $(document).ready(function()
		
// Function Declaration		

</script>