<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>


<style type="text/css">

td#title:hover {
	background-color: #e9ecef; /* Hover state for table rows */
	cursor: pointer; /* Indicate row is clickable */
}

</style>



<script type="text/javascript">


$(document).ready(function(){
	
	
}); // end of $(document).ready(function(){})



function goview(schedule_seq_assignment){
	
	// alert(schedule_seq_assignment);
	
	location.href = "<%=ctxPath%>/student/assignment_detail_List.lms?schedule_seq_assignment="+schedule_seq_assignment;
	
}


</script>  




<h3 class="mt-3 mb-3" style="margin-left:10%;"><img src="<%=ctxPath%>/resources/images/assignment.png" style="width:3%; margin-right:2%;">과제</h3>
<hr style="width:80%;">
<table class="table" style="width:80%; margin-left:10%;">
  	<thead> 
    	<tr class="row table-success">
	      <th scope="col" class="col-2">글번호</th>
	      <th scope="col" class="col-4">시험 제목</th>
	      <th scope="col" class="col-2" style="text-align: center">시작일자</th>
	      <th scope="col" class="col-2" style="text-align: center ">마감일자</th>
    	</tr>
  	</thead>
  	<tbody>
		<c:forEach var="assignment_List" items="${requestScope.examList}" varStatus="status">
	   		<tr class="row">
			    <c:if test="${assignment_List.assignment_submit_seq == null}">
				      <th scope="row" class="col-2">&nbsp;&nbsp;&nbsp;${status.count}</th>
					  <td class="col-4" id="title" onclick="goview('${assignment_List.schedule_seq_assignment}')">${assignment_List.title}</td>
				      <td class="col-2" style="text-align: center"><fmt:formatDate value="${assignment_List.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				      <td class="col-2" style="text-align: center; color: red;"><fmt:formatDate value="${assignment_List.end_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				      <td class="col-2" style="text-align: center; color: blue;"><fmt:formatDate value="${assignment_List.submit_datetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					  <input type="hidden" name="schedule_seq_assignment"  style="margin-left:5%;" value="${assignment_List.schedule_seq_assignment}"/>
					  <input type="hidden" name="course_seq" style="margin-left:5%;" value="${assignment_List.fk_course_seq}"/>
				</c:if>
				<c:if test="${assignment_List.assignment_submit_seq != null}">
					 <div style="font-size: 16pt; color: red;" >제출할 과제가 존재하지 않습니다</div> 
				</c:if>
	    	</tr>
	    </c:forEach>

		<c:if test="${not empty requestScope.examList}">
			<c:forEach var="exam" items="${requestScope.examList}" varStatus="status">
				<th scope="row" class="col-2">&nbsp;&nbsp;&nbsp;${status.count}</th>
				<td class="col-4" id="title" onclick="goview('${exam.fk_schedule_seq}')">${exam.schedule.title}</td>
				<td class="col-2" style="text-align: center"><fmt:formatDate value="${exam.schedule.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td class="col-2" style="text-align: center; color: red;"><fmt:formatDate value="${exam.schedule.end_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>

			</c:forEach>

			<ul class="pagination">
				${requestScope.pageBar}
			</ul>
		</c:if>
		<c:if test="${empty requestScope.examList}">
			<div style="font-size: 16pt; color: red;" >시험이 존재하지 않습니다</div>
		</c:if>


  	</tbody>
</table>







