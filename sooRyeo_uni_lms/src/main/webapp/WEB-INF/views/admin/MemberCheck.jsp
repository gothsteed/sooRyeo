<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<script type="text/javascript">


</script>

</head>
<body>
<table class="table table-success table-striped-columns" id="student">
  <th>학번</th>
  <th>학년</th>
  <th>이름</th>
  <th>학과</th>
  <th>학적</th>
  <th>신청</th>
  <th>승인 여부</th>
  
  <c:if test="${requestScope.application_status_student != '[]'}">
	  <c:forEach var="student" items="${requestScope.application_status_student}" varStatus="status" >    
		  <tr>
		  	<td>
		  		${student.student_id}
		  	</td>
		  	<td>
		  		${student.grade}
		  	</td>
		  	<td>
		  		${student.name}
		  	</td>
		  	<td>
		  		${student.department_name}
		  	</td>
		  	<td>
	  		  	<c:if test="${student.status == 1}">재학</c:if>
			  	<c:if test="${student.status == 2}">휴학</c:if>
			  	<c:if test="${student.status == 3}">졸업</c:if>
			  	<c:if test="${student.status == 4}">자퇴</c:if>
		  	</td>
		  	<td>
		  	  	<c:if test="${student.change_status == 1}">복학 신청</c:if>
			  	<c:if test="${student.change_status == 2}">휴학 신청</c:if>
			  	<c:if test="${student.change_status == 3}">졸업 신청</c:if>
			  	<c:if test="${student.change_status == 4}">자퇴 신청</c:if>
		  	</td>
	  	 	<td>
		  		<button type="button" class="btn btn-primary btn-sm"  onclick="location.href='${pageContext.request.contextPath}/admin/admitOrRefuse.lms?student_id=${student.student_id}&change_status=${student.change_status}&no=1'">승인</button>
		  		<button type="button" class="btn btn-primary btn-sm"  onclick="location.href='${pageContext.request.contextPath}/admin/admitOrRefuse.lms?student_id=${student.student_id}&change_status=${student.change_status}&no=2'">반려</button>
		  	</td>
		  </tr>
	  </c:forEach>
  </c:if>
</table>
<c:if test="${requestScope.application_status_student == '[]'}">
	<div style="text-align: center; font-size: 20pt">현재 학적 변경을 신청한 학생이 없습니다.</div>
</c:if>

</body>
</html>