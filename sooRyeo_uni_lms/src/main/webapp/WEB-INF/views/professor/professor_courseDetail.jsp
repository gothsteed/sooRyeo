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

.btns {
  display: flex;
  position: fixed;
  right: 150px;
  bottom: 200px;
}

.table-container {
    max-height: 300px; 
    overflow-y: auto; 
}

.table-hover tbody tr:hover {
    background-color: #f5f5f5; 
}


.btn-modern {
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	font-weight: 500;
	transition: all 0.3s ease;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.btn-edit {
	background-color: #3498db;
	color: white;
}

.btn-edit:hover {
	background-color: #2980b9;
}

.btn-delete {
	background-color: #e74c3c;
	color: white;
}

.btn-delete:hover {
	background-color: #c0392b;
}

.btn-modern:active {
	transform: translateY(1px);
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}



</style>

<script type="text/javascript">

$(document).ready(function(){
	
	const course_seq = "${requestScope.fk_course_seq}";	



	
});// end of $(document).ready(function() 

function goLectureNotice(){
	
	location.href = "<%=ctxPath%>/board/lecture_notice.lms?fk_course_seq="+${requestScope.fk_course_seq};
	
}


function scrollToTarget_up() {
	
    var target = document.getElementById('target');
    target.scrollIntoView({ behavior: 'smooth' });
    
}// end of function scrollToTarget_up() 


function scrollToTarget_down() {
	
    var target = document.getElementById('target2');
    target2.scrollIntoView({ behavior: 'smooth' });
    
}// end of function scrollToTarget_down() 

// Function Declaration ////////////////////

	
	function goTest(){
		location.href = "<%=ctxPath%>/professor/exam.lms?course_seq="+${fk_course_seq};
	}// end of function goAnnouncement() 
	
	
	function goAssignment(){
		
		location.href = "<%=ctxPath%>/professor/assignment.lms?course_seq="+${fk_course_seq}; // 페이지 이동
		
	}// end of function goAssignment()


function goUpload() {
	var form = document.createElement('form');
	form.method = 'POST';
	form.action = "<%=ctxPath%>/professor/courseUpload.lms";

	var input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'course_seq';
	input.value = "${fk_course_seq}";  // Ensure this is properly set with the server-side variable

	form.appendChild(input);
	document.body.appendChild(form);
	form.submit();
}
function editLecture(lectureSeq) {
	window.location.href = '<%=ctxPath%>/professor/editLecture.lms?lecture_seq=' + lectureSeq;
}

function deleteLecture(lectureSeq) {
	if (confirm('강의를 삭제 하시겠습니까?')) {
		$.ajax({
			url: '<%=ctxPath%>/professor/deleteLectureREST.lms',
			type: 'POST',
			data: { lecture_seq: lectureSeq },
			success: function(response) {
				alert('강의가 삭제되었습니다.');
				location.reload();
			},
			error: function(xhr, status, error) {
				let message = '오류 발생 : ' + error;

				if (xhr.status === 400) {
					message = '잘못된 요청입니다. 다시 시도해 주세요.';
				} else if (xhr.status === 401) {
					message = '로그인이 필요합니다.';
				} else if (xhr.status === 403) {
					message = '권한이 없습니다.';
				} else if (xhr.status === 404) {
					message = '강의를 찾을 수 없습니다.';
				} else if (xhr.status === 500) {
					message = '서버 오류가 발생하였습니다. 다시 시도해 주세요.';
				}

				alert(message);
			}
		});
	}
}



</script>

<div class="container mt-5">
<h3>강의 개요</h3>
<input type="hidden" name="course_seq" value=""/>
<hr>
	<div class="card-body" style="">
		<button type="button" class="btn btn-outline-light" style="width:20%; height:150px;" onclick="goLectureNotice()">
			<img src="<%=ctxPath%>/resources/images/annoucement.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="annoucement" style="color:black; font-weight: bold;">공지사항</span>
			<br>
		</button> 	
		<button type="button" class="btn btn-outline-light ml-5" id="announcement" style="width:20%; height:150px;" onclick="goTest()">
			<img src="<%=ctxPath%>/resources/images/test.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="exam" style="color:black; font-weight: bold;">시험</span>
			<br>
		</button> 	
		<button type="button" class="btn btn-outline-light ml-5" id="assignment" style="width:20%; height:150px;" onclick="goAssignment()">
			<img src="<%=ctxPath%>/resources/images/tasks.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="tasks" style="color:black; font-weight: bold;">과제</span>
			<br>
		</button>

		<button type="button" class="btn btn-outline-light ml-5" id="assignment" style="width:20%; height:150px;" onclick="goUpload()">
			<img src="<%=ctxPath%>/resources/images/lecture_upload_icon.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="upload" style="color:black; font-weight: bold;">수업 업로드</span>
			<br>
		</button>
		<div class="table-container mt-3">
			<table class="table table-hover">
				<thead>
					<tr class="table-success">
						<th>학번</th>
						<th>이름</th>
						<th>학년</th>
						<th>학과</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty requestScope.studentList}">
					<c:forEach var="student" items="${requestScope.studentList}" varStatus="status">
					<tr>
						<td>${student.student_id}</td>
						<td>${student.name}</td>
						<td>${student.grade}</td>
						<td>${student.department_name}</td>
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty requestScope.studentList}">
					<tr>
						<td colspan="3">수강생이 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
			<div class="pagination justify-content-center">${requestScope.pageBar}</div>
		</div>

		<br>
		<br>

		<c:forEach var="lecture" items="${requestScope.lectureList}">
			<div class="card mb-5">
				<div class="card-header d-flex justify-content-between align-items-center">
					<h5 class="mb-0" style="font-weight:bold;">${lecture.lecture_title}</h5>
					<div>
						<button type="button" class="btn btn-modern btn-edit mr-2" onclick="editLecture(${lecture.lecture_seq})">수정</button>
						<button type="button" class="btn btn-modern btn-delete" onclick="deleteLecture(${lecture.lecture_seq})">삭제</button>
					</div>
				</div>

				<div class="card-body">
					<h5 class="card-title">${lecture.lecture_content}</h5>
					<hr>
					<a href="<%= ctxPath%>/professor/classPlay.lms?lecture_seq=${lecture.lecture_seq}" class="card-link">
						<img src="<%=ctxPath%>/resources/images/play.png" class="img-fluid" style="width:3%;">&nbsp;${lecture.video_file_name}
					</a>
					<!-- 영상 보는 기간 -->
					<span class="card-text" style="color:orange;">
						<fmt:formatDate value="${lecture.start_date}" pattern="yyyy-MM-dd"/> ~
						<fmt:formatDate value="${lecture.end_date}" pattern="yyyy-MM-dd"/>
            		</span>
					<c:if test="${empty lecture.lecture_file_name}">
						<span class="card-link mt-3 ml-5">
							첨부파일이 없습니다.
						</span>
					</c:if>
					<c:if test="${not empty lecture.lecture_file_name}">
						<a href="<%= ctxPath%>/professor/pdf_download.lms?lecture_file_name=${lecture.lecture_file_name}&upload_lecture_file_name=${lecture.upload_lecture_file_name}" class="card-link mt-3 ml-5">
							<img src="<%=ctxPath%>/resources/images/pdf.png" class="img-fluid" style="width:2.5%;">&nbsp;${lecture.lecture_file_name}
						</a>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="btns" style="display:inline;">
  	<div class="moveTopBtn" onclick="scrollToTarget_up()"><img src="<%=ctxPath%>/resources/images/btn_up_light.png"></div>
  	<div class="moveDownBtn" onclick="scrollToTarget_down()"><img src="<%=ctxPath%>/resources/images/btn_down_light.png"></div>
</div>

