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

.table-hover tbody tr:hover {
    background-color: #f5f5f5; 
}


</style>

<script type="text/javascript">

	$.ajax({
		url:"<%= ctxPath%>/professor/paperAssignmentJson.lms",
		data:{"course_seq":"${requestScope.fk_course_seq}"},  
		dataType:"json",
		success:function(json){
			console.log(JSON.stringify(json));
				
		},
	    error: function(request, status, error){
	        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	   	}
			
	});		



</script>

<div class="container mt-5">
<h3>과제 관리</h3>
<hr>
	<div class="card-body" style="">
		<div class="table-container mt-3">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>시작일자</th>
						<th>마감일자</th>
						<th>첨부파일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>