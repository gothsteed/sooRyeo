<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- jQueryUI CSS 및 JS --%>
<script type="text/javascript">
	$(document).ready(function(){
		$("table#professor").show();
		$("table#student").hide();

		// 교수나 학생 중 선택하여 조회
		$("select#selectTag").change(function(){
			
			if($(event.target).val() == '1'){
				$("select#selectTag").val("1");
				$("table#student").hide();
				$("table#professor").show();
			}
			
			if($(event.target).val() == '2'){
				$("select#selectTag").val("2");
				$("table#professor").hide();
				$("table#student").show();
			}
		});
	});
</script>

</head>
<body>

<!-- 
<div style="display: flex; justify-content: space-between;">
    <div>
        <button type="button" class="btn btn-primary">휴학처리</button>
        <button type="button" class="btn btn-primary">수정하기</button>
    </div>
    <div>
        <button type="button" class="btn btn-danger">삭제하기</button>
    </div>
</div>

<hr>
 -->
<select id="selectTag" name="searchType" style="margin-top:2%; margin-bottom: 3%; height:30px;">
	<option>선택하세요</option>
	<option value="1">교수</option>
	<option value="2">학생</option>
</select>

<br>

<table class="table table-striped-columns" id="student">
<tr class="table table-success">
  <th>학생 아이디</th>
  <th>이름</th>
  <th>이메일</th>
  <th>등록년도</th>
  <th>회원상태</th>
</tr>
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
	  		<c:if test="${student.status == 1}">재학</c:if>
		  	<c:if test="${student.status == 2}">휴학</c:if>
		  	<c:if test="${student.status == 3}">졸업</c:if>
		  	<c:if test="${student.status == 4}">자퇴</c:if>
	  	</td>
	  </tr>
  </c:forEach>
</table>

<table class="table table-striped-columns" id="professor">
<tr class="table table-success">
  <th>교수 아이디</th>
  <th>이름</th>
  <th>이메일</th>
  <th>등록일</th>
  <th>회원상태</th>
<tr>  
  <c:forEach var="professor" items="${requestScope.professorList}" varStatus="status" > 
	  <tr>
	  	<td>
	  		${professor.prof_id}
	  	</td>
	  	<td>
	  		${professor.name}
	  	</td>
	  	<td>
	  		${professor.email}
	  	</td>
	  	<td>
	  		<fmt:formatDate value="${professor.employment_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
	  	</td>
	  	<td>
	  		<c:if test="${professor.employment_stat == 1}">재직</c:if>
		  	<c:if test="${professor.employment_stat != 1}">퇴직</c:if>
	  	</td>
	  </tr>
  </c:forEach>
</table>

</body>
</html>