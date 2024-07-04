let b_emailcheck_click = false;
// "이메일중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let b_pwdcheck_click = false;
// "비밀번호중복확인" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let b_telcheck_click = false;
// "연락처중복확인" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let b_zipcodeSearch_click = false;
// "우편번호" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도


$(document).ready(function(){
	
    $("span.error").hide();

    // 비밀번호 중복체크
    $("span#pwdcheck").click(function(){
	   
        const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
        // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성       
        const prev_pwd = $("input#stuPwd").val();
        // 기존 비밀번호
        
        const bool = regExp_pwd.test($("input#stuPwd").val());
 
        if(!bool) {
            // 암호가 정규표현식에 위배된 경우 
            $("input#stuPwd").val("");
            $("input#stuPwd").parent().find("span.error").show();
            return;
        }
        else {
            // 암호가 정규표현식에 맞는 경우 
            $("input#stuPwd").parent().find("span.error").hide();
        }
        
        
        b_pwdcheck_click = true;
        
        $.ajax({
            url:"pwdDuplicateCheck.lms",
            data:{"pwd":$("input#stuPwd").val()},
            type:"post", 
            async:true,  
            dataType : "json", 
            success:function(json){
                console.log(JSON.stringify(json));
                
                if(json.n != 0){
                    // 입력한 비밀번호가 이미 데이터베이스에 저장되어 있다면
                    $("span#pwdCheckResult").html("해당 비밀번호는 이미 사용중 이므로<br>다른 비밀번호를 입력하세요.").css({"color":"red","font-size":14});
                    $("input#stuPwd").val("");
                    b_pwdcheck_click = false;
                }
                else{
 
                    const pwd = $("input#stuPwd").val().trim();
 
                    if( pwd == ""){
                        $("span#pwdCheckResult").html("비밀번호 값이 존재하지 않습니다.").css({"color":"red","font-size":14});
                        b_pwdcheck_click = false;
                    }
 
                    else{
                        // 입력한 비밀번호가 이미 데이터베이스에 없다면
                        $("span#pwdCheckResult").html("해당 비밀번호는 사용가능합니다.").css({"color":"navy","font-size":14});
                    }
                    
                }
 
 
            },
            
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
 
        });
        
        
    });// end of $("span#pwdcheck").click(function()



    // 연락처 중복체크
    $("span#telcheck").click(function(){
	   
	   
        const regExp_tel = new RegExp(/^010{1}[1-9][0-9]{3}\d{4}$/);  
        // 010포함한문자      
        const prev_tel = $("input#stuTel").val();
        // 기존 연락처
        
        const bool = regExp_tel.test($("input#stuTel").val());
 
        if(!bool) {
            // 연락처가 정규표현식에 위배된 경우 
            $("input#stuTel").val("");
            $("input#stuTel").parent().find("span.error").show();
            return;
        }
        else {
            // 연락처가 정규표현식에 맞는 경우 
            $("input#stuTel").parent().find("span.error").hide();
        }
        
        
        b_telcheck_click = true;
        
        $.ajax({
            url:"telDuplicateCheck.lms",
            data:{"tel":$("input#stuTel").val()}, 
            type:"post", 
            async:true, 
            dataType : "json", 
            success:function(json){
                console.log(JSON.stringify(json));
                
                if(json.n != 0){
                    // 입력한 prof_id 가 이미 데이터베이스에 저장되어 있다면
                       if (confirm("기존 연락처를 유지하시겠습니까?")){    //확인
                           $("span#telCheckResult").html("해당 연락처는 사용가능합니다.").css({"color":"navy","font-size":14});
                       }
                       else{   //취소
                           $("input#stuTel").val("");
                           b_telcheck_click = false;
                           return;
                       }
                    
                }
                else{
 
                    const pwd = $("input#stuTel").val().trim();
 
                    if( pwd == ""){
                        $("span#telCheckResult").html("연락처 값이 존재하지 않습니다!!").css({"color":"red","font-size":14});
                        b_telcheck_click = false;
                    }
 
                    else{
                        // 입력한 userid 가 이미 데이터베이스에 없다면
                        $("span#telCheckResult").html("해당 연락처는 사용가능합니다.").css({"color":"navy","font-size":14});
                    }
                    
                }
 
 
            },
            
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
 
        });
        
        
    });// end of $("span#telcheck").click(function()



    // 이메일 중복체크
    $("span#emailcheck").click(function(){
	   
	   
        const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  
        // 이메일 정규표현식 객체 생성 
        
        const prev_email = $("input#stuEmail").val();
        // 기존 이메일
        
        const bool = regExp_email.test($("input#stuEmail").val());
 
        if(!bool) {
            // 이메일 정규표현식에 위배된 경우 
            $("input#stuEmail").val("");
            $("input#stuEmail").parent().find("span#email_error").show();
            return;
        }
        else {
            // 이메일 정규표현식에 맞는 경우 
            $("input#stuEmail").parent().find("span#email_error").hide();
        }
        
        
        b_emailcheck_click = true;
        
        $.ajax({
            url:"emailDuplicateCheck.lms",
            data:{"email":$("input#stuEmail").val()}, 
            type:"post", 
            async:true,  
            dataType : "json", 
            success:function(json){
                console.log(JSON.stringify(json));
                
                if(json.n != 0){
                    // 입력한 email이 이미 데이터베이스에 저장되어 있다면
                       if (confirm("기존 이메일을 유지하시겠습니까?")){    //확인
                           $("span#emailCheckResult").html("해당 이메일은 사용가능합니다.").css({"color":"navy","font-size":14});
                       }
                       else{   //취소
                           $("input#stuEmail").val("");
                           b_emailcheck_click = false;
                           return;
                       }
                    
                }
                else{
 
                    const pwd = $("input#stuEmail").val().trim();
 
                    if( pwd == ""){
                        $("span#emailCheckResult").html("이메일 값이 존재하지 않습니다!!").css({"color":"red","font-size":14});
                        b_emailcheck_click = false;
                    }
 
                    else{
                        // 입력한 email이 이미 데이터베이스에 없다면
                        $("span#emailCheckResult").html("해당 이메일은 사용가능합니다.").css({"color":"navy","font-size":14});
                    }
                    
                }
 
 
            },
            
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
 
        });
        
        
    });// end of $("span#emailcheck").click
               


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






///////////////////////////////////////////////////////////////////////////////////////////////
// 파일첨부 and 미리보기

 // ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 시작 <<== //
	   $(document).on("change", "input#formFile", function(e){
		   
			   const input_file = $(e.target).get(0);
	           $("input#imgname").val(input_file.files[0].name);
	           
			   // 자바스크립트에서 file 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
		       const fileReader = new FileReader();
	           
		       fileReader.readAsDataURL(input_file.files[0]); // FileReader.readAsDataURL() --> 파일을 읽고, result 속성에 파일을 나타내는 URL을 저장 시켜준다.
		       
		       fileReader.onload = function(){ // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임.
	           
	           document.getElementById("previewImg").src = fileReader.result; // ■■■■■■  id가 previewImg 이것인 img 태그에 위에서 얻어온 img.src값을 넣어준 것이다. ■■■■■■
	       };
			
	   }); // end of $(document).on("change", "input.img_file", function(e){}-------------------------------------------------------------------------------------------------------------
	   // ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 끝 <<== //
	   

});// end of $(document).ready(function(){})----------------




// Function Declaration
function goEdit(ctxPath) {
	
    // *** "비밀번호중복확인" 를 클릭했는지 검사하기 시작 *** //
    if(!b_pwdcheck_click) {
        // "비밀번호중복확인" 를 클릭 안 했을 경우
		alert("비밀번호 중복확인를 클릭하셔서 비밀번호를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
    }
    // *** "비밀번호중복확인" 를 클릭했는지 검사하기 끝 *** //
    
    
    // *** "연락처중복확인" 를 클릭했는지 검사하기 시작 *** //
    if(!b_telcheck_click) {
        // "연락처중복확인" 를 클릭 안 했을 경우
		alert("연락처 중복확인을 클릭하셔서 연락처를 입력하셔야 합니다.");
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
	
	
	goEdit_noAttach(ctxPath);

} // end of function goEdit()---------------------


// 첨부파일 없을 때 등록
function goEdit_noAttach(ctxPath){
	
    const frm = document.studentFrm;
    frm.method = "post";
    frm.action = ctxPath+"/student/student_info_edit.lms";
    frm.submit();	
	
} 







