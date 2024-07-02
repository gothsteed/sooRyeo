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

<%-- kakao 우편주소 불러오기용 --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

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
           
         <form class="profile-frm" name="professorFrm">
            <div class="d-flex">
               <img src="<%=ctxPath%>/resources/images/koala.png" class="img-fluid rounded-start" style="width:15%; margin-left:5%;" />
               <div style="width:25%;" class="prodInputName" style="padding-bottom: 10px; margin-left:5%;">이미지파일 미리보기</div>
               <div><img id="previewImg" width="300"/></div>				    	
               <input class="form-control img_file" type="file" name="attach" id="formFile" style="width:30%; margin-top: 10%;">
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
                     <span class="error">010으로 시작하는 연락처를 입력해주세요.</span>
                     <input type="text" id="profTel" name="tel" class="form-control" value="${requestScope.professor.tel}">
                             <%-- 연락처중복체크 --%>
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
                     <input type="text" id="postcode" name="postcode" class="form-control w-25 mb-1" />
                     <input type="text" id="address" name="address" class="form-control mb-1" />
                     <input type="text" id="detailAddress" name="detailAddress" class="form-control mb-1" />
                     <input type="text" id="extraAddress" name="extraAddress" class="form-control" />
                             <%-- 이메일중복체크 --%>
                             <span id="zipcodeSearch"><button type="button" class="btn btn-outline-success btn-sm mt-3">우편번호 찾기</button></span>
                  </div>
               </div>
            </div>
            <div class="card-footer" style="padding-left:800px;">
               <button class="btn btn-success" id="updateBtn" onclick="goEdit()">수정하기</button>
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
	
	let b_zipcodeSearch_click = false;
	// "우편번호" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도
	
   $("span.error").hide();
       
   
   $("span#pwdcheck").click(function(){// 비밀번호 중복체크
	   
	   
       const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
       // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성       
       const prev_pwd = $("input#profPwd").val();
	   // 기존 비밀번호
       
       const bool = regExp_pwd.test($("input#profPwd").val());

       if(!bool) {
           // 암호가 정규표현식에 위배된 경우 
           $("input#profPwd").val("");
           $("input#profPwd").parent().find("span.error").show();
           return;
       }
       else {
           // 암호가 정규표현식에 맞는 경우 
           $("input#profPwd").parent().find("span.error").hide();
       }
	   
	   
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
	   
	   
   });// end of $("span#pwdcheck").click(function()
		   
		   
   $("span#telcheck").click(function(){// 연락처 중복체크
	   
	   
       const regExp_tel = new RegExp(/^010{1}[1-9][0-9]{3}\d{4}$/);  
       // 010포함한문자      
       const prev_tel = $("input#profTel").val();
	   // 기존 연락처
       
       const bool = regExp_tel.test($("input#profTel").val());

       if(!bool) {
           // 연락처가 정규표현식에 위배된 경우 
           $("input#profTel").val("");
           $("input#profTel").parent().find("span.error").show();
           return;
       }
       else {
           // 연락처가 정규표현식에 맞는 경우 
           $("input#profTel").parent().find("span.error").hide();
       }
	   
	   
       b_telcheck_click = true;
	   
       $.ajax({
           url:"${pageContext.request.contextPath}/professor/telDuplicateCheck.lms",
           data:{"tel":$("input#profTel").val()}, // data 속성은 http://localhost:9090/MyMVC/member/idDuplicateCheck.up 로 전송해야할 데이터를 말한다.
           type:"post", // type 을 생략하면 type : "get" 이 디폴트로 선언된다.
           
           async:true,  // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                        // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
           
           dataType : "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                              // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                              // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.

           success:function(json){
        	   console.log(JSON.stringify(json));
               
               if(json.n != 0){
                   // 입력한 prof_id 가 이미 데이터베이스에 저장되어 있다면
            		  if (confirm("기존 연락처를 유지하시겠습니까?")){    //확인
            			  $("span#telCheckResult").html("해당 연락처는 사용가능합니다.").css({"color":"navy"});
            		  }
            		  else{   //취소
            			  $("input#profTel").val("");
            			  b_telcheck_click = false;
            		      return;
            		  }
                   
               }
               else{

                   const pwd = $("input#profTel").val().trim();

                   if( pwd == ""){
                       $("span#telCheckResult").html("연락처 값이 존재하지 않습니다!!").css({"color":"red"});
                       b_telcheck_click = false;
                   }

                   else{
                       // 입력한 userid 가 이미 데이터베이스에 없다면
                       $("span#telCheckResult").html("해당 연락처는 사용가능합니다.").css({"color":"navy"});
                   }
                   
               }


           },
           
           error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }

       });
	   
	   
   });// end of $("span#telcheck").click(function()
		   
		   
   $("span#emailcheck").click(function(){// 이메일 중복체크
	   
	   
	   const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  
       // 이메일 정규표현식 객체 생성 
       
       const prev_email = $("input#profEmail").val();
	   // 기존 이메일
       
       const bool = regExp_email.test($("input#profEmail").val());

       if(!bool) {
           // 이메일 정규표현식에 위배된 경우 
           $("input#profEmail").val("");
           $("input#profEmail").parent().find("span.error").show();
           return;
       }
       else {
           // 연락처가 정규표현식에 맞는 경우 
           $("input#profEmail").parent().find("span.error").hide();
       }
	   
	   
       b_emailcheck_click = true;
	   
       $.ajax({
           url:"${pageContext.request.contextPath}/professor/emailDuplicateCheck.lms",
           data:{"email":$("input#profEmail").val()}, // data 속성은 http://localhost:9090/MyMVC/member/idDuplicateCheck.up 로 전송해야할 데이터를 말한다.
           type:"post", // type 을 생략하면 type : "get" 이 디폴트로 선언된다.
           
           async:true,  // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                        // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
           
           dataType : "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                              // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                              // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.

           success:function(json){
        	   console.log(JSON.stringify(json));
               
               if(json.n != 0){
                   // 입력한 email이 이미 데이터베이스에 저장되어 있다면
            		  if (confirm("기존 이메일을 유지하시겠습니까?")){    //확인
            			  $("span#emailCheckResult").html("해당 이메일은 사용가능합니다.").css({"color":"navy"});
            		  }
            		  else{   //취소
            			  $("input#profEmail").val("");
            			  b_emailcheck_click = false;
            		      return;
            		  }
                   
               }
               else{

                   const pwd = $("input#profEmail").val().trim();

                   if( pwd == ""){
                       $("span#emailCheckResult").html("이메일 값이 존재하지 않습니다!!").css({"color":"red"});
                       b_emailcheck_click = false;
                   }

                   else{
                       // 입력한 email이 이미 데이터베이스에 없다면
                       $("span#emailCheckResult").html("해당 이메일은 사용가능합니다.").css({"color":"navy"});
                   }
                   
               }


           },
           
           error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }

       });
	   
	   
   });// end of $("span#telcheck").click(function()
		   		   
		   
   /////////////////////////////////////////////////////////////////
			   
   // 우편번호를 읽기전용(readonly) 로 만들기
   $("input#postcode").attr("readonly", true);

   // 주소를 읽기전용(readonly) 로 만들기
   $("input#address").attr("readonly", true);
   
   // 참고항목을 읽기전용(readonly) 로 만들기
   $("input#extraAddress").attr("readonly", true);

   // === "우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
   $("span#zipcodeSearch").click(function(){
       b_zipcodeSearch_click = true;
       // "우편번호찾기" 클릭여부를 알아오기 위한 용도  
   
       new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               let addr = ''; // 주소 변수
               let extraAddr = ''; // 참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               } else { // 사용자가 지번 주소를 선택했을 경우(J)
                   addr = data.jibunAddress;
               }

               // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
               if(data.userSelectedType === 'R'){
                   // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                   // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                       extraAddr += data.bname;
                   }
                   // 건물명이 있고, 공동주택일 경우 추가한다.
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                   if(extraAddr !== ''){
                       extraAddr = ' (' + extraAddr + ')';
                   }
                   // 조합된 참고항목을 해당 필드에 넣는다.
                   document.getElementById("extraAddress").value = extraAddr;
               
               } else {
                   document.getElementById("extraAddress").value = '';
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('postcode').value = data.zonecode;
               document.getElementById("address").value = addr;
               // 커서를 상세주소 필드로 이동한다.
               document.getElementById("detailAddress").focus();
           }
       }).open();
   
       // 우편번호를 읽기전용(readonly) 로 만들기
       $("input#postcode").attr("readonly", true);

       // 주소를 읽기전용(readonly) 로 만들기
       $("input#address").attr("readonly", true);
   
       // 참고항목을 읽기전용(readonly) 로 만들기
       $("input#extraAddress").attr("readonly", true);
       
	});// end of $("img#zipcodeSearch").click()------------		   
      
   
});// end of $(document).ready(function()
		
// Function Declaration		

function goEdit() {
	
    // *** "비밀번호중복확인" 를 클릭했는지 검사하기 시작 *** //
    if(!b_pwdcheck_click) {
        // "비밀번호중복확인" 를 클릭 안 했을 경우
		alert("비밀번호중복확인를 클릭하셔서 비밀번호를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
    }
    // *** "비밀번호중복확인" 를 클릭했는지 검사하기 끝 *** //
    
    
    // *** "연락처중복확인" 를 클릭했는지 검사하기 시작 *** //
    if(!b_telcheck_click) {
        // "연락처중복확인" 를 클릭 안 했을 경우
		alert("연락처중복확인을 클릭하셔서 연락처를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
    }
    // *** "연락처중복확인" 를 클릭했는지 검사하기 끝 *** //
	
	

    // *** "이메일중복확인" 을 클릭했는지 검사하기 시작 *** //
    if( !b_emailcheck_click ) {
        // "이메일중복확인" 을 클릭 안 했을 경우 
        alert("이메일 중복확인을 클릭하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** "이메일중복확인" 을 클릭했는지 검사하기 끝 *** //

    // *** "우편번호찾기" 를 클릭했는지 검사하기 시작 *** //
    if(!b_zipcodeSearch_click) {
        // "우편번호찾기" 를 클릭 안 했을 경우
		alert("우편번호찾기를 클릭하셔서 우편번호를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
    }
    // *** "우편번호찾기" 를 클릭했는지 검사하기 끝 *** //

    // *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
	const postcode = $("input#postcode").val().trim();
	const address = $("input#address").val().trim();
	const detailAddress = $("input#detailAddress").val().trim();
	const extraAddress = $("input#extraAddress").val().trim();
	
	if(postcode == "" || address == "" || detailAddress == "" || extraAddress == "") {
		alert("우편번호 및 주소를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //
	
	
	goEdit_noAttach();

} // end of function goEdit()---------------------


function goEdit_noAttach(){// 첨부파일 없을 때 등록
	
    const frm = document.professorFrm;
    frm.method = "post";
    frm.action = "<%= ctxPath%>/professor/professor_info_edit.lms";
    frm.submit();	
	
} 





</script>