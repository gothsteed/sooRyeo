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
    <div id='calendar'></div>
    
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
                        <label for="taskId" class="col-form-label">시작 시간</label>
                        <input type="date" class="form-control" id="calendar_date_time" name="calendar_start_time">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="addCalendar">수정</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose">취소</button>
                </div>
    
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
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
                	
                	/*
                    let startStr = info.event.start.toLocaleString('ko-KR', {
                      year: 'numeric',
                      month: 'long',
                      day: 'numeric',
                      weekday: 'long',
                      hour: 'numeric',
                      minute: 'numeric'
                    });
                    
                    let endStr = info.event.end.toLocaleString('ko-KR', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                        weekday: 'long',
                        hour: 'numeric',
                        minute: 'numeric'
                      });
                    
                 	let date = startStr + "-" +endStr.substring(20);
                 	*/
                 	
                 	
                	
                 	$("input[name='calendar_title']").val(info.event.title);
	                $("input[name='calendar_content']").val(info.event.extendedProps.content);
	                var startDate = moment(info.event.start).format('YYYY-MM-DD');
	                // $('#eventStartDate').val(startDate);
	                $("input[name='calendar_start_time']").val(startDate);
	                $("input[name='calendar_end_time']").val(info.event.end);
	                
                	$("#calendarModal").modal("show");
                	
                }
                
            });
            calendar.render();
        });
        
        
        
    </script>
    
    
    
</body>

