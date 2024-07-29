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
				  "fk_course_seq":"${requestScope.fk_course_seq}",
				  "name":"${requestScope.name}"},
			dataType:"json",
			
			success:function(json){			
				console.log(JSON.stringify(json));
				
				let v_html = '';

			    if ($.isEmptyObject(json) || json.length === 0) {
			        // JSON이 비어있거나 길이가 0일 경우
			        v_html = `<tr>
			            <td colspan="7" style="text-align: center;">성적정보가 없습니다.</td>
			        </tr>`;
			    }
			    else {
					v_html += `<tr>
				      			<td style="text-align: center; vertical-align: middle;">\${json.name}</td> 
				      			<td style="text-align: center; vertical-align: middle;">\${json.student_id}</td> 
				      			<td style="text-align: center; vertical-align: middle;">\${json.assignmentScore}</td>
				      			<td style="text-align: center; vertical-align: middle;">\${json.totalExamScore}</td>
					            <td style="text-align: center; vertical-align: middle;"></td>
					            <td style="text-align: center; vertical-align: middle;"></td>`
					
					if (json.mark == null) {
				        v_html += `<td style='text-align: center; vertical-align: middle;' id='mark'>
				        	<select id="grade_1" name="grade_1" class="form-control">
				        	<option value="">학점 선택1</option>
				        	<option value="4">A</option>
							<option value="3">B</option>
							<option value="2">C</option>
							<option value="1">D</option>
							<option value="0">F</option>
							</select>
							<br>
							<select id="grade_2" name="grade_2" class="form-control mb-2">
				        	<option value="">학점 선택2</option>
				        	<option value="0">0</option>
							<option value="0.5">+</option>
							</select>
							<br>
				            <button type='button' class='btn btn-secondary mt-1' onclick='insertGrade("\${json.student_id}", "\${json.regi_course_seq}")'>학점입력</button>
				        </td>`;
				    } else {
				    	
						let gradeDisplay = '';
			        	
			        	if (json.mark == 4.5) {
			        	    gradeDisplay = 'A+';
			        	} else if (json.mark == 4.0) {
			        	    gradeDisplay = 'A';
			        	} else if (json.mark == 3.5) {
			        	    gradeDisplay = 'B+';
			        	} else if (json.mark == 3.0) {
			        	    gradeDisplay = 'B';
			        	} else if (json.mark == 2.5) {
			        	    gradeDisplay = 'C+';
			        	} else if (json.mark == 2.0) {
			        	    gradeDisplay = 'C';
			        	} else if (json.mark == 1.5) {
			        	    gradeDisplay = 'D+';
			        	} else if (json.mark == 1.0) {
			        	    gradeDisplay = 'D';
			        	} else if (json.mark == 0.0) {
			        	    gradeDisplay = 'F';
			        	}
				    	
			        	v_html += `<td style='text-align: center; vertical-align: middle;' id='mark'>
			        	    \${gradeDisplay}
			        	    <br>
			        	    <button type='button' class='btn btn-secondary mt-1' onclick='editGrade("\${json.regi_course_seq}")'>학점수정</button>
			        	</td>`
				    }            
						
					v_html += `</tr>`;
			    }
			    
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
	
	function insertGrade(student_id, regi_course_seq){// 학점 입력해주기
		
		console.log($("select#grade_1").val().trim());
		console.log($("select#grade_2").val().trim());
		
		const grade = $("select#grade_1").val().trim() + $("select#grade_2").val().trim();
		
		
		
		
		if(grade == ""){
			alert("학점을 선택해주세요!");
			return;
		}
		
		if(regi_course_seq == null){
			alert("학점을 입력할 수 없습니다!");
			return;
		}
		else{
			
			const grade1 = parseFloat($("select#grade_1").val().trim());
			const grade2 = parseFloat($("select#grade_2").val().trim());
			const mark = grade1 + grade2; 
			
			console.log(mark);
			
			const frm = document.insertFrm;
			
			frm.student_id.value = student_id;
			frm.regi_course_seq.value = regi_course_seq;
			frm.goBackURL.value = "${requestScope.goBackURL}";
			frm.mark.value = mark; 
			
			frm.method = "post";
			frm.action = "<%= ctxPath%>/professor/insertGradeEnd.lms";
			frm.submit();
				
		}
	
	}// end of function insertGrade(student_id, regi_course_seq)
	
	function editGrade(regi_course_seq){
		
		const re_course_seq = regi_course_seq;
		console.log("확인용 re_course_seq : ", re_course_seq);
		
		const markTd = $("td#mark");
	    // 원래 내용을 데이터 속성에 저장
	    markTd.data('original-content', markTd.html());
	    
	    markTd.empty();
	    
	    let v_html = `
	    <td style='text-align: center; vertical-align: middle;' id='mark'>
	        <select id="grade_1" name="grade_1" class="form-control">
	            <option value="">학점 선택1</option>
	            <option value="4">A</option>
	            <option value="3">B</option>
	            <option value="2">C</option>
	            <option value="1">D</option>
	            <option value="0">F</option>
	        </select>
	        <br>
	        <select id="grade_2" name="grade_2" class="form-control mb-2">
	            <option value="">학점 선택2</option>
	            <option value="0">0</option>
	            <option value="0.5">+</option>
	        </select>
	        <br>
	        <button type='button' class='btn btn-secondary mt-1' onclick='edit(\${re_course_seq})'>학점수정</button>
	        <button type='button' class='btn btn-secondary mt-1' onclick='cancelEdit()'>수정취소</button>
	    </td>`;
	    
	    markTd.html(v_html);
		
		
	}// end of function editGrade() 
	
	function edit(regi_course_seq){
		
		const grade1 = parseFloat($("select#grade_1").val().trim());
		const grade2 = parseFloat($("select#grade_2").val().trim());
		const mark = grade1 + grade2;
		
		const frm = document.insertFrm;
		
		console.log(regi_course_seq);
		
		if(regi_course_seq == null){
			alert("실패");
			return;
		}
		
		frm.regi_course_seq.value = regi_course_seq;
		frm.goBackURL.value = "${requestScope.goBackURL}";
		frm.mark.value = mark; 
		
		frm.method = "post";
		frm.action = "<%= ctxPath%>/professor/editGradeEnd.lms";
		frm.submit();
		
	}// end of function edit(regi_course_seq) 
	
	
	function cancelEdit(){
		
		const markTd = $("td#mark");
	    // 저장해둔 원래 내용을 복원
	    markTd.html(markTd.data('original-content'));
		
		
	}// end of function cancelEdit() 
	


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


<form name="insertFrm">
	<input type="hidden" name="student_id"/>
	<input type="hidden" name="regi_course_seq"/>
	<input type="hidden" name="goBackURL"/>
	<input type="hidden" name="mark"/>
</form>