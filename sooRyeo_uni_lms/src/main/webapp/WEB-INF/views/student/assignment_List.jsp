<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>


<style type="text/css">

tr.row:hover {
	background-color: #e9ecef; /* Hover state for table rows */
	cursor: pointer; /* Indicate row is clickable */
}

</style>



<script type="text/javascript">

$(document).ready(function(){
	
	$("tr.row").click(function(e){
		
		// alert($(this).find("input[name='schedule_seq_assignment']").val());
		
		location.href = "<%=ctxPath%>/student/assignment_detail_List.lms?schedule_seq_assignment="+$(this).find("input[name='schedule_seq_assignment']").val();
		
	}); // end of $("div.border").click(function(e){})
	
}); // end of $(document).ready(function(){})

</script>  




<h3 class="mt-3 mb-3" style="margin-left:10%;"><img src="<%=ctxPath%>/resources/images/assignment.png" style="width:3%; margin-right:2%;">과제</h3>
<hr>
<table class="table" style="width: 80%; margin: 3% auto;">
  <thead> 
    <tr class="row table-success">
      <th scope="col" class="col-2">글번호</th>
      <th scope="col" class="col-4">과제 제목</th>
      <th scope="col" class="col-2" style="text-align: center">시작일자</th>
      <th scope="col" class="col-2" style="text-align: center">마감일자</th>
      <th scope="col" class="col-2" style="text-align: center">과제제출시간</th>
    </tr>
  </thead>
  <tbody>
    <tr class="row">
	    <c:forEach var="assignment_List" items="${requestScope.assignment_List}" varStatus="status">
		    <c:if test="${assignment_List.assignment_submit_seq == null}">
			      <th scope="row" class="col-2">&nbsp;&nbsp;&nbsp;${status.count}</th>
				      <td class="col-4">${assignment_List.title}</td>
				      <td class="col-2" style="text-align: center"><fmt:formatDate value="${assignment_List.start_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
				      <td class="col-2" style="text-align: center"><fmt:formatDate value="${assignment_List.end_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
				      <td class="col-2" style="text-align: center"><fmt:formatDate value="${assignment_List.submit_datetime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
				      <input type="hidden" name="schedule_seq_assignment" value="${assignment_List.schedule_seq_assignment}"/>
				      <input type="hidden" name="course_seq" value="${assignment_List.fk_course_seq}"/>
			</c:if>
			<c:if test="${assignment_List.assignment_submit_seq != null}">
				 <div style="padding: 20px 0; font-size: 16pt; color: red;" >제출할 과제가 존재하지 않습니다</div> 
			</c:if>
	    </c:forEach>
    </tr>
  </tbody>
</table>







