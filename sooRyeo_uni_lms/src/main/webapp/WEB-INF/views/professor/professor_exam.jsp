<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>

<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<!-- DataPicker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />



<title>SooRyeo Univ.</title>



<script type="text/javascript">


// 문제 수 증가, 감소
var index = 1; // 변수 설정은 함수의 바깥에 설정!

$(function() {
	
	// 시작시간, 종료시간		
	var html="";
	for(var i=0; i<24; i++) {
		
		if(i<10){
			html+="<option value='0"+i+"'>0"+i+"</option>";
		}
		else{
			html+="<option value="+i+">"+i+"</option>";
		}
		
	}// end of for----------------------
	
	$("select#startHour").html(html);
	$("select#endHour").html(html);
	
	
	// 시작분, 종료분 
	html="";
	for(var i=0; i<60; i=i+5) {
		if(i<10){
			html+="<option value='0"+i+"'>0"+i+"</option>";
		}
		else {
			html+="<option value="+i+">"+i+"</option>";
		}
	}// end of for--------------------
	html+="<option value="+59+">"+59+"</option>";
	

	$("select#startMinute").html(html);
	$("select#endMinute").html(html);
	
	
	
	
	// 데이터피커
    $(".datepicker").datepicker({
        dateFormat: "yy-mm-dd" // 원하는 날짜 형식 설정
    });
    
    


    $("button#addBtn").click(function() {
        $("div#boxWrap").append(`
            <div style="display: flex; align-items: center; margin-top: 20px;" class="aw-wrap">
                <input type="hidden" class="form-control aw"  value="\${index+1}" name="questionNumber">
                <span style="width: 70px; text-align:center;">\${index+1}번 답 :</span> <!-- i 값을 span에 설정 -->
                <input type="text" class="form-control aw" style="width: 100px;" id="\${index+1}answer" name="answer"/>
                <span style="width: 70px; text-align:center;">배점 :</span>
                <input type="text" class="form-control aw ts-scr" style="width: 130px;" placeholder="숫자만 입력" id="\${index+1}score" name="score"/>
            </div>
        `);
        
        index++; // 함수 내 하단에 증가문 설정
    });
    
    
    $("button#delBtn").click(function() { 
    	$("div#boxWrap .aw-wrap").last().remove(); // 마지막 div 제거
    	
    	index--;
    });
    
    $("button#ok").click(function(){
    	
    	set_exam();
    	
    });
    
    
});

// pdf 미리보기
function previewPDF() {
	
    const input = document.getElementById('fileInput');
    const previewDiv = document.getElementById('pdfPreview');

    // 파일이 선택되지 않았을 경우
    if (input.files.length === 0) {
        previewDiv.innerHTML = '선택된 파일이 없습니다.';
        return;
    }

    const file = input.files[0];

    // 파일이 PDF인지 확인
    if (file.type !== 'application/pdf') {
        previewDiv.innerHTML = 'PDF 파일이 아닙니다.';
        return;
    }

    const fileReader = new FileReader();
    fileReader.onload = function(e) {
        const pdfData = e.target.result;
        previewDiv.innerHTML = `<iframe src="\${pdfData}#toolbar=0&navpanes=0&scrollbar=0" style="width:800px; height:900px;" type="application/pdf"></iframe>`;
        
    };

    fileReader.readAsDataURL(file); // 파일을 Data URL로 읽기
}

function updateDateTime() {
    // 각 요소의 값 가져오기
    var date = document.getElementById('test-date').value; // yyyy-mm-dd 형식
    var startHour = document.getElementById('startHour').value; // 시작 시간
    var startMinute = document.getElementById('startMinute').value; // 시작 분
    var endHour = document.getElementById('endHour').value; // 끝 시간
    var endMinute = document.getElementById('endMinute').value; // 끝 분

    // 모든 값이 입력되었는지 확인
    if (date && startHour && startMinute && endHour && endMinute) {
        // 결합하여 새로운 값 생성 (형식: yyyy-mm-dd hh:mm:ss - hh:mm:ss)
        var startDateTime = date + " " + startHour.padStart(2, '0') + ":" + startMinute.padStart(2, '0') + ":00";
        var endDateTime = date + " " + endHour.padStart(2, '0') + ":" + endMinute.padStart(2, '0') + ":00";

        // test_date_time input의 value 속성에 설정
        document.getElementById('test_start_time').value = startDateTime;
        document.getElementById('test_end_time').value = endDateTime;
    }
}


// 출제하기 버튼
function set_exam() {
	

		 // 시험 구분 유효성 검사
		 var test_type = $("input#test_type").val().trim();
		 
	     if (test_type == "") {
	           	alert("시험 구분을 입력해주세요!");
	           	return;
	     }
	      
	      
	     // 시험 날짜 유효성 검사
		  var startDate = $("#test-date").val();
          var startDate = new Date(startDate);    
          
       	  var startHour= $("select#startHour").val();
     	  var endHour = $("select#endHour").val();
     	  var startMinute= $("select#startMinute").val();
     	  var endMinute= $("select#endMinute").val();
     	

	      if (!startDate) {
               alert("날짜를 선택해 주세요.");
               return;
          }

           
        // 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
		var startDate = $("#test-date").val();	
    	var sArr = startDate.split("-");
    	startDate= "";	
    	for(var i=0; i<sArr.length; i++){
    		startDate += sArr[i];
    	}
    	
    	var endDate = $("#test-date").val();
    	var eArr = endDate.split("-");   
     	var endDate= "";
     	for(var i=0; i<eArr.length; i++){
     		endDate += eArr[i];
     	}
     	

        
     	// 조회기간 시작일자가 종료일자 보다 크면 경고
        if (Number(endDate) - Number(startDate) < 0) {
         	alert("종료일이 시작일 보다 작습니다."); 
         	return;
        }
     	
     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
        else if(Number(endDate) == Number(startDate)) {
        	
        	if(Number(startHour) > Number(endHour)){
        		alert("종료일이 시작일 보다 작습니다."); 
        		return;
        	}
        	else if(Number(startHour) == Number(endHour)){
        		if(Number(startMinute) > Number(endMinute)){
        			alert("종료일이 시작일 보다 작습니다."); 
        			return;
        		}
        		else if(Number(startMinute) == Number(endMinute)){
        			alert("시작일과 종료일이 동일합니다."); 
        			return;
        		}
        	}
       }// end of else if---------------------------------
           
       // pdf 파일 유효성 검사
       var fileInput = document.getElementById("fileInput");
       var filePath = fileInput.value;

       if (!filePath) {
           alert("파일을 선택해 주세요.");
           return;
       }
       
       
       // 시험 답안 유효성 검사
       /*
       for(var i = 1; i<=index; i++) {
    	   let answerValue = $(`input#\${i}answer`).val();
           alert(answerValue);
       }
       */
       for(var i = 1; i<=index; i++) {
	       if($(`input#\${index}answer`).val() == "") {
	    	   alert("문제의 답을 입력해주세요.");
	    	   return;
	       }
       }
       
       for(var i = 1; i<=index; i++) {
	       if($(`input#\${index}score`).val() == "") {
	    	   alert("문제의 배점을 입력해주세요.");
	    	   return;
	       }
       }
       
       updateDateTime();
       
       const frm = document.exam;
       frm.action = "<%=ctxPath%>/exam_write.lms";
       frm.method = "post";
       frm.submit();

}


</script>



<div class="content-body">

   <div class="container-fluid" style="padding-top: 10px;">
      <div class="card" id="card-title-1">
         <div class="card-header border-0 pb-0 " style="display: flex; justify-content: space-between; ">
            <h1 class="card-title" style="color:#6e6e6e;  font-weight: 900; font-size: 23px;">국어학개론 시험 출제</h1>
            <button type="button" id="ok" class="btn btn-secondary" style="width: 150px;">출제하기</button>
         </div>
         <hr>
         <div class="card-body" style="color: black; font-size: 18px;   padding: 0.75rem; ">
            <form name="exam" enctype="multipart/form-data">
               <div class="noti-wrap" style="background-color: #175F30;">
                  <span style="padding-bottom: 8px; color: white;">[출제자 유의사항]</span><br>
                  <span style="color: white;">▶ 시험지 업로드는 PDF파일만 가능합니다.</span><br>
                  <span style="color: white;">▶ 문제 추가 시 꼭 답안을 작성한 후 출제하시기 바랍니다.</span>
               </div>
               <hr>
               <div>
                  <div style="margin-bottom: 6px;"> 
                     <span style="margin-left: 55px;">> 시험구분</span>
                     <span style="margin-left: 60px;">> 시험일자</span>
                     <span style="margin-left: 100px;">> 시험 시작 시간</span>
                     <span style="margin-left: 142px;">> 시험 종료 시간</span>
                     <span style="margin-left: 150px;">> 시험지 등록</span>
                  </div>
                  <div class="con-wrap" style="display: flex;">
                  
                  	 <input type="hidden" value="${requestScope.course_seq}" name="course_seq" id ="course_seq" />
					 <input type="text" id="test_type" name="test_type" class="form-control" style="width: 120px; margin-left: 46px;" />	
                     
                     <input type="text" class="datepicker  form-control" id="test-date" name="test_date" placeholder="날짜 선택" style="width: 120px; margin-left: 46px;" readonly>
                     <select class="form-control" id="startHour" name="startHour" class="form-select" style="width: 90px; margin-left: 5%;"></select>&nbsp;시&nbsp;
					 <select class="form-control" id="startMinute" name="startMinute" class="form-select" style="width: 100px;"></select>&nbsp;분
					 <select class="form-control" id="endHour" name="endHour" class="schedule" style="width: 90px; margin-left: 3%;"></select>&nbsp;시&nbsp;
					 <select class="form-control" id="endMinute" name="endMinute" class="schedule" style="width: 100px;"></select>&nbsp;분
					 
					 <input type="hidden" id="test_start_time" name="test_start_time" />
					 <input type="hidden" id="test_end_time" name="test_end_time" />
					 
					 
                     <input type="file" class="form-control" id="fileInput" name="attach" accept="application/pdf" style="width: 300px; margin-left: 45px;" onchange="previewPDF()" />

					
                  </div>
               </div>
               
               
               <hr>
               <div class="answer-wrap" style="display: flex;">
                  <div id="myPdf" style="width:800px; height:900px; border: solid 1px black;">
                  	 <div id="pdfPreview" style="text-align: center;"><div style="margin-top: 50%;">시험지 미리보기 <br>(파일을 먼저 등록해주세요.)</div></div>
                  </div>
                  <div class="hidden"></div>
                  <div style="padding-left: 20px; width: 50%;"> 
                     <button type="button" class="btn btn-primary" id="addBtn" style="margin-bottom: 12px; margin-top: 12px; padding: 8px 15px;">답안추가</button>
                     <button type="button" class="btn btn-danger light" id="delBtn" style="margin-bottom: 12px; margin-top: 12px; padding: 8px 15px; margin-left: 30px;">답안삭제</button>

                     <div id="answer-container">

							<div id="boxWrap">
							
	                             <div style="display: flex; align-items: center; margin-top: 20px;" class="aw-wrap">
	                                <input type="hidden" class="form-control aw"  value="1" name="questionNumber">
	                                <span style="width: 70px; text-align:center;">1번 답 :</span> <input type="text" class="form-control aw" style="width: 100px;" id="1answer" name="answer">
	                                <span style="width: 70px; text-align:center;">배점 :</span> <input type="text" class="form-control aw ts-scr"  style="width: 130px;" id="1score" name="score" placeholder="숫자만 입력">
	                             </div>

							</div>

                     </div>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>
