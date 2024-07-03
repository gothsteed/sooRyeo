<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
   String ctxPath = request.getContextPath();
%>     

<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<%-- 직접만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/student/studentRegister.js"></script>


<style type="text/css">

div#info {
	border: solid 1px red;
	width: 50%;
	margin-left: 45%;
}
span.error {
	color: red;
	font-weight: bold;
	font-size: 9pt;
}

</style>



<div class="container">
  <div class="card mb-3 shadow p-3 mb-5 bg-body-tertiary rounded" style="max-width: 1000px;">
	  <div class="myInfo row g-0 ">
	      <div class="card-body">
	        
			<form action="#" name="updateFrm" method="post" enctype="multipart/form-data" class="profile-form">
				<div class="d-flex">
					<div style="width:15%; height:50px; margin-left:10%; margin-bottom: 10%;">
						<img src="<%=ctxPath%>/resources/images/student.png" class="img-fluid rounded-start" />
					</div>
					<div style="width:25%;" class="prodInputName" style="padding-bottom: 10px; margin-left:5%;"></div>
					<div><img id="previewImg" width="150" />
						<input class="form-control" type="file" name="attach" id="formFile" style="margin-top: 10%;">
					</div>
				</div>
					
				<div class="card-body">
					<div class="row" style="width:100%; padding-bottom: 5%;">
						<div class="col-sm-6 m-b30 mb-3">
							<label class="form-label">성명</label> 
							<span class="error">성명은 필수입력 사항입니다.</span>
							<input type="text" name="stuName" class="form-control" value="${sessionScope.loginuser.name}">
						</div>
						<div class="col-sm-6 m-b30"> 
							<label class="form-label">학년</label> 
							<input type="text" disabled name="stuGrade" class="form-control" readonly value="${requestScope.member_student.grade}">
						</div>
						<div class="col-sm-6 m-b30 mb-3">
							<label class="form-label">학과</label> 
							<input type="text" disabled  name="stuDepartment" class="form-control" readonly value="${requestScope.member_student.department_name}">
						</div>
						<div class="col-sm-6 m-b30">
							<label class="form-label">학적상태</label>
							<c:if test="${requestScope.member_student.status == 1}">
								<input type="text" disabled  name="stuStatus1" class="form-control" readonly value="재학">
							</c:if>
							<c:if test="${requestScope.member_student.status == 2}">
								<input type="text" disabled  name="stuStatus2" class="form-control" readonly value="휴학">
							</c:if>
							<c:if test="${requestScope.member_student.status == 3}">
								<input type="text" disabled  name="stuStatus3" class="form-control" readonly value="졸업">
							</c:if>
							<c:if test="${requestScope.member_student.status == 4}">
								<input type="text" disabled  name="stuStatus4" class="form-control" readonly value="자퇴">
							</c:if>
						</div>
						<div class="col-sm-6 m-b30 mb-3">
							<label class="form-label">생년월일</label> 
							<input type="text" disabled name="stuBirthday" class="form-control" value="${requestScope.member_student.birthday}">
						</div>
						<div class="col-sm-6 m-b30">
							<label class="form-label">연락처</label> 
							<span class="error">올바른 연락처 형식이 아닙니다.</span>
							<div class="d-flex">
	                       		<input type="text" disabled name="hp1" id="hp1" class="form-control" maxlength="3" value="010" style="width:15%;" readonly />&nbsp;-&nbsp; 
	                       		<input type="text" name="hp2" id="hp2" class="form-control" maxlength="4" style="width:15%;" value="${fn:substring(requestScope.member_student.tel, 3, 7)}" />&nbsp;-&nbsp;
	                       		<input type="text" name="hp3" id="hp3" class="form-control" maxlength="4" style="width:15%;" value="${fn:substring(requestScope.member_student.tel, 7, 11)}" />
	                       	</div>   
						</div>
						<div class="col-sm-6 m-b30">
							<label class="form-label">이메일</label> 
							<span class="error" id="email_error">이메일 형식에 맞지 않습니다.</span>
							<input type="text" name="stuEmail" class="form-control" value="${sessionScope.loginuser.email}">
	                       	<%-- 이메일중복체크 --%>
	                       	<span id="emailcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3" onclick="emailcheck('<%=ctxPath%>')">이메일 중복확인 </button></span>
	                       	<span id="emailCheckResult"></span>
						</div>
						<div class="col-sm-6 m-b30">
							<label class="form-label">주소</label> 
							<span class="error">주소를 입력하세요.</span>
							<input type="text" id="stuAddress" name="stuAddress" class="form-control" value="${requestScope.member_student.address}">
						</div>
					</div>
				</div>
				<div class="card-footer" style="padding-left:800px;">
					<button class="btn btn-success" id="updateBtn" onclick="goUpdate('<%=ctxPath%>')">수정하기</button>
				</div>
			</form>
	    	
			
			</div>
	  	</div>
	</div>
</div>


