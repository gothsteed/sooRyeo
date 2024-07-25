<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
	LocalDateTime currentTime = LocalDateTime.now();
%>

<style type="text/css">
	td#title:hover {
		background-color: #e9ecef; /* Hover state for table rows */
		cursor: pointer; /* Indicate row is clickable */
	}
</style>

<script type="text/javascript">
	$(document).ready(function() {}); // end of $(document).ready(function(){})

	function goview(schedule_seq) {
		location.href = "<%=ctxPath%>/professor/exam/result.lms?schedule_seq=" + schedule_seq;
	}
</script>

<h3 class="mt-3 mb-3" style="margin-left:10%;"><img src="<%=ctxPath%>/resources/images/assignment.png" style="width:3%; margin-right:2%;">시험</h3>
<hr style="width:80%;">
<table class="table" style="width:80%; margin-left:10%;">
	<thead>
	<tr class="row table-success">
		<th scope="col" class="col-1" style="text-align: center">글번호</th>
		<th scope="col" class="col-3" style="text-align: center">시험 제목</th>
		<th scope="col" class="col-3" style="text-align: center">날짜</th>
		<th scope="col" class="col-3" style="text-align: center">시간</th>
		<th scope="col" class="col-2" style="text-align: center">진행여부</th>
	</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${not empty requestScope.examList}">
			<c:forEach var="exam" items="${requestScope.examList}" varStatus="status">
				<tr class="row" onclick="goview('${exam.fk_schedule_seq}')">
					<th scope="row" class="col-1" style="text-align: center">${status.count}</th>
					<td class="col-3" id="title" style="text-align: center">${exam.schedule.title}</td>
					<td class="col-3" style="text-align: center">${exam.startDate}</td>
					<td class="col-3" style="text-align: center">${exam.durationInMinute}분</td>
					<td class="col-2" style="text-align: center">
						<c:if test="${exam.schedule.isBefore(currentTime)}">
							진행전
						</c:if>
						<c:if test="${exam.schedule.isBetweenSchedule(currentTime)}">
							진행중
						</c:if>
						<c:if test="${exam.schedule.isAfter(currentTime)}">
							완료
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr class="row">
				<td colspan="5" style="text-align: center; font-size: 16pt;">시험이 존재하지 않습니다</td>
			</tr>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>
<div class="pagination justify-content-center">${requestScope.pageBar}</div>
