<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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


</style>

<script type="text/javascript">

$(document).ready(function(){
	
	$("button#submitButton").click(function(e){
		
		const year = $("select#year").val();
	  	const semester = $("select#semester").val();
		  
	  	//console.log('선택된 년도:', year);
	  	//console.log('선택된 학기:', semester);
		  
	  	// 선택된 값을 함수에 전달
	  	selectCourse(year, semester);
		
		
	}); // end of $("button#submitButton").click(function(e) 
			
			
}); // end of $(document).ready


// function declaration
function selectCourse(year, semester){
	
	const selector = year+'-'+semester;
	// console.log(selector);
	
	if(year.trim() == "" || semester.trim() == ""){
		alert("년도와 학기를 입력해주세요.");
		return;
	}

	$("div#showList").html();
	

 	$.ajax({
		url:"<%=ctxPath%>/student/Acquisition_status_JSON.lms",
		data:{"semester":selector},
		type:"post",
		success:function(json){
			//console.log(JSON.stringify(json));
			
			let v_html = ``;
			
			json.forEach(function(item, index, array) {
				
				v_html += `<tr>
								<th style="text-align: center;">\${item.name}</th>
								<th style="text-align: center;">\${item.semester_date}</th>
								<th style="text-align: center;">\${item.score}</th>
								<th style="text-align: center;">\${item.mark}</th>
						   </tr>`;
				
				
			}); // end of json.forEach
			
			$("div#showList").html(v_html);
			
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of $.ajax 

	
} // end of function selectCourse




</script>


<div style="display: flex; width: 50%; align-items: center;" class="form-group ml-1">

  	<select id="year" name="year" class="form-control" style="margin-right: 20px;">
	    <option value="">--년도 선택--</option>
	    <option value="2021">2021</option>
	    <option value="2022">2022</option>
	    <option value="2023">2023</option>
	    <option value="2024">2024</option>
	    <option value="2025">2025</option>
  	</select>
  	<br>
  	<select id="semester" name="semester" class="form-control mb-2" style="margin-right: 20px;">
	    <option value="">--학기 선택--</option>
	    <option value="03">1학기</option>
	    <option value="07">2학기</option>
  	</select>
  
  <button id="submitButton" class="btn btn-info" style="width:20%;"><span>확인</span></button>
</div>

<hr style="margin-bottom:3%;">

<div style="margin-top: 5%; width : 80%; id="showList">
<div style="display: flex;">
	<div class="table-container mt-3" style="margin: auto;">
		<table class="table table-bordered" id="assignCheck" style="width: 1024px; word-wrap: break-word; table-layout: fixed;">
			<thead>
				<tr>
					<th style="text-align: center;">수업명</th>
					<th style="text-align: center;">개설학기</th>
					<th style="text-align: center;">점수</th>
					<th style="text-align: center;">학점</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${requestScope.Acquisition_status == null}">
				<tr>
					<td colspan="4" style="text-align: center;">취득한 성적이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${requestScope.Acquisition_status != null}">
				<c:forEach var="acquisition" items="${requestScope.Acquisition_status}">
					<tr id="myScoreView">
						<th style="text-align: center;">${acquisition.name}</th>
						<th style="text-align: center;">${acquisition.semester_date}</th>
						<th style="text-align: center;">${acquisition.score}</th>
						<th style="text-align: center;">${acquisition.mark}</th>
					</tr>
				</c:forEach>
			</c:if>		
			</tbody>
		</table>
	</div>
</div>
</div>

















