let b_emailcheck_click = false;
// "이메일중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

$(document).ready(function(){
	
    $("span.error").hide();
    $("input[name='stuName']").focus();

    $("input[name='stuName']").blur( (e) => {

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
    

    $("input[name='stuEmail']").blur( (e) => { 

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

    
    ///////////////////////////////////////////////////////////


    // 이메일값이 변경되면 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기
    $("input[name='stuEmail']").bind("change", function(){
        b_emailcheck_click = false;
    });



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

//"이메일중복확인"을 클릭했을 때 이벤트 처리하기 시작 //
function emailcheck(ctxPath) {
    b_emailcheck_click = true; // "이메일중복확인" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도  
    
    $.ajax({
        url : ctxPath + "/student/emailDuplicateCheck.lms",
        data : {"email" : $( "input[name='stuEmail']" ).val()},
        type : "post",
        dataType : "json",  
        success : function(json){
            console.log(JSON.stringify(json));
            if(json.emailDuplicateCheck != null) {
                // 입력한 email이 이미 사용중이라면 
                $("span#emailCheckResult").html( $("input[name='stuEmail']").val() + " 은 이미 사용중 이므로 다른 이메일을 입력하세요.").css({"color":"red"});
                $("input[name='stuEmail']").val("");
            } 
            else {
                
                // 입력한 email이 존재하지 않는 경우라면 
                $("span#emailCheckResult").html( $("input[name='stuEmail']").val() + " 은 사용가능 합니다.").css({"color":"navy"});
            }
        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });
};


// "수정하기" 버튼 클릭시 호출되는 함수
function goUpdate(ctxPath) {

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
        return; // goUpdate() 함수를 종료한다.
    }
    // *** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 *** //


    // *** "이메일중복확인" 을 클릭했는지 검사하기 시작 *** //
    if( !b_emailcheck_click ) {
        // "이메일중복확인" 을 클릭 안 했을 경우 
        alert("이메일 중복확인을 클릭하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** "이메일중복확인" 을 클릭했는지 검사하기 끝 *** //

    const frm = document.registerFrm;
    frm.action = ctxPath+"/student/myInfoUpdate.lms";
    frm.method = "post";
    frm.submit();

} // end of function goUpdate()---------------------


function goReset() {
    $("span.error").hide();
    $("span#idcheckResult").empty();
    $("span#emailCheckResult").empty();
} //  end of function goReset() {}----------------------------------

function goGaib() {
    alert("회원가입에 대한 유효성검사를 한후에 통과되면 submit 하려고 함");
}