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
	
	th {background-color: #ddd}
	
    .table-hover tbody tr:hover {
        background-color: #f5f5f5;
    }


   .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */

</style>

<script type="text/javascript">
	
	$(document).ready(function(){	
		
		<%-- ============== ajax로 테이블 내용물 가져오기 시작 ============== --%>

		$.ajax({
			url:"<%= ctxPath%>/professor/assignmentJson.lms",
			data:{"course_seq":"${requestScope.fk_course_seq}"},  
			dataType:"json",
			success:function(json){
				console.log(JSON.stringify(json));
				
				let v_html = ``;
				
				json.forEach(function(item, index, array){
					
					v_html += `<tr>
			      				<td style="text-align: center;">\${item.row_num}</td> 
			      				<td style="text-align: center;">\${item.schedule_seq_assignment}</td> 
				            	<td><span class="subject" onclick="goView('\${item.schedule_seq_assignment}')">\${item.title}</span></td>
				            	<td style="text-align: center;">\${item.start_date}</td>
				            	<td style="text-align: center;">\${item.end_date}</td>
				            	<td style="text-align: center;">\${item.attatched_file}</td> 
		      				   </tr>`;
					
				});
				
				$("table#assignList tbody").html(v_html);
					
			},
		    error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   	}
				
		});		
		
		<%-- ============== ajax로 테이블 내용물 가져오기 끝 ============== --%>
		
		$("table#assignList").on("mouseenter", "span.subject", function(e) {
			$(e.target).addClass("subjectStyle");		
		});
		
		$("table#assignList").on("mouseleave", "span.subject", function(e) {
			$(e.target).removeClass("subjectStyle");
		});
		
		
		
	});// end of $(document).ready(function()
	
	function goView(schedule_seq_assignment){
		
		const goBackURL = "${requestScope.goBackURL}";
		const fk_course_seq = "${requestScope.fk_course_seq}";
		
		<%-- 
			아래처럼 get 방식으로 보내면 안된다. 왜냐하면 get방식에서 &는 전송될 데이터의 구분자로 사용되기 때문이다. 
			location.href=`<%= ctxPath%>/view.action?seq=\${seq}&goBackURL=\${goBackURL}`;
			
			그러므로 & 를 글자 그대로 인식하는 POST 방식으로 보내야 한다.
			아래 #132 에 표기된 form 태그를 먼저 만든다. --%>				
		
		const frm = document.goViewFrm;
		frm.course_seq.value = fk_course_seq;
		frm.goBackURL.value = goBackURL;
		frm.schedule_seq_assignment.value = schedule_seq_assignment; 
		
		frm.method = "post";
		frm.action = "<%= ctxPath%>/professor/assignmentDetail.lms";
		frm.submit();	
		
	}// end of function goView() 
	
	function goEnroll(){
		
		const goBackURL = "${requestScope.goBackURL}";
		const fk_course_seq = "${requestScope.fk_course_seq}";
		
		const frm = document.goViewFrm;
		frm.course_seq.value = fk_course_seq;
		frm.goBackURL.value = goBackURL;
		
		frm.method = "get";
		frm.action = "<%= ctxPath %>/professor/assign_enroll.lms";
		frm.submit();
		
		
	}
	

</script>

<div class="container mt-5">
<h3>과제 관리 목록</h3>
<hr>
	<div class="card-body" style="">
		<div class="table-container mt-3">
			<table class="table table-hover table-bordered" id="assignList">
				<thead>
					<tr>
						<th style="text-align: center;">글번호</th>
						<th style="text-align: center;">과제번호</th>
						<th style="text-align: center;">제목</th>
						<th style="text-align: center;">시작일자</th>
						<th style="text-align: center;">마감일자</th>
						<th style="text-align: center;">첨부파일</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<%-- 페이징처리 할 부분 --%>
		<button type="button" class="btn btn-secondary" onclick="goEnroll()">과제 등록</button>
	</div>
</div>


<form name="goViewFrm">
	<input type="hidden" name="course_seq"/>
	<input type="hidden" name="goBackURL"/>
	<input type="hidden" name="schedule_seq_assignment"/>
</form>