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

<title>SooRyeo Univ.</title>


<style>


  

li.list-group-item {
	height: 100px;
}

video {
  margin-top: 20px;
  margin-left: 20px;
  z-index: 150
}

</style>


<script type="text/javascript">

	
	$(document).ready(function() {
		  
		  const pageLoadTime = new Date();

		  $("button#end").click(function() {
		    // Calculate the time spent on the page
		    const minutes = calculateTimeSpent(pageLoadTime);
		    
		    const lecture_seq = $("input#lecture_seq").val();
		    
		    const formData = new FormData();

	        formData.append('play_time', minutes);
	        formData.append('lecture_seq', lecture_seq);
	        
	        $.ajax({
	     		url:"<%= ctxPath%>/student/classPlay_time.lms",
	     		method : "POST",
	     		data: formData,
	     		dataType:'json',
				contentType: false,	
				processData: false,  
	     		success: function(json) {
	     			
					if( json.n1 == 1) {
						alert("동영상 재생 시간이 저장되었습니다.");
						window.history.back();
						return;
					}
					
					if( json.n4 == 1) { 
						alert("출석이 완료되었습니다.");
						location.href="<%= ctxPath%>/student/myLecture.lms?course_seq="+ ${requestScope.course_seq};
						/* window.history.back(); */
						return;
					}
				
	     		},
		        error: function(xhr, status, error) {
					alert("동영상 재생 시간 저장 실패!");
	       		}
	     		
	     	});

		    
		  });

		  // Attach the function to the beforeunload event
		  window.addEventListener('beforeunload', function() {
		    const secondsSpent = calculateTimeSpent(pageLoadTime);
		    console.log(`Time spent on page: ${secondsSpent} seconds`);
		  });
	});

	//Function to calculate time spent
	function calculateTimeSpent(pageLoadTime) {
	  const pageLeaveTime = new Date();
	  const timeSpent = pageLeaveTime - pageLoadTime; 
	  const totalSeconds = Math.round(timeSpent / 1000);
	  const minutes = Math.floor(totalSeconds / 30);
	  return minutes;
	}

</script>

<div>

	
		
     <div style="display: flex; width: 90%; height: 525pt; margin: 2% auto;">
     
        <div class="shadow p-3 mb-5 bg-body rounded" style="width : 80%; height: 520pt; background-color: white;">
        
           <input type="hidden" id="lecture_seq" value="${requestScope.lecture_seq}"/>
           <div style="display: flex; justify-content: space-between;">
           		<div style="height: 50px; margin-left: 7%; margin-top: 3%; font-size: 20pt;">${requestScope.classOne.lecture_title}</div>
           		<button type="button" class="btn btn-success" id="end" style="height: 40px; margin-top: 3%; margin-right: 7%;">출석 종료</button>
           </div>
           
           <video id="video-player" src="${pageContext.request.contextPath}/resources/lectures/${requestScope.classOne.upload_video_file_name}" controls width="1060" height="530"></video>
		
        </div>
        <div class="shadow ml-5 mb-5 bg-body rounded" style="width : 20%; height: 520pt; padding: 2%; background-color: white;">
           ${requestScope.classOne.lecture_content}
        </div>
        
     </div>
		
	
</div>