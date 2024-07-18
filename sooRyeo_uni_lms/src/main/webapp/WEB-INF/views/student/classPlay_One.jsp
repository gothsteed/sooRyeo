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
		  // Record the time when the page is loaded
		  const pageLoadTime = new Date();

		  $("button#end").click(function() {
		    // Calculate the time spent on the page
		    const secondsSpent = calculateTimeSpent(pageLoadTime);
		    // alert(`\${secondsSpent}`);
		    
	        $.ajax({
	     		url:"<%= ctxPath%>/student/insert_schedule_consult.lms",
	     		method : "POST",
	     		data: formData,
	     		dataType:'json',
				contentType: false,	
				processData: false,  
	     		success: function(json) {
	     		
					if( json.result == 1) {
						$('#ConsultingModal').modal('hide');
						alert("상담 신청 성공!");
						return;
					}
	     			
	     		},
		        error: function(xhr, status, error) {
					alert("상담 신청 실패!");
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
	  const secondsSpent = Math.round(timeSpent / 1000); 
	  return secondsSpent;
	}

</script>

<div>

	
		
     <div style="display: flex; width: 90%; height: 525pt; margin: 2% auto;">
        <div class="shadow p-3 mb-5 bg-body rounded" style="width : 80%; height: 520pt; background-color: white;">
        
           <div style="display: flex; justify-content: space-between;">
           		<div style="height: 50px; margin-left: 7%; margin-top: 3%; font-size: 20pt;">${classOne.lecture_title}</div>
           		<button type="button" class="btn btn-success" id="end" style="height: 40px; margin-top: 3%; margin-right: 7%;">출석 종료</button>
           </div>
           
           <video id="video-player" src="${pageContext.request.contextPath}/resources/lectures/big_buck_bunny_720p_10mb.mp4" controls width="1060" height="530"></video>
		
        </div>
        <div class="shadow ml-5 mb-5 bg-body rounded" style="width : 20%; height: 520pt; padding: 2%; background-color: white;">
           ${classOne.lecture_content}
        </div>
        
     </div>
		
	
</div>