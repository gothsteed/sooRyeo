<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 


<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>


<style type="text/css">

div.display-flex {
    display: flex;
    justify-content: space-between;
}

</style>



<script type="text/javascript">

$(document).ready(function(){
	

	// 검색하기 클릭 시
	$("button#btnSearchAjax").click(function(){
		
		$.ajax({
			url:"<%=ctxPath%>/student/attendanceListJSON.lms",
			data: {"name" : $("select[name='name']").val()},
			dataType:"json",
			success: function(json) { 
				
				// console.log(JSON.stringify(json));
				// [{"fk_student_id":"202400005","lecture_title":"제 2장. 언어와 언어학","name":"국어학개론"}]
		
		 		let v_html = ``;

				json.forEach(function(item, index, array) {
					
				    // 날짜 형식 변환
				    let originalDatetime = item.attended_date;
				    let date = new Date(originalDatetime);
				    let year = date.getFullYear();
				    let month = ('0' + (date.getMonth() + 1)).slice(-2);
				    let day = ('0' + date.getDate()).slice(-2);
				    let hours = ('0' + date.getHours()).slice(-2);
				    let minutes = ('0' + date.getMinutes()).slice(-2);
				    let seconds = ('0' + date.getSeconds()).slice(-2);
				    
				    // formattedDatetime을 생성
				    let formattedDatetime = originalDatetime ? `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}` : null;

				    // formattedDatetime이 null일 경우 "출석 진행중"으로 설정
				    let displayDatetime = formattedDatetime ? formattedDatetime : "출석 진행중";

				    v_html += `<tr>
				                    <td>\${item.fk_student_id}</td>	
				                    <td>\${item.name}</td>
				                    <td>\${item.lecture_title}</td>
				                    <td>\${displayDatetime}</td>
				                </tr>`;
				                
				});
				
				$("table#attendance tbody").html(v_html);
	
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
			
		}); // end of $.ajax
		
	}); // end of $("button#btnSearchAjax").click

	
	
	
	// === #207. Excel 파일로 다운받기 시작 === //
	$("button#btnExcel").click(function(){
		
		const frm = document.searchFrm;
		frm.name.value = name;
		
		frm.method = "post";		
		frm.action = "<%=ctxPath%>/downloadExcelFile.action";
		frm.submit();
		
	}); // end of $("button#btnExcel").click(function(){})
	// === Excel 파일로 다운받기 끝 === // 
	
	
}); // end of $(document).ready

</script>

<div style="display: flex; margin-top: 2%;">   
  	<div style="width: 80%; min-height: 1100px; margin:auto; ">

	<h3 style="margin-bottom: 2%; margin-top:2%;"><img src="<%=ctxPath%>/resources/images/attendance.png" style="width:3%; margin-right:2%;">출석현황</h3>
	<hr class="mt-3 mb-3">
		
     	<form class="mb-3" name="searchFrm">
     		<select name="name" style="height: 30px; width: 120px; margin: 10px 30px 0 0;"> 
         		<option value="">수업명 선택</option>
         		<c:forEach var="lecture" items="${requestScope.lectureList}">
         			<option>${lecture.name}</option>
         		</c:forEach>
       		</select>
     		<button type="button" class="btn btn-success btn-sm" id="btnSearchAjax">검색하기</button>
       		&nbsp;&nbsp;
     		<button type="button" class="btn btn-info btn-sm" style="margin-left:66%;" id="btnExcel">Excel 파일로 저장</button>
     	</form>
     	
		
		<div class="table-responsive">
		  <table id="attendance" class="table">
		    <thead class="table-info">
		    	<tr>
		    		<th>학번</th>
		    		<th>수업명</th>
		    		<th>강의명</th>
		    		<th>출석날짜</th>
		    	</tr>
		    </thead>
		    <tbody class="table-group-divider">
		    	<c:if test="${not empty requestScope.attendanceList}">
			    	<c:forEach var="attendanceList" items="${requestScope.attendanceList}">
			    	<tr>
			    		<td>${attendanceList.fk_student_id}</td>
			    		<td>${attendanceList.name}</td>
			    		<td>${attendanceList.lecture_title}</td>
			    		<c:if test="${attendanceList.attended_date == null}">
			    			<td>출석 진행중</td>
			    		</c:if>
			    		<c:if test="${attendanceList.attended_date != null}">
			    			<td>${attendanceList.attended_date}</td>
			    		</c:if>
			    	</tr>
			    	</c:forEach>
		    	</c:if>
		    </tbody>
		  </table>
		</div>

	</div>
</div>







