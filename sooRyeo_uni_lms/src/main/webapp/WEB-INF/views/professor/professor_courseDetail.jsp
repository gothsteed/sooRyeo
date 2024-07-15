<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
   String ctxPath = request.getContextPath();
%>     

<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>



<style type="text/css">

.btns {
  display: flex;
  position: fixed;
  right: 150px;
  bottom: 200px;
}

.table-container {
    max-height: 300px; 
    overflow-y: auto; 
}

.table-hover tbody tr:hover {
    background-color: #f5f5f5; 
}




</style>

<script type="text/javascript">

$(document).ready(function(){
	
		



	
});// end of $(document).ready(function() 

function goLectureNotice(){
	
	location.href = "<%=ctxPath%>/board/lecture_notice.lms?fk_course_seq="+${requestScope.fk_course_seq};
	
}


function scrollToTarget_up() {
	
    var target = document.getElementById('target');
    target.scrollIntoView({ behavior: 'smooth' });
    
}// end of function scrollToTarget_up() 


function scrollToTarget_down() {
	
    var target = document.getElementById('target2');
    target2.scrollIntoView({ behavior: 'smooth' });
    
}// end of function scrollToTarget_down() 

// Function Declaration ////////////////////

	function goTest(){
		
		
	}// end of function goAnnouncement() 
	
	
	function goAssignment(){
		
		location.href = "<%=ctxPath%>/professor/assignment.lms?course_seq="+${fk_course_seq}; // 페이지 이동
		
	}// end of function goAssignment() 



</script>

<div class="container mt-5">
<h3>강의 개요</h3>
<input type="hidden" name="course_seq" value=""/>
<hr>
	<div class="card-body" style="">
		<button type="button" class="btn btn-outline-light" style="width:20%; height:150px;" onclick="goLectureNotice()">
			<img src="<%=ctxPath%>/resources/images/annoucement.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="annoucement" style="color:black; font-weight: bold;">공지사항</span>
			<br>
		</button> 	
		<button type="button" class="btn btn-outline-light ml-5" id="announcement" style="width:20%; height:150px;" onclick="goTest()">
			<img src="<%=ctxPath%>/resources/images/test.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="annoucement" style="color:black; font-weight: bold;">시험</span>
			<br>
		</button> 	
		<button type="button" class="btn btn-outline-light ml-5" id="assignment" style="width:20%; height:150px;" onclick="goAssignment()">
			<img src="<%=ctxPath%>/resources/images/tasks.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="tasks" style="color:black; font-weight: bold;">과제</span>
			<br>
		</button>
		<div class="table-container mt-3">
			<table class="table table-hover">
				<thead>
					<tr class="table-success">
						<th>이름</th>
						<th>학년</th>
						<th>학과</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty requestScope.studentList}">
					<c:forEach var="student" items="${requestScope.studentList}" varStatus="status">
					<tr>
						<td>${student.name}</td>
						<td>${student.grade}</td>
						<td>${student.department_name}</td>
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty requestScope.studentList}">
					<tr>
						<td colspan="3">수강생이 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="btns" style="display:inline;">
  	<div class="moveTopBtn" onclick="scrollToTarget_up()"><img src="<%=ctxPath%>/resources/images/btn_up_light.png"></div>
  	<div class="moveDownBtn" onclick="scrollToTarget_down()"><img src="<%=ctxPath%>/resources/images/btn_down_light.png"></div>
</div>

