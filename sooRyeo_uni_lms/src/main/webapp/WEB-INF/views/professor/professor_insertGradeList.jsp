<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


.btn-modern {
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	font-weight: 500;
	transition: all 0.3s ease;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.btn-edit {
	background-color: #3498db;
	color: white;
}

.btn-edit:hover {
	background-color: #2980b9;
}

.btn-delete {
	background-color: #e74c3c;
	color: white;
}

.btn-delete:hover {
	background-color: #c0392b;
}

.btn-modern:active {
	transform: translateY(1px);
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}



</style>

<script type="text/javascript">

$(document).ready(function(){
	
		



	
});// end of $(document).ready(function() 

function scrollToTarget_up() {
	
    var target = document.getElementById('target');
    target.scrollIntoView({ behavior: 'smooth' });
    
}// end of function scrollToTarget_up() 


function scrollToTarget_down() {
	
    var target = document.getElementById('target2');
    target2.scrollIntoView({ behavior: 'smooth' });
    
}// end of function scrollToTarget_down() 

// Function Declaration ////////////////////	
	
	function goInsertGrade(student_id, name){
		
		// console.log(student_id);
		
		location.href = "<%=ctxPath%>/professor/insertGradeDetail.lms?course_seq="+${requestScope.fk_course_seq}+"&student_id="+student_id+"&name="+name;
	
		
		
	}// end of function goAssignment()




</script>

<div class="container mt-5">
<h3>수강 학생 목록</h3>
<hr>
	<div class="card-body" style="">	
		<div class="table-container mt-3">
			<table class="table table-hover">
				<thead>
					<tr class="table-success">
						<th>학번</th>
						<th>이름</th>
						<th>학년</th>
						<th>학과</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty requestScope.studentList}">
					<c:forEach var="student" items="${requestScope.studentList}" varStatus="status">
					<tr style="cursor:pointer;" onclick="goInsertGrade('${student.student_id}', '${student.name}')">
						<td>${student.student_id}</td>
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
			<div class="pagination justify-content-center">${requestScope.pageBar}</div>
		</div>
	</div>
</div>

<div class="btns" style="display:inline;">
  	<div class="moveTopBtn" onclick="scrollToTarget_up()"><img src="<%=ctxPath%>/resources/images/btn_up_light.png"></div>
  	<div class="moveDownBtn" onclick="scrollToTarget_down()"><img src="<%=ctxPath%>/resources/images/btn_down_light.png"></div>
</div>

<form name="insertGradeFrm">
<input type="hidden" name="course_seq" value=""/>
<input type="hidden" name="student_id" value=""/>
</form>
