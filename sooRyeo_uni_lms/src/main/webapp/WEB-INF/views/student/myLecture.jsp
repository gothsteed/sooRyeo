<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   	String ctxPath = request.getContextPath();
%>

<%-- Bootstrap CSS --%>



<style type="text/css">

.btns {
  display: flex;
  position: fixed;
  right: 150px;
  bottom: 200px;
}



</style>

<script type="text/javascript">


function scrollToTarget_up() {

    var target = document.getElementById('target');
    target.scrollIntoView({ behavior: 'smooth' });

}


function scrollToTarget_down() {

    var target = document.getElementById('target2');
    target2.scrollIntoView({ behavior: 'smooth' });

}

function goAssignment_List(){

	// alert(${requestScope.fk_course_seq});

	location.href = "<%=ctxPath%>/student/assignment_List.lms?fk_course_seq="+${requestScope.fk_course_seq};

}

function goLectureNotice(){

	location.href = "<%=ctxPath%>/board/lecture_notice.lms?fk_course_seq="+${requestScope.fk_course_seq};

}


function consulting() {
	$("#ConsultingModal").modal("show");
}

$(document).ready(function(){

	// 시작시간, 종료시간
	var html="";
	for(var i=0; i<24; i++) {
		if(i<10){
			html+="<option value='0"+i+"'>0"+i+"</option>";
		}
		else{
			html+="<option value="+i+">"+i+"</option>";
		}
	}// end of for----------------------

	$("select#startHour").html(html);
	$("select#startHour").val(startHour);


	// 시작분, 종료분
	html="";
	for(var i=0; i<60; i=i+5) {
		if(i<10){
			html+="<option value='0"+i+"'>0"+i+"</option>";
		}
		else {
			html+="<option value="+i+">"+i+"</option>";
		}
	}// end of for--------------------

	$("select#startMinute").html(html);
	$("select#startMinute").val(startMinute);



	// 상담신청 하기 버튼 클릭 했을 경우
	$("button#Consulting_ok").click(function() {


		// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
		var startDate = $("input#calendar_start_time").val();

    	var sArr = startDate.split("-");
    	startDate= "";
    	for(var i=0; i<sArr.length; i++){
    		startDate += sArr[i];
    	}

    	const now = new Date();

    	const year = now.getFullYear();
    	const month = String(now.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
    	const day = String(now.getDate()).padStart(2, '0');
    	const hours = String(now.getHours()).padStart(2, '0');
    	const minutes = String(now.getMinutes()).padStart(2, '0');
    	const seconds = String(now.getSeconds()).padStart(2, '0');

    	const sysdate = `\${year}\${month}\${day}`;
    	const syshour = `\${hours}`;
    	const sysminutes = `\${minutes}`;

     	var startHour= $("select#startHour").val();
     	var startMinute= $("select#startMinute").val();
     	var endHour = syshour;
     	var endMinute= sysminutes;

     	console.log("되라" ,startHour);

     	// 조회기간 시작일자가 종료일자 보다 크면 경고
        if (Number(startDate) - Number(sysdate) < 0) {
         	alert("현재보다 상담신청일이 과거입니다.");
         	return;
        }

     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
        else if(Number(sysdate) == Number(startDate)) {

        	if(Number(endHour) > Number(startHour)){
        		alert("현재보다 상담신청일이 과거입니다.");
        		return;
        	}
        	else if(Number(startHour) == Number(endHour)){
        		if(Number(endMinute) > Number(startMinute)){
        			alert("현재보다 상담신청일이 과거입니다.");
        			return;
        		}
        		else if(Number(startMinute) == Number(endMinute)){
        			alert("현재와 상담신청일이 동일합니다.");
        			return;
        		}
        	}
        }// end of else if---------------------------------


		// 상담신청 제목 유효성 검사
		var title = $("input#consult_title").val().trim();
        if(title=="") {
			alert("상담 제목을 입력하세요.");
			return;
		}

        // 상담신청 내용 유효성 검사
		var content = $("input#consult_content").val().trim();
        if(content=="") {
			alert("상담 내용을 입력하세요.");
			return;
		}

     	// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
        var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
        var hour = String(parseInt($("select#startHour").val())).padStart(2, '0');
        var edate = startDate+hour+$("select#startMinute").val()+"00";

        console.log("hour", hour);

        const prof_id = $("input[name='prof_id']").val();

	 	const formData = new FormData();

        formData.append('prof_id', prof_id);
        formData.append('title', title);
        formData.append('content', content);
        formData.append('start_date', sdate);
        formData.append('end_date', edate);

        $.ajax({
     		url:"<%= ctxPath%>/student/insert_schedule_consult.lms",
     		method : "POST",
     		data: formData,
     		dataType:'json',
			contentType: false,
			processData: false,
     		success: function(json) {

				if( json.result == 1) {
					$('#ConsultingModal').modal('hide');
					alert("상담 신청 성공!");
					return;
				}

     		},
	        error: function(xhr, status, error) {
				alert("상담 신청 실패!");
       		}

     	});

	});



	$('a#classPlay').click(function(){

		const courseSeq = $("input:hidden[name='fk_course_seq']").val();

	 	location.href = "<%= ctxPath%>/student/classPlay.lms?course_seq=" + courseSeq;


	});

	
});// end of $(document).ready(function(){});


function goExamList(course_seq){
	location.href="<%= ctxPath%>/student/exam.lms?course_seq="+ course_seq;
}


// ConsultingModal 모달이 닫히면 안에 쓰던 내용 다 지우기
$('#ConsultingModal').on('hidden.bs.modal', function () {
	location.href="javascript:history.go(0)";
});


</script>


    <!-- 상담신청 Modal -->
    <div class="modal fade" id="ConsultingModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                <c:forEach var="professor_info" items="${requestScope.professor_info}">
                    <h5 class="modal-title" id="insertModalLabel">${professor_info.name} 교수님과 상담신청</h5>
                    <input type="hidden" name="prof_id" value="${professor_info.prof_id}" />
               	</c:forEach>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                    	<label for="taskId" class="col-form-label">상담 제목</label>
                        <input type="text" class="form-control" id="consult_title" name="consult_title">
                        <label for="taskId" class="col-form-label">상담 내용</label>
                        <input type="text" class="form-control" id="consult_content" name="consult_content">

                        <label for="taskId" class="col-form-label">상담 날짜</label>
                        <br>
						<input type="date" id="calendar_start_time" name="calendar_start_time"/>&nbsp;
						<select id="startHour" class="form-select"></select> 시
						<select id="startMinute" class="form-select"></select> 분

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="Consulting_ok">상담신청하기</button>
                </div>

            </div>
        </div>
    </div>


<div id="target"></div>
<div class="container mt-5">
<h3>강의 개요</h3>
<hr>
	<div class="card-body" style="">
		<button type="button" class="btn btn-outline-light" style="width:20%; height:150px;" onclick="goLectureNotice()">
			<img src="<%=ctxPath%>/resources/images/annoucement.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="annoucement" style="color:black; font-weight: bold;">공지사항</span>
			<br>
		</button>
		<button type="button" class="btn btn-outline-light ml-5" style="width:20%; height:150px;" onclick="goAssignment_List();">
			<img src="<%=ctxPath%>/resources/images/tasks.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="tasks" style="color:black; font-weight: bold;">과제</span>
			<br>
		</button>
		
		<button type="button" class="btn btn-outline-light ml-5" style="width:20%; height:150px;" onclick="goExamList('${requestScope.fk_course_seq}')">
			<img src="<%=ctxPath%>/resources/images/test.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="tasks" style="color:black; font-weight: bold;">시험</span>
			<br>
		</button>
		
		<button type="button" class="btn btn-outline-light ml-5" style="width:20%; height:150px;" onclick="consulting()">
			<img src="<%=ctxPath%>/resources/images/consulting.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="tasks" style="color:black; font-weight: bold;">상담신청</span>
			<br>
		</button>
		<input type="hidden" name="fk_course_seq" value="${requestScope.fk_course_seq}"/>
	</div>
</div>


<div class="container" style="margin-top:5%;">
<h3>이번주 강의</h3>
<hr>
	<c:forEach var="lecture_week" items="${requestScope.lectureList_week}">
		<div class="card mb-5">
			

				<div class="card-header" style="display: flex">
					<h5 style="font-weight:bold;">${lecture_week.lecture_title}</h5>
					<c:if test="${requestScope.attendanceMap[lecture_week.lecture_seq]}">
						<span class="badge badge-success d-block, ml-1" style="height: 20px;">수강완료</span>
					</c:if>

				</div>
				<div class="card-body">
					<h5 class="card-title">${lecture_week.lecture_content}</h5>
					<hr>
					<a class="card-link" id="classPlay"><img src="<%=ctxPath%>/resources/images/play.png" class="img-fluid" style="width:3%;">&nbsp;${lecture_week.video_file_name}</a>
					<span class="card-text" style="color:orange;"><fmt:formatDate value="${lecture_week.start_date}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${lecture_week.end_date}" pattern="yyyy-MM-dd"/></span>
					<a href="#pdf" class="card-link mt-3 ml-5"><img src="<%= ctxPath%>/resources/images/pdf.png" class="img-fluid" style="width:2.5%;">&nbsp;${lecture_week.lecture_file_name}</a>
				</div>
		</div>
	</c:forEach>

<h3 style="margin-top:10%;">강의 목록</h3>
<hr>
	<c:forEach var="lecture" items="${requestScope.lectureList}">
	<div class="card mb-5">

		<div class="card-header" style="display: flex">
			<h5 style="font-weight:bold;">${lecture.lecture_title}</h5>
			<c:if test="${requestScope.attendanceMap[lecture.lecture_seq]}">
				<span class="badge badge-success d-block, ml-1" style="height: 20px;">수강완료</span>
			</c:if>

		</div>

<%--		<h5 class="card-header" style="font-weight:bold;">${lecture.lecture_title}</h5>--%>
		<div class="card-body">
			<h5 class="card-title">${lecture.lecture_content}</h5>
			<hr>
			<a href="<%= ctxPath%>/student/classPlay.lms" class="card-link"><img src="<%=ctxPath%>/resources/images/play.png" class="img-fluid" style="width:3%;">&nbsp;${lecture.video_file_name}</a>
			<!-- 영상 보는 기간 -->
			<span class="card-text" style="color:orange;"><fmt:formatDate value="${lecture.start_date}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${lecture.end_date}" pattern="yyyy-MM-dd"/></span>
			<a href="#pdf" class="card-link mt-3 ml-5"><img src="<%=ctxPath%>/resources/images/pdf.png" class="img-fluid" style="width:2.5%;">&nbsp;${lecture.lecture_file_name}</a>
		</div>
	</div>
	</c:forEach>
</div>
<div id="target2"></div>



<div class="btns" style="display:inline;">
  	<div class="moveTopBtn" onclick="scrollToTarget_up()"><img src="<%=ctxPath%>/resources/images/btn_up_light.png"></div>
  	<div class="moveDownBtn" onclick="scrollToTarget_down()"><img src="<%=ctxPath%>/resources/images/btn_down_light.png"></div>
</div>







