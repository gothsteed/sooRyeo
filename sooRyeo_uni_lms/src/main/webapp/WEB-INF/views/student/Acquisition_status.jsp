<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">
th {
	background-color: #ccd9ff;

}

tr#myScoreView > td:last-child {
	color: red;
}
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


 	$.ajax({
		url:"<%=ctxPath%>/student/Acquisition_status_JSON.lms",
		data:{"semester":selector},
		type:"post",
		success:function(json){
			

			// console.log(JSON.stringify(json));
			// "[{\"score\":\"100\",\"name\":\"국어학개론\",\"semester_date\":\"2024년 2학기\",\"mark\":\"4.5\"}]"
			
			
		    // JSON 문자열을 JavaScript 객체로 변환
		    let data;
			
		    try {
		        data = JSON.parse(json); // JSON.parse를 사용하여 변환
		    } catch (e) {
		        console.error("JSON 파싱 오류:", e);
		        return; // 에러 발생 시 함수를 종료
		    }
			
			
			let v_html = ``;
			
		    if (data === null || (typeof data === "object" && Object.keys(data).length === 0)) {
		        v_html += `<tr id="myScoreView">
		                       <td colspan='5' style="text-align: center;">취득현황이 없습니다.</td>
		                   </tr>`;
		    } else if (Array.isArray(data) && data.length > 0) {
		        $.each(data, function(index, item) {
		            v_html += `<tr id="myScoreView">
		            	 		   <td style="text-align: center;">\${item.student_id}</td>
		                           <td style="text-align: center;">\${item.name}</td>
		                           <td style="text-align: center;">\${item.semester_date}</td>
		                           <td style="text-align: center;">\${item.score}</td>
		                           <td style="text-align: center;">\${item.mark}</td>
		                       </tr>`;
		        });
		    } else if (typeof data === "object") {
		        v_html += `<tr id="myScoreView">
		        			   <td style="text-align: center;">\${item.student_id}</td>
		                       <td style="text-align: center;">\${data.name}</td>
		                       <td style="text-align: center;">\${data.semester_date}</td>
		                       <td style="text-align: center;">\${data.score}</td>
		                       <td style="text-align: center;">\${data.mark}</td>
		                   </tr>`;
		    }
		    
            $("div#showList tbody").html(v_html); // tbody에 내용 추가
			
			
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
  	<select id="semester" name="semester" class="form-control mb-2" style="margin-top: 10px; margin-right: 20px;">
	    <option value="">--학기 선택--</option>
	    <option value="03">1학기</option>
	    <option value="07">2학기</option>
  	</select>
  
  <button id="submitButton" class="btn btn-info" style="width:20%;"><span>확인</span></button>
</div>

<hr style="margin-bottom:3%;">

<div style="margin-top: 5%; width : 100%;"  id="showList">
<div style="display: flex;">
	<div class="table-container mt-3" style="margin: auto;">
		<table class="table table-bordered" id="assignCheck" style="width: 1024px; word-wrap: break-word; table-layout: fixed;">
			<thead>
				<tr>
					<th style="text-align: center;">학번</th>
					<th style="text-align: center;">수업명</th>
					<th style="text-align: center;">개설학기</th>
					<th style="text-align: center;">점수</th>
					<th style="text-align: center;">학점</th>
				</tr>
			</thead>
			<tbody>
                   <c:if test="${requestScope.Acquisition_status == null}">
                        <tr>
                            <td colspan="5" style="text-align: center;">취득한 성적이 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:if test="${requestScope.Acquisition_status != null}">
                        <c:forEach var="acquisition" items="${requestScope.Acquisition_status}">
                            <tr id="myScoreView">
                            	<td style="text-align: center;">${acquisition.student_id}</td>
                                <td style="text-align: center;">${acquisition.name}</td>
                                <td style="text-align: center;">${acquisition.semester_date}</td>
                                <td style="text-align: center;">${acquisition.score}</td>
                                <td style="text-align: center;">${acquisition.mark}</td>
                            </tr>
                        </c:forEach>
                    </c:if>		
			</tbody>
		</table>
	</div>
</div>
</div>

















