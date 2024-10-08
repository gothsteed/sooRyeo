let b_emailcheck_click = false;
// "이메일중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let b_zipcodeSearch_click = false;
// "우편번호찾기" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

$(document).ready(function(){
   
    $("div#student").show();
    $("div#professor").hide();
    
    $("input#option1").click(function(){
        $("div#professor").hide();
        $("div#student").show();

        $("span.error").hide();
    });
    $("input#option2").click(function(){
        $("div#student").hide();
        $("div#professor").show();
        
        $("span.error").hide();
    });
      
    $("span.error").hide();
    $("input#name").focus();

    $("input#name").blur( (e) => {

        const name = $(e.target).val().trim();
        if(name == "") {
            // 입력하지 않거나 공백만 입력했을 경우 
            $("form[action='#'] input").prop("disabled", true);
            $(e.target).prop("disabled", false);
            $(e.target).val("").focus();
        
            $(e.target).parent().find("span.error").show();
        }
        else {
            // 공백이 아닌 글자를 입력했을 경우
            $("form[action='#'] input").prop("disabled", false);

            $(e.target).parent().find("span.error").hide();
        }

    });// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
    
    $("input#pwd").blur( (e) => { 

        const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
        // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
        
        const bool = regExp_pwd.test($(e.target).val());

        if(!bool) {
            // 암호가 정규표현식에 위배된 경우 
            
            $("form[action='#'] input").prop("disabled", true);
            $("input#pwdcheck").prop("disabled", false);
            $(e.target).prop("disabled", false);
            $(e.target).val("").focus();
        
            $(e.target).next().show();
        }
        else {
            // 암호가 정규표현식에 맞는 경우 
            $("form[action='#'] input").prop("disabled", false);

            $(e.target).parent().find("span.error").hide();
        }
    });// 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

    $("input#pwdcheck").blur( (e) => {

        if( $("input#pwd").val() != $(e.target).val() ) {
            // 암호와 암호확인값이 틀린 경우 
            
            $("form[action='#'] input").prop("disabled", true);
            $("input#pwd").prop("disabled", false);
            $(e.target).prop("disabled", false);
            $("input#pwd").val("").focus();
            $(e.target).val("");
        
            $(e.target).next().show();
        }
        else {
            // 암호와 암호확인값이 같은 경우
            $("form[action='#'] input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
        }
   
    });// 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

    $("input#email").blur( (e) => { 

    // const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
    // 또는
        const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  
        // 이메일 정규표현식 객체 생성 
        
        const bool = regExp_email.test($(e.target).val());

        if(!bool) {
            // 이메일이 정규표현식에 위배된 경우 
            
            $("form[action='#'] input").prop("disabled", true);
            $(e.target).prop("disabled", false);
            $(e.target).val("").focus();
        
        //  $(e.target).next().show();
        //  또는
            $(e.target).parent().next().next().find("span.error").show();

        }
        else {
            // 이메일이 정규표현식에 맞는 경우 
            $("form[action='#'] input").prop("disabled", false);

            //  $(e.target).next().hide();
            //  또는
            $(e.target).parent().find("span.error").hide();
        }

    });// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.       


    $("input#hp2").blur( (e) => {
    
        const regExp_hp2 = new RegExp(/^[1-9][0-9]{3}$/);  
        // 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성 
        
        const bool = regExp_hp2.test($(e.target).val());   
        
        if(!bool) {
            // 연락처 국번이 정규표현식에 위배된 경우 
            
            $("form[action='#'] input").prop("disabled", true);  
            $(e.target).prop("disabled", false); 
            
            $(e.target).parent().next().next().children().show();
            $(e.target).val("").focus(); 
        }
        else {
            // 연락처 국번이 정규표현식에 맞는 경우 
            $("form[action='#'] input").prop("disabled", false);
            $(e.target).parent().next().next().children().hide();
        }
    });// 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
    
    $("input#hp3").blur( (e) => {
        
        const regExp_hp3 = new RegExp(/^\d{4}$/);  
        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성 
        
        const bool = regExp_hp3.test($(e.target).val());   
        
        if(!bool) {
            // 마지막 전화번호 4자리가 정규표현식에 위배된 경우 
            
            $("form[action='#'] input").prop("disabled", true);  
            $(e.target).prop("disabled", false); 
            $(e.target).parent().next().next().children().show();
                    
            $(e.target).val("").focus(); 
        }
        else {
            // 마지막 전화번호 4자리가 정규표현식에 맞는 경우 
            $("form[action='#'] input").prop("disabled", false);
            
            $(e.target).parent().next().next().children().hide();
        }
    });// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

    $("input#jubun").blur((e) => {
        const jubunValue = $(e.target).val(); // 입력값 얻기
        
        // jubun 유효성 검사
        let isValidJubun = true;
    
        // jubun의 길이는 13자리여야 함
        if (jubunValue.length !== 13) {
            isValidJubun = false;
            alert("주민등록번호는 13자리여야 합니다.");
        }
        
        // 7번째 자리의 값은 "1", "2", "3", "4" 중 하나여야 함
        if (!(jubunValue.charAt(6) === '1' || jubunValue.charAt(6) === '2' || jubunValue.charAt(6) === '3' || jubunValue.charAt(6) === '4')) {
            isValidJubun = false;
            alert("주민등록번호의 7번째 자리가 올바르지 않습니다.");
        }
        
        // 생년월일 추출
        let strBirthday = '';
        if (jubunValue.charAt(6) === '1' || jubunValue.charAt(6) === '2') {
            strBirthday = '19' + jubunValue.substring(0, 6);
        } else {
            strBirthday = '20' + jubunValue.substring(0, 6);
        }
        
        // 날짜 형식 확인
        const sdformat = /^(\d{4})(\d{2})(\d{2})$/;
        if (!sdformat.test(strBirthday)) {
            isValidJubun = false;
            alert("주민등록번호의 생년월일 형식이 올바르지 않습니다.");
        }
    
        // 실제로 존재하는 날짜인지 확인
        const year = parseInt(strBirthday.substring(0, 4), 10);
        const month = parseInt(strBirthday.substring(4, 6), 10) - 1; // 월은 0부터 시작하므로 -1 처리
        const day = parseInt(strBirthday.substring(6, 8), 10);
        const birthday = new Date(year, month, day);
    
        // 날짜가 실제로 존재하는지 확인
        if (birthday.getFullYear() !== year || birthday.getMonth() !== month || birthday.getDate() !== day) {
            isValidJubun = false;
            alert("주민등록번호의 생년월일이 올바르지 않습니다.");
        }
    
        // 현재 날짜와 비교하여 생일이 미래인지 확인
        const now = new Date();
        now.setHours(0, 0, 0, 0); // 현재 시간을 00:00:00으로 설정하여 정확한 비교를 위해 시간 부분을 제거
        
        if (birthday.getTime() > now.getTime()) {
            isValidJubun = false;
            alert("주민등록번호의 생년월일은 현재 날짜보다 미래일 수 없습니다.");
        }
    
        // 유효성에 따라 입력란 활성화/비활성화
        if (!isValidJubun) {
            // 유효하지 않으면 모든 입력란 비활성화
            $('form[action="#"] input').prop('disabled', true);
            $(e.target).parent().find("span.error").show();
            $(e.target).prop("disabled", false); 
        } else {
            // 유효하면 모든 입력란 활성화
            $('form[action="#"] input').prop('disabled', false);
            $(e.target).parent().find("span.error").hide();
        }
    });

    $("input#postcode").blur( (e) => {
    
        const regExp_postcode = new RegExp(/^\d{5}$/);  
        // 숫자 5자리만 들어오도록 검사해주는 정규표현식 객체 생성 
        
        const bool = regExp_postcode.test($(e.target).val());   
        
        if(!bool) {
            // 우편번호가 정규표현식에 위배된 경우 
            
            $("form[action='#'] input").prop("disabled", true);  
            $(e.target).prop("disabled", false); 
            
            $(e.target).parent().find("span.error").show();
            $(e.target).val("").focus(); 
        }
        else {
            // 우편번호가 정규표현식에 맞는 경우 
            $("form[action='#'] input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
        }
            
    });// 아이디가 postcode 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

    // 입력란의 blur 이벤트 처리
    $("input[name='register_year']").blur((e) => {
        const inputValue = $(e.target).val(); // 입력값 얻기
        
        if (inputValue.trim() === '') {
            // 입력값이 없는 경우 처리
            alert("입학년도를 입력해주세요.");
            $(e.target).val(''); // 입력값 초기화
        } else if (!/^\d{4}$/.test(inputValue)) {
            // 입력값이 숫자 4자리가 아닌 경우 처리
            alert("입학년도는 숫자로 4자리를 입력해야 합니다.");
            $(e.target).val(''); // 입력값 초기화
        } else {
            const enteredYear = parseInt(inputValue, 10);
            const currentYear = new Date().getFullYear();
            
            // 현재 년도보다 미래인 경우 처리
            if (enteredYear > currentYear) {
                alert("입학년도는 현재 년도보다 미래일 수 없습니다.");
                $(e.target).val(''); // 입력값 초기화
            }
        }
    });
    
    ///////////////////////////////////////////////////////////

    // 우편번호를 읽기전용(readonly) 로 만들기
    $("input#postcode").attr("readonly", true);

    // 주소를 읽기전용(readonly) 로 만들기
    $("input#address").attr("readonly", true);
    
    // 참고항목을 읽기전용(readonly) 로 만들기
    $("input#extraAddress").attr("readonly", true);

    // === "우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
    $("img#zipcodeSearch").click(function(){
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

    // 이메일값이 변경되면 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기
    $("input#email").bind("change", function(){
        b_emailcheck_click = false;
    });

 // ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 시작 <<== //
	   $(document).on("change", "input.img_file", function(e){
		   
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

//"이메일중복확인"을 클릭했을 때 이벤트 처리하기 시작 //
function emailcheck(ctxPath) {
    b_emailcheck_click = true; // "이메일중복확인" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도  
    
    $.ajax({
        url : ctxPath + "/admin/emailDuplicateCheck.lms",
        data : {"email" : $( "input#email" ).val()},
        type : "post",
        dataType : "json",  
        success : function(json){
            console.log(JSON.stringify(json));
            if(json.emailDuplicateCheck != null) {
                // 입력한 email이 이미 사용중이라면 
                $("span#emailCheckResult").html( $("input#email").val() + " 은 이미 사용중 이므로 다른 이메일을 입력하세요").css({"color":"red"});
                $("input#email").val("");
            } 
            else {
                // 입력한 userid 가 존재하지 않는 경우라면
                $("span#emailCheckResult").html( $("input#email").val() + " 은 사용가능 합니다.").css({"color":"navy"});
            }
        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });
};

// Function Declaration
// "등록하기" 버튼 클릭시 호출되는 함수
function goRegister(ctxPath) {

    // *** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 *** //
    let b_requiredInfo = true;

    const requiredInfo_list = document.querySelectorAll("input.requiredInfo"); 
    
    for(let i=0; i<requiredInfo_list.length; i++){
        const val = requiredInfo_list[i].value.trim();
        if(val == ""){
            alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
            b_requiredInfo = false;
            break; 
        }
    } // end of for-----------------
 
    if(!b_requiredInfo) {
        return; // goRegister() 함수를 종료한다.
    }
    // *** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 *** //

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
   
   if(postcode == "" || address == "" || detailAddress == "") {
      alert("우편번호 및 주소를 입력하셔야 합니다.");
      return; // goRegister() 함수를 종료한다.
   }
   // *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //

      const frm = document.registerFrm;
      frm.action = ctxPath+"/admin/memberRegister_end.lms";
      frm.method = "post";
      frm.submit();

} // end of function goRegister()---------------------
