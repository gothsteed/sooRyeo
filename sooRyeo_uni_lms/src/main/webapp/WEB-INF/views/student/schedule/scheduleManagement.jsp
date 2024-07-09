<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
 	String ctxPath = request.getContextPath();
	//     /sooRyeo
%>

<link href='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />

<style type="text/css">

div#wrapper1{
	float: left; display: inline-block; width: 20%; margin-top:250px; font-size: 13pt;
}

div#wrapper2{
	display: inline-block; width: 80%; padding-left: 20px;
}

/* ========== full calendar css 시작 ========== */
.fc-header-toolbar {
	height: 30px;
}

a, a:hover, .fc-daygrid {
    color: #000;
    text-decoration: none;
    background-color: transparent;
    cursor: pointer;
} 

.fc-sat { color: #0000FF; }    /* 토요일 */
.fc-sun { color: #FF0000; }    /* 일요일 */
/* ========== full calendar css 끝 ========== */

ul{
	list-style: none;
}

button.btn_normal{
	background-color: #990000;
	border: none;
	color: white;
	width: 50px;
	height: 30px;
	font-size: 12pt;
	padding: 3px 0px;
	border-radius: 10%;
}

button.btn_edit{
	border: none;
	background-color: #fff;
}
</style>


<!-- full calendar에 관련된 script -->
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<body>
    <div id='calendar' style="margin: 0 auto; width : 90%; height : 800px;"></div>
    
    <!-- Edit Modal -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">내 개인 일정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                    	<label for="taskId" class="col-form-label">일정 제목</label>
                        <input type="text" class="form-control" id="calendar_title" name="calendar_title">
                        <label for="taskId" class="col-form-label">일정 내용</label>
                        <input type="text" class="form-control" id="calendar_content" name="calendar_content">
                        
                        <label for="taskId" class="col-form-label">시작 일자</label>
                        <br>
						<input type="date" id="calendar_start_time" name="calendar_start_time"/>&nbsp; 
						<select id="startHour" class="form-select"></select> 시
						<select id="startMinute" class="form-select"></select> 분
						
						<br>
						<label for="taskId" class="col-form-label">종료 일자</label>
						<br>
						<input type="date" id="calendar_end_time" name="calendar_end_time"/>&nbsp;
						<select id="endHour" class="schedule"></select> 시
						<select id="endMinute" class="schedule"></select> 분&nbsp;
						<input type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
						
						<input type="hidden" name="startdate"/>
						<input type="hidden" name="enddate"/>
						<input type="hidden" name="schedule_seq"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="EditCalendar">수정</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose">삭제</button>
                </div>
    
            </div>
        </div>
    </div>

    <script>
    
    	makeSchedule();
    
    	function makeSchedule() {
    		
	        document.addEventListener('DOMContentLoaded', function() {
	            var calendarEl = document.getElementById('calendar');
	            var calendar = new FullCalendar.Calendar(calendarEl, {
	            headerToolbar: {
	      	    	  left: 'prev,next today',
	      	          center: 'title',
	      	          right: 'dayGridMonth dayGridWeek dayGridDay'
	      	    },
	            	initialView: 'dayGridMonth',
	                locale: 'ko',
	                events:function(info, successCallback, failureCallback) {
	                    $.ajax({
	                        url: '<%= ctxPath%>/api/schedules',
	                        method: 'GET',
	                        dataType: 'json',
	                        success: function(json) {
	                        	
	                        	var events = []
	                        	if(json.length > 0 ) {
	                        	
	                        		$.each(json, function(index, item) {
	                        			
	                        			var start_date = moment(item.start_date).format('YYYY-MM-DD HH:mm:ss');
	                        			var end_date = moment(item.end_date).format('YYYY-MM-DD HH:mm:ss');
	                        			var color = "";
	                        			var url = "";
	                        			
	                        			if(item.schedule_type == '1') {
	                        				color = "#175F30";
	                        				url = "<%= ctxPath%>/student/myLecture.lms?course_seq="+item.course_seq	
	                        			}
	                        			if(item.schedule_type == '2') {
	                        				color = "#A0D468";
	                        				url = "<%= ctxPath%>/student/myLecture.lms?course_seq="+item.course_seq
	                        			}
	                        			if(item.schedule_type == '3') {
	                        				color = "#FFD400";                        
	                        			}
	                        			
	                        			events.push({
	                        				
	                                        id: item.schedule_seq,
	                                        title: item.title,
	                                        url: url,
	                                        start: start_date,
	                                        end: end_date,
	                                        color: color,
	                                        content: item.content
	                        				
	                        			});
	                        			
	                        		});
	                        			
	                        	}// end of if
	                        	console.log(events);
	                            successCallback(events);
	                        },// end of success
	                        error: function() {
	                            failureCallback();
	                        }
	                    });
	                },
	                eventClick: function(info) {
	                	
	                	
	                 	$("input[name='calendar_title']").val(info.event.title);
		                $("input[name='calendar_content']").val(info.event.extendedProps.content);
		                $("input[name='schedule_seq']").val(info.event.id);
	
		                var startD = moment(info.event.start).format('YYYY-MM-DD');
		                var startD2 = moment(info.event.start).format('YYYY-MM-DD HH:mm:ss');
	
		                var endD = moment(info.event.end).format('YYYY-MM-DD');
		                var endD2 = moment(info.event.end).format('YYYY-MM-DD HH:mm:ss');
		                
		                
		                $("input[name='calendar_start_time']").val(startD);
		                $("input[name='calendar_end_time']").val(endD);
	
		                
		                var starthour = startD2.substring(11,13);
		                var startmin = startD2.substring(14,16);
		                var endhour = endD2.substring(11,13);
		                var endmin = endD2.substring(14,16);
		                
		                $("select#startHour").val(starthour);
		                $("select#startMinute").val(startmin);
		                $("select#endHour").val(endhour);
		                $("select#endMinute").val(endmin);
		                
	                	$("#calendarModal").modal("show");
	                	
	                }
	                
	            });
	            calendar.render();
	        });
        
    	};
        
        
		// 시작시간, 종료시간		
		var html="";
		for(var i=0; i<24; i++){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else{
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
		// === *** 시작시간 시 분 넣어주기 *** === //
		$("select#startHour").val(startHour);
		$("select#endHour").val(endHour);
		
        
		// 시작분, 종료분 
		html="";
		for(var i=0; i<60; i=i+5){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else {
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for--------------------
		html+="<option value="+59+">"+59+"</option>"
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		
		$("select#startMinute").val(startMinute);
		$("select#endMinute").val(endMinute);
		
		
		$("select").change(function(){

			if($("select#startHour").val()=='00' && $("select#startMinute").val()=='00' &&
					   $("select#endHour").val()=='23' && $("select#endMinute").val()=='59' ){
						$("input#allDay").prop("checked",true);
						$("select#startHour").prop("disabled",true);
						$("select#startMinute").prop("disabled",true);
						$("select#endHour").prop("disabled",true);
						$("select#endMinute").prop("disabled",true);
			}
			else{
				$("input#allDay").prop("checked",false);
			}
			
		});
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("59");
				$("select#startHour").prop("disabled",true);
				$("select#startMinute").prop("disabled",true);
				$("select#endHour").prop("disabled",true);
				$("select#endMinute").prop("disabled",true);
			} 
			else {
				$("select#startHour").prop("disabled",false);
				$("select#startMinute").prop("disabled",false);
				$("select#endHour").prop("disabled",false);
				$("select#endMinute").prop("disabled",false);
			}
		});

		// 수정버튼 클릭했을 시
		$("button#EditCalendar").click(function() {
			
			// 스케줄시퀀스 가져오기
			var schedule_seq = $("input[name='schedule_seq']").val();
			
			// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
			var startDate = $("input#calendar_start_time").val();	
	    	var sArr = startDate.split("-");
	    	startDate= "";	
	    	for(var i=0; i<sArr.length; i++){
	    		startDate += sArr[i];
	    	}
	    	
	    	var endDate = $("input#calendar_end_time").val();	
	    	var eArr = endDate.split("-");   
	     	var endDate= "";
	     	for(var i=0; i<eArr.length; i++){
	     		endDate += eArr[i];
	     	}
	     	
	     	var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	        
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
			
	        
			// 일정 제목 유효성 검사
			var title = $("input#calendar_title").val().trim();
	        if(title=="") {
				alert("일정 제목을 입력하세요."); 
				return;
			}
	        
			var content = $("input#calendar_content").val().trim();
	        if(content=="") {
				alert("일정 내용을 입력하세요."); 
				return;
			}
	        
			// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
			
			//alert(title);
			//alert(content);
			//alert(sdate);
			//alert(edate);
			
		 	const formData = new FormData();

            formData.append('schedule_seq', schedule_seq);
            formData.append('title', title);
            formData.append('content', content);
            formData.append('start_date', sdate);
            formData.append('end_date', edate);
			
			
			$.ajax({
				url: '<%=ctxPath%>/schedule/updateSchedule.lms',
				method : 'POST',
				data : formData,
				dataType:'json',
				contentType: false,
				processData: false,
				success: function(json){
					
					if( json.result != 1) {
						alert("수정 실패!");
						return;
					}
					if( json.result == 1) {
						$('#calendarModal').modal('hide');
						alert("수정 성공!");
						location.href="javascript:history.go(0)";
						return;
					}
					
				},
		        error: function(xhr, status, error) {
		            console.error('Error:', error);
		        }

			});
			
		});
		
    </script>
    
    
    
</body>

