<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- jQueryUI CSS 및 JS --%>

</head>
<body>
<table class="table table-success table-striped-columns" id="student">
  <th>학생 아이디</th>
  <th>이름</th>
  <th>이메일</th>
  <th>등록일</th>
  <th>회원상태</th>
  
  <c:forEach var="student" items="${requestScope.studentList}" varStatus="status" >    
	  <tr>
	  	<td>
	  		${student.student_id}
	  	</td>
	  	<td>
	  		${student.name}
	  	</td>
	  	<td>
	  		${student.email}
	  	</td>
	  	<td>
	  		${student.register_year}
	  	</td>
	  	<td>
	  		${student.status}
	  	</td>
	  </tr>
  </c:forEach>  
</table>

</body>
</html>