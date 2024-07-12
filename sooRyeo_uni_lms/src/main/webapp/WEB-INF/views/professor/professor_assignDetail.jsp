<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">
   
   span.move  {cursor: pointer; color: navy;}
   .moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}

	td.comment {text-align: center;}

    a {text-decoration: none !important;}
    
</style>

<script type="text/javascript">
	
	function goEdit(schedule_seq_assignment){
		
		const goBackURL = "${requestScope.goBackURL}";
		
		const frm = document.reviseFrm;
		
		frm.schedule_seq_assignment.value = schedule_seq_assignment;
		frm.goBackURL.value = goBackURL;
		frm.method = "get";
		frm.enctype = "multipart/form-data";
		frm.action = "<%= ctxPath%>/professor/assignmentEdit.lms";
		frm.submit();
		
		
	}// end of function goEdit(schedule_seq_assignment)
	
	function goDelete(schedule_seq_assignment){
		
		const goBackURL = "${requestScope.goBackURL}";
		
		const frm = document.reviseFrm;
		
		frm.schedule_seq_assignment.value = schedule_seq_assignment;
		frm.goBackURL.value = goBackURL;
		frm.method = "post";
		frm.enctype = "multipart/form-data";
		frm.action = "<%= ctxPath%>/professor/assignmentDelete.lms";
		frm.submit();	
		
		
	}// end of function goDelete(schedule_seq_assignment) 


</script>

<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">
		<h2 style="margin-bottom: 30px;">글내용보기</h2>
		
		<c:if test="${not empty requestScope.assign_view}">
			<table class="table table-bordered table-dark" style="width: 1080px; word-wrap: break-word; table-layout: fixed;">
				<tr>
              		<th style="width: 15%">과제번호</th>
               		<td>${requestScope.assign_view.assignment.schedule_seq_assignment}</td>
           		</tr>   
         
           		<tr>
              		<th>제목</th>
               		<td>${requestScope.assign_view.schedule.title}</td>
           		</tr>
           		
           		<tr>
              		<th>내용</th>
              		<%-- 
                	style="word-break: break-all;" 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
                   	그런데 style="word-break: break-all; 나 style="word-wrap: break-word:; 은
                   	테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
                	<table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
            		--%>
               		<td><p style="word-break: break-all;">${requestScope.assign_view.assignment.content}</p></td>
           		</tr>
           		
           		<tr>
              		<th>시작날짜</th>
               		<td>${requestScope.assign_view.schedule.start_date}</td>
           		</tr>
           		
           		<tr>
              		<th>마감날짜</th>
               		<td>${requestScope.assign_view.schedule.end_date}</td>
           		</tr>
           		
           		<%-- === #182. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기  나중에 orifile로 바꿔줄것--%>
       		    <tr>
              		<th>첨부파일</th>
               		<td>
               			<c:if test="${requestScope.assign_view.assignment.attatched_file != '없음'}">
               				<a href="<%= ctxPath%>/download.lms?seq=${requestScope.assign_view.assignment.fk_course_seq}">${requestScope.assign_view.assignment.attatched_file}</a>
               			</c:if>
						<c:if test="${requestScope.assign_view.assignment.attatched_file == '없음'}">
               				${requestScope.assign_view.assignment.attatched_file}
               			</c:if>
               		</td>
           		</tr>          		
			</table>
		</c:if>
		
		<c:if test="${empty requestScope.assign_view}">
			<div style="padding: 20px 0; font-size: 16pt; color: red;" >존재하지 않습니다</div> 
		</c:if>
		<button type="button" class="btn btn-secondary mr-2" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'">목록으로 돌아가기</button>
		<button type="button" class="btn btn-secondary mr-2" onclick="goEdit('${requestScope.assign_view.assignment.schedule_seq_assignment}')">과제 수정</button>
		<button type="button" class="btn btn-secondary mr-2" onclick="goDelete('${requestScope.assign_view.assignment.schedule_seq_assignment}')">과제 삭제</button>
	</div>
</div>

<form name="reviseFrm">
	<input type="hidden" name="schedule_seq_assignment"/>
	<input type="hidden" name="goBackURL"/>
</form>