<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
   String ctxPath = request.getContextPath(); 
   //    /board
%>    
<style type="text/css">

	table#schedule{
		margin-top: 70px;
	}
	
	table#schedule th, td{
	 	padding: 10px 5px;
	 	vertical-align: middle;
	}
	
	select.schedule{
		height: 30px;
	}
	
	input#joinUserName:focus{
		outline: none;
	}	
	
	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
	}
	  
	button.btn_normal{
		border: none;
		color: white;
		width: 70px;
		height: 30px;
		font-size: 12pt;
		padding: 3px 0px;
		border-radius: 10%;
	}
	   
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// === *** 달력(type="date") 관련 시작 *** === //
		// 시작시간, 종료시간		
		var html="";
		for(var i=0; i<24; i++){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else{
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
		// 시작분, 종료분 
		html="";
		for(var i=0; i<60; i=i+5){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else {
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for--------------------
		html+="<option value="+59+">"+59+"</option>"
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		// === *** 달력(type="date") 관련 끝 *** === //
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("59");
				$("select#startHour").prop("disabled",true);
				$("select#startMinute").prop("disabled",true);
				$("select#endHour").prop("disabled",true);
				$("select#endMinute").prop("disabled",true);
			} 
			else {
				$("select#startHour").prop("disabled",false);
				$("select#startMinute").prop("disabled",false);
				$("select#endHour").prop("disabled",false);
				$("select#endMinute").prop("disabled",false);
			}
		});
		
				
		
		// 등록 버튼 클릭
		$("button#edit").click(function(){
		
			// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
			var startDate = $("input#startDate").val();	
	    	var sArr = startDate.split("-");
	    	startDate= "";	
	    	for(var i=0; i<sArr.length; i++){
	    		startDate += sArr[i];
	    	}
	    	
	    	var endDate = $("input#endDate").val();	
	    	var eArr = endDate.split("-");   
	     	var endDate= "";
	     	for(var i=0; i<eArr.length; i++){
	     		endDate += eArr[i];
	     	}
			
	     	var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	        
	     	// 조회기간 시작일자가 종료일자 보다 크면 경고
	        if (Number(endDate) - Number(startDate) < 0) {
	         	alert("종료일이 시작일 보다 작습니다."); 
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		alert("종료일이 시작일 보다 작습니다."); 
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			alert("종료일이 시작일 보다 작습니다."); 
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			alert("시작일과 종료일이 동일합니다."); 
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	    	
			// 제목 유효성 검사
			var subject = $("input#title").val().trim();
	        if(subject==""){
				alert("제목을 입력하세요."); 
				return;
			}
	        

			
			// 달력 형태로 만들어야 한다.(시작일과 종료일)
			// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
			
			$("input[name=startdate]").val(sdate);
			$("input[name=enddate]").val(edate);
		
		//	console.log("캘린더 소분류 번호 => " + $("select[name=fk_smcatgono]").val());
			/*
			      캘린더 소분류 번호 => 1 OR 캘린더 소분류 번호 => 2 OR 캘린더 소분류 번호 => 3 OR 캘린더 소분류 번호 => 4 
			*/
			
		//  console.log("색상 => " + $("input#color").val());
			
			var frm = document.scheduleFrm;
			frm.action="<%= ctxPath%>/professor/assignmentEdit_end.lms";
			frm.method="post";
			frm.submit();

		});// end of $("button#register").click(function(){})--------------------
		
	}); // end of $(document).ready(function(){}-----------------------------------


	// ~~~~ Function Declaration ~~~~
	
	$(document).ready(function(){
		
		const start = "${requestScope.assign_edit.schedule.start_date}";
		const startdate = start.substring(0,10);
		
		const startHour = start.substring(11,13);
		const startMin = start.substring(14,16);
		
		const end = "${requestScope.assign_edit.schedule.end_date}";
		const enddate = end.substring(0,10);
		
		const endHour = end.substring(11,13);
		const endMin = end.substring(14,16);
		
		$("input#startDate").val(startdate);
		$("select#startHour").val(startHour);
		$("select#startMinute").val(startMin);
		
		$("input#endDate").val(enddate);
		$("select#endHour").val(endHour);
		$("select#endMinute").val(endMin);
		
		$("input[name='attach']").on("change", function() {
	        $("p#exist_file").remove();
	    });
		
	});
	
// value="${requestScope.assign_edit.schedule.start_date}" 
</script>

<div style="margin-left: 80px; width: 88%;">
<h3>과제 수정</h3>

	<form name="scheduleFrm" enctype="multipart/form-data">
		<table id="schedule" class="table table-bordered">
			<tr>
				<th>일자</th>
				<td>
					<input type="date" id="startDate" style="height: 30px;"/>&nbsp; 
					<select id="startHour" class="schedule"></select> 시
					<select id="startMinute" class="schedule"></select> 분
					- <input type="date" id="endDate" style="height: 30px;"/>&nbsp;
					<select id="endHour" class="schedule"></select> 시
					<select id="endMinute" class="schedule"></select> 분&nbsp;
					<input type="checkbox" id="allDay"/>&nbsp;<label for="allDay">종일</label>
					
					<input type="hidden" name="startdate"/>
					<input type="hidden" name="enddate"/>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" id="title" name="title" class="form-control" value="${requestScope.assign_edit.schedule.title}"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="100" style="height: 200px;" name="content" id="content"  class="form-control">${requestScope.assign_edit.assignment.content}</textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="attach"/>
				<c:if test="${not empty requestScope.assign_edit.assignment.attatched_file}">
				<br>
				<p id="exist_file" class="mt-1">
        		${requestScope.assign_edit.assignment.attatched_file}
        		<button type="button" class="btn btn-outline-secondary">X</button>	
    			</p>	
				</c:if>
				<c:if test="${empty requestScope.assign_edit.assignment.attatched_file}">
					
				</c:if>
				</td>
			</tr>
		</table>
		<input type="hidden" value="${requestScope.assign_edit.assignment.schedule_seq_assignment}" name="schedule_seq_assignment"/>
		<input type="hidden" value="${requestScope.assign_edit.assignment.attatched_file}" name="attatched_file"/>
	</form>
	
	<div style="float: right;">
	<button type="button" id="edit" class="btn_normal" style="margin-right: 10px; background-color: #0071bd;">수정</button>
	<button type="button" class="btn_normal" style="background-color: #990000;" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'">취소</button> 
	</div>
</div>