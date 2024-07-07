<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                        			
                        			events.push({
                        				
                                        id: item.schedule_seq,
                                        title: item.title,
                                        url: "<%= ctxPath%>/schedule/detailSchedule.lms?schedule_seq="+item.schedule_seq,
                                        start: start_date,
                                        end: end_date
                        				
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
                }
            });
            calendar.render();
        });
        
    </script>
</body>

