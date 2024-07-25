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



<title>SooRyeo Univ.</title>


<style>

.majorO {

	border:solid 1px #175F30;
	background-color: #175F30;
	width: 12%;
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
	width: 12%;
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
	width: 12%;
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
	width: 12%;
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

</style>


<script type="text/javascript">

$(document).ready(function(){
	 	
	$("button#submitButton").click(function(e){
		
		const year = $("select#year").val();
	  	const semester = $("select#semester").val();
		  
	  	// 선택된 값을 출력하거나 다른 함수에서 사용
	  	//console.log('선택된 년도:', year);
	  	//console.log('선택된 학기:', semester);
		  
	  	// 선택된 값을 함수에 전달
	  	selectCourse(year, semester);
		
		
	}); // end of $("button#submitButton").click(function(e) 

	
	$(document).on("click", "div.arrow", function(e){ // 화살표 클릭시 상세로 이동
		// alert($(this).find("input[name='course_seq']").val());
		location.href = "<%=ctxPath%>/professor/courseDetail.lms?course_seq="+$(this).parent().parent().find("input[name='course_seq']").val(); 
	});		
			
<%--	
	$("div.arrow").click(function(e){
		
		
		
	}); // end of $("div.border").click(function(e){})
--%>	
			
}); // end of $(document).ready(function(){})


function selectCourse(year, semester){
	
	const selector = year+'-'+semester;
	// console.log(selector);
	
	if(year.trim() == "" || semester.trim() == ""){
		alert("년도와 학기를 입력해주세요.");
		return;
	}
	
	$("div#showCourse").html();
	
	$.ajax({
		url:"<%= ctxPath%>/professor/courseListJson.lms",
		data:{"semester":selector},
		type:"post",
		dataType:"json",
		success:function(json){
			console.log(JSON.stringify(json));
			
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
			                    <div style="font-size: 12pt; color: black;">\${item.prof_name}&nbsp;&nbsp;`;

			    item.timeList.forEach(function(item, index, array) {  
			        let dayOfWeek = "";
			        switch(item.day_of_week) {
			            case 1: dayOfWeek = "월"; break;
			            case 2: dayOfWeek = "화"; break;
			            case 3: dayOfWeek = "수"; break;
			            case 4: dayOfWeek = "목"; break;
			            case 5: dayOfWeek = "금"; break;
			            default: dayOfWeek = "요일없음";
			        }
			        v_html += `\${dayOfWeek}&nbsp;\${item.start_period}-\${item.end_period}교시&nbsp;`;
			    });

			    v_html += `</div>
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
	});
	
}




</script>

<div class="form-group ml-1" style="width:22%;">
  <label for="year">년도 선택</label> 
  <select id="year" name="year" class="form-control">
    <option value="">--년도 선택--</option>
    <option value="21">2021</option>
    <option value="22">2022</option>
    <option value="23">2023</option>
    <option value="24">2024</option>
  </select>
  
  <label for="semester">학기 선택</label><br> 
  <select id="semester" name="semester" class="form-control">
    <option value="">--학기 선택--</option>
    <option value="03">1학기</option>
    <option value="07">2학기</option>
  </select>
    
</div>

<button id="submitButton" class="btn btn-primary">확인</button>
 
<div style="display: flex; width : 100%;" class="row">

	<div style="margin-top: 5%; width : 80%; border: solid 0px green;" id="showCourse">
	<h3 class="ml-5"><img src="<%= ctxPath%>/resources/images/class.png" style="width: 50px; height: 60px; margin-right:3%; margin-left:7%;"/>내 수업 목록</h3>
		<c:forEach var="course" items="${requestScope.courseList}" varStatus="status">
			<div id="select">
			<div class="border mb-2" style="width: 80%; height: 90px; margin: 0 auto; font-size: 26pt; color: #175F30; font-weight: bold;">
			   <input type="hidden" name="course_seq" value="${course.course_seq}"/>
			   <div style="display: flex;" >
			      <div><img src="<%= ctxPath%>/resources/images/강사님.png" style="border-radius:50%; width: 50px; height: 50px; margin-left: 2%; margin-left: 20%; margin-top: 30%;"/></div>
			      <c:choose>
                	<c:when test="${course.curriculum.fk_department_seq != null && course.curriculum.required == 1}">
                    	<div class="majorO rounded">전공필수</div>
                	</c:when>
                	<c:when test="${course.curriculum.fk_department_seq != null && course.curriculum.required == 0}">
                    	<div class="majorX rounded">전공선택</div>
                	</c:when>
                	<c:when test="${course.curriculum.fk_department_seq == null && course.curriculum.required == 1}">
                    	<div class="no-majorO rounded">교양필수</div>
                	</c:when>
                	<c:otherwise>
                    	<div class="no-majorX rounded">교양선택</div>
                	</c:otherwise>
            	  </c:choose>
			      <div style="width: 80%; margin-left: 3%; margin-top: 1%; margin-bottom: 1%;">
					  <div style="font-size: 20pt; color: black;">${course.curriculum.name}&nbsp;&nbsp;<span style="font-size: 16pt;">${course.curriculum.credit}학점</span></div>
			         	  <div style="font-size: 12pt; color: black;">
			         	  	${requestScope.loginuser.name}&nbsp;&nbsp;
			         	  	<c:forEach var="time" items="${course.timeList}" varStatus="status">
				         	  	<c:choose>
		                        	<c:when test="${time.day_of_week == 1}">월</c:when>
		                        	<c:when test="${time.day_of_week == 2}">화</c:when>
		                        	<c:when test="${time.day_of_week == 3}">수</c:when>
		                        	<c:when test="${time.day_of_week == 4}">목</c:when>
		                        	<c:when test="${time.day_of_week == 5}">금</c:when>
		                        	<c:otherwise>요일없음</c:otherwise>
		                    	</c:choose>
		                    	&nbsp;${time.start_period}-${time.end_period}교시
	                    	</c:forEach>
	                 	  </div>	  
			      </div>
			      <div class="arrow" style=" margin-top: 1.5%; margin-right: 2%; margin-left: 14%; cursor: pointer;"><img src="<%= ctxPath%>/resources/images/right-arrow.png" style="width: 35px;"/></div>
			   </div>
			</div>
		</div>	
		</c:forEach>
	</div>
	
	
	<div style="width: 20%; height: 200px; border-left:solid 2px #DEE2E6; height: 800px;">
		<div class="border border1">· 공지사항</div>
		<div class="border border2">등록된 게시글이 없습니다.</div>
		<div class="border border1">· 예정된 할일(03-03 ~ 03-24)</div>
		<div class="border border2">계획된 일정이 없습니다.</div>
	</div>

</div>


