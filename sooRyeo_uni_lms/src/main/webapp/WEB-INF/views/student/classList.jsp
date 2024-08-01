<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>


<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<style>

.majorO {

	border:solid 1px #175F30;
	background-color: #175F30;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}

.majorX {

	border:solid 1px #A0D468;
	background-color: #A0D468;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}

.no-majorO {

	border:solid 1px #FFD400;
	background-color: #FFD400;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}

.no-majorX {

	border:solid 1px #FF9500;
	background-color: #FF9500;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}


.border1 {
	height: 60px;
	display: flex;
	color: #175F30;
	text-align : center;
	padding : 20px 20px;
	font-size: 14pt;
	font-weight: bold;
	margin-left: 8%;
}

.border2 {
	height: 60px;
	display: flex;
	text-align : center;
	padding : 20px 20px;
	margin-left: 8%;
}


.border:hover {
	background-color: #e9ecef; /* Hover state for table rows */
	cursor: pointer; /* Indicate row is clickable */
}


body > div.content > div.main-content > div > div:nth-child(1) > div {
	margin-left: 20%;
	
}

</style>


<script type="text/javascript">

$(document).ready(function(){
	
	// 년도 학기 선택
	$("button#submitButton").click(function(e){
		
		const year = $("select#year").val();
	  	const semester = $("select#semester").val();
		  
	  	// 선택된 값을 출력하거나 다른 함수에서 사용
	  	//console.log('선택된 년도:', year);
	  	//console.log('선택된 학기:', semester);
		  
	  	// 선택된 값을 함수에 전달
	  	selectCourse(year, semester);
		
		
	}); // end of $("button#submitButton").click(function(e) 
	
			
			
	// 수업상세 이동		
	$("div.border").click(function(e){
		
		// alert($(this).find("input[name='course_seq']").val());
		location.href = "<%=ctxPath%>/student/myLecture.lms?course_seq=" + $(this).find("input[name='course_seq']").val();
		
	}); // end of $("div.border").click(function(e){})
	
}); // end of $(document).ready(function(){})


function selectCourse(year, semester){
	
	const selector = year+'-'+semester;
	//console.log(selector);
	
	if(year.trim() == "" || semester.trim() == ""){
		alert("년도와 학기를 입력해주세요.");
		return;
	}
	
	$("div#showCourse").html();
	
	$.ajax({
		url:"<%= ctxPath%>/student/classListJSON.lms",
		data:{"semester":selector},
		type:"post",
		dataType:"json",
		success:function(json){
			console.log(JSON.stringify(json));
			// [] 또는 [{"curriculum_seq":1,"department_seq":3,"course_seq":4,"professorName":"홍길동","className":"국어학개론","semester_date":"Sun Jul 07 00:00:00 GMT+09:00 2024","required":1,"prof_id":202400002},{"curriculum_seq":51,"department_seq":3,"course_seq":66,"professorName":"조앤롤링","className":"고전문학","semester_date":"Sun Jul 07 00:00:00 GMT+09:00 2024","required":1,"prof_id":202400013},{"curriculum_seq":78,"course_seq":22,"professorName":"홍길동","className":"영화로 보는 동유럽","semester_date":"Sun Jul 07 00:00:00 GMT+09:00 2024","required":0,"prof_id":202400002}]
	
			let v_html = ``;
			
	         
	         json.forEach(function(item, index, array){
	             v_html += `<div id="select">
	                         <div class="border mb-2" style="width: 80%; height: 90px; margin: 0 auto; font-size: 26pt; color: #175F30; font-weight: bold;">
	                             <input type="hidden" name="course_seq" value="\${item.course_seq}"/>
	                             <div style="display: flex;">
	                                 <div><img src="<%= ctxPath%>/resources/images/강사님.png" style="border-radius:50%; width: 50px; height: 50px; margin-left: 2%; margin-left: 20%; margin-top: 30%;"/></div>`;

	             if (item.fk_department_seq != null && item.required == 1) {
	                 v_html += `<div class="majorO rounded">전공필수</div>`;
	             } else if (item.fk_department_seq != null && item.required == 0) {
	                 v_html += `<div class="majorX rounded">전공선택</div>`;
	             } else if (item.fk_department_seq == null && item.required == 1) {
	                 v_html += `<div class="no-majorO rounded">교양필수</div>`;
	             } else {
	                 v_html += `<div class="no-majorX rounded">교양선택</div>`;
	             }

	             v_html += `<div style="width: 80%; margin-left: 3%; margin-top: 1%; margin-bottom: 1%;">
	                             <div style="font-size: 20pt; color: black;">\${item.name}&nbsp;&nbsp;<span style="font-size: 16pt;">\${item.credit}학점</span></div>
	                             <div style="font-size: 12pt; color: black;">\${item.prof_name}&nbsp;&nbsp;</div>
	                         </div>
	                         <div class="arrow" style=" margin-top: 1.5%; margin-right: 2%; margin-left: 14%; cursor: pointer;"><img src="<%= ctxPath%>/resources/images/right-arrow.png" style="width: 35px;"/></div>
	                         </div>
	                         </div>
	                     </div>`;
	         });
	         
	         $("div#showCourse").html(v_html);
	         

			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of $.ajax


} // end of function selectCourse


</script>


<div style="display: flex; width: 80%; margin-left: 10%;" class="row">

	<div style="margin-top: 1%; width: 100%;">
		<h3 class="ml-5 mb-4"><img src="<%= ctxPath%>/resources/images/class.png" style="width: 50px; height: 60px; margin-right:3%; margin-left:7%;"/>내 수업 목록</h3>
	
		<div style="display:flex;" class="form-group">
		  <select id="year" name="year" class="form-control" style="margin-right: 20px; width:15%; align-items: left; margin-left: 45%;">
		    <option value="">--년도 선택--</option>
		    <option value="21">2021</option>
		    <option value="22">2022</option>
		    <option value="23">2023</option>
		    <option value="24">2024</option>
		  </select>
		  <br>
		  <select id="semester" name="semester" class="form-control mb-2" style="margin-right: 20px; width:15%;">
		    <option value="">--학기 선택--</option>
		    <option value="03">1학기</option>
		    <option value="07">2학기</option>
		  </select>
		  
		  <button id="submitButton" class="btn btn-success" style="width:8%; height:40px;"><span>확인</span></button>
		</div>
		
		
		<c:if test="${empty requestScope.mapList}">
			<span style="margin-left:10%; font-weight:bold; color:red; font-size:18pt;">수강중인 수업이 없습니다.</span>
		</c:if>
		
		<c:if test="${not empty requestScope.mapList}">
		
			<c:forEach var="mapList" items="${requestScope.mapList}">
				<div class="border" style="width: 80%; height: 90px; margin: 0 auto; font-size: 26pt; color: #175F30; font-weight: bold;">
				   <input type="hidden" name="course_seq" value="${mapList.course_seq}"/>
				   <div style="display: flex;" >
				      <div><img src="<%= ctxPath%>/resources/images/강사님.png" style="border-radius:50%; width: 50px; height: 50px; margin-left: 2%; margin-left: 20%; margin-top: 30%;"/></div>
				      <c:if test="${mapList.curriculum.fk_department_seq != null && mapList.curriculum.required == '1'}">
				      	<div class="majorO rounded">전공필수</div>
				      </c:if>
				      <c:if test="${mapList.curriculum.fk_department_seq != null && mapList.curriculum.required == '0'}">
				      	<div class="majorX rounded">전공선택</div>
				      </c:if>
				      <c:if test="${mapList.curriculum.fk_department_seq == null && mapList.curriculum.required == '1'}">
				      	<div class="no-majorO rounded">교양필수</div>
				      </c:if>
				      <c:if test="${mapList.curriculum.fk_department_seq == null && mapList.curriculum.required == '0'}">
				      	<div class="no-majorX rounded">교양선택</div>
				      </c:if>
				      <div style="width: 60%; margin-left: 3%; margin-top: 1%;">
						  <div style="font-size: 20pt; color: black;">${mapList.curriculum.name}</div>
			         	  <div style="font-size: 12pt; color: black;">${mapList.professor.name}</div>	
				      </div>
				      <div class="arrow" style=" margin-top: 1%; margin-left: 14%;"><img src="<%= ctxPath%>/resources/images/right-arrow.png" style="width: 35px;"/></div>
				   </div>
				</div>
			</c:forEach>
		
		</c:if>
		
	</div>
</div>
	