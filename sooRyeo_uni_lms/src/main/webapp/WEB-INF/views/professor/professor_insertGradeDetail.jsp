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

	$(document).ready(function(){
		
		<%-- ============== ajax로 테이블 내용물 가져오기 시작 ============== --%>

		$.ajax({
			url:"<%= ctxPath%>/professor/score_checkJSON.lms",
			method: "POST",
			data:{"student_id":"${requestScope.student_id}",
				  "fk_course_seq":"${requestScope.fk_course_seq}"},
			dataType:"json",
			
			success:function(json){			
				console.log(JSON.stringify(json));
				
				let v_html = ``;
				
				v_html += `<tr>
			      			<td style="text-align: center; vertical-align: middle;">\${json.name}</td> 
			      			<td style="text-align: center; vertical-align: middle;">\${json.student_id}</td> 
			      			<td style="text-align: center; vertical-align: middle;">\${json.assignmentScore}</td>
			      			<td style="text-align: center; vertical-align: middle;"></td>
				            <td style="text-align: center; vertical-align: middle;"></td>
				            <td style="text-align: center; vertical-align: middle;"></td>
				            <td style="text-align: center; vertical-align: middle;"></td>`;
				
				v_html += `<input type='text' id="score" style="width: 50%"/>
			            	<button type='button' class='btn btn-secondary mt-1' onclick='insertGrade("\${json.student_id}")'>성적입력</button>`;
					
				v_html += `</tr>`;
					
				$("table#assignCheck tbody").html(v_html);
					
			},
		    error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   	}
				
		});		
		
		<%-- ============== ajax로 테이블 내용물 가져오기 끝 ============== --%>
		
		
		
		
		
	});// end of $(document).ready(function() 

	////////////////////////////////////////////////
	// Function Declaration
				
<%-- 	function insertGrade(assignment_submit_seq){
		
		const goBackURL = "${requestScope.goBackURL}";
		const score = $("input#score").val().trim();
		const frm = document.reviseFrm;
		
		if(confirm("점수를 입력하시겠습니까?")){
		
		
			if(score == 0){
				alert("점수를 입력해주세요.");
				return;
			}
			else if(score > 100){
				alert("점수는 최대 100점까지 입력해주세요.");
				return;
				
			}
			else if(score < 0){
				alert("점수는 0 미만으로 입력할 수 없습니다.");
				return;
			}
			else{
				frm.assignment_submit_seq.value = assignment_submit_seq;
				frm.score.value = score;
				frm.goBackURL.value = goBackURL;
				frm.method = "post";
				frm.action = "<%= ctxPath%>/professor/scoreUpdate.lms";
				frm.submit();
				
			}
		} else{
			alert("취소를 누르셨습니다.");
			return;
		}
			
	}// end of function insertGrade(fk_schedule_seq_assignment)  --%>
	
/* 	function editScore(score, assignment_submit_seq){
		
		if(confirm("점수를 수정하시겠습니까?")){
			
			const tdScore = $("td#editScore");
			tdScore.html(`
		            <input type='text' id='score' style='width: 50%' value='\${score}' />
		            <button type='button' class='btn btn-secondary mt-1' onclick='insertGrade("\${assignment_submit_seq}")'>점수입력</button>
		        `);
	    } else {
	        alert("취소를 누르셨습니다.");
	        return;
	    }
	}// end of function editScore(score)  */

</script>

<div style="display: flex; justify-content: center;" >
	<img src="<%= ctxPath%>/resources/images/good.jpg" style=""/>
</div>

<div style="display: flex;">
	<div class="table-container mt-3" style="margin: auto;">
		<table class="table table-bordered" id="assignCheck" style="width: 1080px; word-wrap: break-word; table-layout: fixed;">
			<thead>
				<tr>
					<th style="text-align: center;">이름</th>
					<th style="text-align: center;">학번</th>
					<th style="text-align: center;">과제점수백분율</th>
					<th style="text-align: center;">시험점수백분율</th>
					<th style="text-align: center;">출석점수백분율</th>
					<th style="text-align: center;">총합백분율</th>
					<th style="text-align: center;">학점</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
	<%-- 페이징처리 할 부분 --%>
</div>


<form name="reviseFrm">
	<input type="hidden" name="student_id"/>
	<input type="hidden" name="fk_course_seq"/>
	<input type="hidden" name="goBackURL"/>
	<input type="hidden" name="score"/>
</form>