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

<style>
input#fileInput {
  border:1px solid #CCCCCC;
  padding:5px;
  border-radius:8px;
  background:#fff;
}
input#fileInput::file-selector-button {
  border:1px solid #CCCCCC;
  border-radius:8px;
  background:fff;
  color:black;
  transition:.2s;
}

input::file-selector-button:hover {
  background:#CCCCCC;
  color:#fff;
}
</style>


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
                    <input type="text" class="form-control aw" style="width: 80px;" id="\${index+1}answer" name="answer"/>
                    <span style="width: 70px; text-align:center;">배점 :</span>
                    <input type="text" class="form-control aw ts-scr" style="width: 80px;" placeholder="숫자만 입력" id="\${index+1}score" name="score"/>
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
        
        console.log("startDateTime 확인용", startDateTime);
        console.log("endDateTime 확인용", endDateTime);

        // test_date_time input의 value 속성에 설정
        $("input:hidden[name='test_start_time']").val(startDateTime);
        $("input:hidden[name='test_end_time']").val(endDateTime);
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
     	
		  var testDate = $("input#test-date").val();
		  console.log("startHour", startHour);
		  console.log("endHour", endHour);
		  console.log("startMinute", startMinute);
		  console.log("endMinute", endMinute);
     	  
	      if(!testDate) {
               alert("날짜를 선택해 주세요.");
               return;
          }
	      
 	      if(startHour - endHour > 0) {
	      		alert("종료시간이 시작시간 보다 작습니다."); 
	    		return;
	      }


        // 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
		var startDate = $("#test-date").val();	
    	var sArr = startDate.split("-");
    	startDate= "";	
    	for(var i=0; i<sArr.length; i++){
    		startDate += sArr[i];
    	}
    	
    	const now = new Date();

    	const year = now.getFullYear();
    	const month = String(now.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
    	const day = String(now.getDate()).padStart(2, '0');
    	const hours = String(now.getHours()).padStart(2, '0');
    	const minutes = String(now.getMinutes()).padStart(2, '0');
    	const sysdate = `\${year}\${month}\${day}`;
    	const syshour = `\${hours}`;
    	const sysminutes = `\${minutes}`;
    	
    	var endDate = sysdate;

     	// 조회기간 시작일자가 종료일자 보다 크면 경고
        if (Number(endDate) - Number(startDate) > 0) {
         	alert("이미 지난 날짜에는 시험을 출제할 수 없습니다."); 
         	return;
        }
     	
     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
     	else if(Number(endDate) == Number(startDate)) {
        	
        	if(Number(startHour) < Number(syshour)) {
        		alert("이미 지난 시간에는 시험을 출제할 수 없습니다.");
        		return;
        	}
        	
        	if(Number(startHour) > Number(endHour)) {
        		alert("종료시간이 시작시간 보다 작습니다.!!!"); 
        		return;
        	}
        	else if(Number(startHour) == Number(endHour)){
        		if(Number(startMinute) > Number(endMinute)){
        			alert("종료시간이 시작시간 보다 작습니다."); 
        			return;
        		}
        		else if(Number(startMinute) == Number(endMinute)){
        			alert("시작시간과 종료시간이 동일합니다."); 
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



<div class="content-body" style="width: 100%; margin: 0 auto;">

   <div class="container-fluid" style="padding-top: 10px;">
      <div class="card" id="card-title-1">
         <div class="card-header border-0 pb-0" style="display: flex; justify-content: center;">
            <h1 class="card-title" style="color:black;  font-weight: 900; font-size: 23px;">${requestScope.coures_name} 시험 출제</h1>
         </div>
         <div class="card-body" style="color: black; font-size: 18px;   padding: 0.75rem; ">
            <form name="exam" enctype="multipart/form-data">
               <div style="display: flex; justify-content: space-between; align-items: flex-start;">
	               <div class="noti-wrap">
	                  <span style="padding-bottom: 8px; color: #175F30; font-weight: bold;">[출제자 유의사항]</span><br>
	                  <span style="color: #175F30; font-weight: bold;">▶ 시험지 업로드는 PDF파일만 가능합니다.</span><br>
	                  <span style="color: #175F30; font-weight: bold;">▶ 문제 추가 시 꼭 답안을 작성한 후 출제하시기 바랍니다.</span>
	               </div>
	               <button type="button" id="ok" class="btn btn-success" style="width: 150px; height: 40px;">출제하기</button>
               </div>
               <hr>
               <div>
                  <div style="margin-bottom: 6px;"> 
                     <span style="margin-left: 41px;">> 시험구분</span>
                     <span style="margin-left: 68px;">> 시험일자</span>
                     <span style="margin-left: 88px;">> 시험 시작 시간</span>
                     <span style="margin-left: 98px;">> 시험 종료 시간</span>
                     <span style="margin-left: 105px;">> 시험지 변경</span>
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
                  <div style="padding-left: 20px; width: 50%;"> 
                     <button type="button" class="btn" id="addBtn" style="background-color: green; color: white; margin: 12px 0; padding: 8px 15px;">답안추가</button>
                     <button type="button" class="btn" id="delBtn" style="border: solid 1px green; color: green; margin: 12px 0; padding: 8px 15px; margin-left: 20px;">답안삭제</button>

                     <div id="answer-container">

							<div id="boxWrap">
							
		                             <div style="display: flex; align-items: center; margin-top: 20px;" class="aw-wrap">
		                                <input type="hidden" class="form-control aw"  value="1" name="questionNumber">
		                                <span style="width: 70px; text-align:center;">1번 답 :</span> <input type="text" class="form-control aw" style="width: 80px;" id="1answer" name="answer" value="${exam_info.answer}">
		                                <span style="width: 70px; text-align:center;">배점 :</span> <input type="text" class="form-control aw ts-scr"  style="width: 80px;" id="1score" name="score" value="${exam_info.score}" placeholder="숫자만 입력">
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
