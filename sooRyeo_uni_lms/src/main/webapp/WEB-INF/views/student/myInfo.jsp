<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
   String ctxPath = request.getContextPath();
%>     

<%-- kakao 우편주소 불러오기용 --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

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

form.profile-form img#profile  {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    background-color: white;
    margin-left: 80%;
    margin-top: 10%;
}

</style>



<div class="container">
  <div class="card mb-3 shadow p-3 mb-5 bg-body-tertiary rounded" style="max-width: 1000px;">
	  <div class="myInfo row g-0 ">
	      <div class="card-body">
	        
			<form action="#" name="studentFrm" method="post" enctype="multipart/form-data" class="profile-form">
				<div class="d-flex">
					<%-- ==== 원래 있는 이미지파일 보여주기 ==== --%>
					<div class="profile">
						<c:if test="${empty sessionScope.loginuser.img_name}"> <%-- 이미지가 없을 경우 --%>
	           				<img id="profile" src="<%=ctxPath%>/resources/images/student.png" alt="Profile Picture">
	           			</c:if>
	           			<c:if test="${not empty sessionScope.loginuser.img_name}"> <%-- 이미지가 있을 경우 --%>
	           				<img id="profile" src="<%=ctxPath%>/resources/files/${sessionScope.loginuser.img_name}" alt="Profile Picture">
	           			</c:if>
					</div>
					<%-- ==== 이미지파일 미리 보여주기 ==== --%>
					<div style="width:25%;" class="prodInputName" ></div>
					<div><img id="previewImg" width="150" style="margin-top: 10%; margin-left:50%;" />
						<input class="form-control" type="file" name="attach" id="formFile" style="margin-top: 10%; margin-left:50%;">
					</div>
				</div>
					
				<div class="card-body">
					<div class="row" style="width:100%; padding-bottom: 5%;">
						<div class="col-sm-6 m-b30 mb-3">
							<label class="form-label">성명</label>
							<input type="text" disabled name="stuName" class="form-control" readonly value="${sessionScope.loginuser.name}">
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
							<c:if test="${requestScope.application_status == 0}">
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
							</c:if>
							<c:if test="${requestScope.application_status == 1}">
								<input type="text" disabled  name="stuStatus4" class="form-control" readonly value="재학 승인 대기중">
							</c:if>
							<c:if test="${requestScope.application_status == 2}">
								<input type="text" disabled  name="stuStatus4" class="form-control" readonly value="휴학 승인 대기중">
							</c:if>
							<c:if test="${requestScope.application_status == 3}">
								<input type="text" disabled  name="stuStatus4" class="form-control" readonly value="졸업 승인 대기중">
							</c:if>
							<c:if test="${requestScope.application_status == 4}">
								<input type="text" disabled  name="stuStatus4" class="form-control" readonly value="자퇴 승인 대기중">
							</c:if>
						</div>
						
						<div class="col-sm-6 m-b30">
							<label class="form-label">생년월일</label> 
							<input type="text" disabled name="stuBirthday" class="form-control" value="${requestScope.member_student.birthday}">
						</div>
	
	                  	<div class="col-sm-6 m-b30">
	                     	<label class="form-label">연락처</label>
	                     	<span class="error">010으로 시작하는 연락처를 입력해주세요.</span>
	                     	<input type="text" id="stuTel" name="tel" class="form-control" value="${requestScope.member_student.tel}">
	                             <%-- 연락처중복체크 --%>
	                             <span id="telcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3 mb-3">연락처 중복확인</button></span>
	                             <span id="telCheckResult"></span>
	                  	</div>
	                  	

						<div class="col-sm-6 m-b30">
							<label class="form-label">이메일</label> 
							<span class="error" id="email_error">이메일 형식에 맞지 않습니다.</span>
							<input type="text" id="stuEmail" name="email" class="form-control" value="${requestScope.member_student.email}">
	                       	<%-- 이메일중복체크 --%>
	                       	<span id="emailcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3 mb-3">이메일 중복확인 </button></span>
	                       	<span id="emailCheckResult"></span>
						</div>

						<div class="col-sm-6 m-b30"> 
                     		<label class="form-label">비밀번호</label>
                     		<span class="error">숫자/문자/특수문자 포함 형태의 8~15자리로 입력해주세요.</span> 
                     		<input type="password" id="stuPwd" name="pwd" class="form-control" />
                   	        <%-- 비밀번호 중복체크 --%>
                            <span id="pwdcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3 mb-3">비밀번호 중복확인</button></span>
                            <span id="pwdCheckResult"></span>
                 		</div>
                 		<div class="col-sm-6 m-b30 mt-3">
	                     	<label class="form-label">주소</label> 
	                     	<span class="error">주소를 입력하세요.</span>
	                     	<input type="text" id="postcode" name="postcode" class="form-control w-25 mb-1" value="${requestScope.member_student.postcode}"/>
	                     	<input type="text" id="address" name="address" class="form-control mb-1"  value="${requestScope.member_student.address}"/>
	                     	<input type="text" id="detailAddress" name="detailAddress" class="form-control mb-1"  value="${requestScope.member_student.detailAddress}"/>
	                     	<input type="text" id="extraAddress" name="extraAddress" class="form-control"  value="${requestScope.member_student.extraAddress}"/>
	                             <%-- 주소 중복체크 --%>
	                             <span id="zipcodeSearch"><button type="button" class="btn btn-outline-success btn-sm mt-3 mb-3">우편번호 찾기</button></span>
	                             <span id="addressCheckResult"></span>
	                  	</div>
					</div>
				</div>
				<div class="card-footer d-flex">
				    <div class="mr-auto">
				    <c:if test="${requestScope.member_student.status != 3 && requestScope.member_student.status != 1 && requestScope.application_status != 1}">
				        <button type="button" class="btn btn-primary" id="updateBtn" onclick="location.href='${pageContext.request.contextPath}/student/application_status.lms?num=1'">복학신청</button>
					</c:if>
				    <c:if test="${requestScope.member_student.status != 3 && requestScope.member_student.status != 2 && requestScope.application_status != 2}">
				        <button type="button" class="btn btn-primary" id="updateBtn" onclick="location.href='${pageContext.request.contextPath}/student/application_status.lms?num=2'">휴학신청</button>
					</c:if>
				    <c:if test="${requestScope.member_student.status != 3 && requestScope.application_status != 3}">
				        <button type="button" class="btn btn-primary" id="updateBtn" onclick="location.href='${pageContext.request.contextPath}/student/application_graduation.lms'">졸업신청</button>
					</c:if>
				    <c:if test="${requestScope.member_student.status != 3 && requestScope.member_student.status != 4 && requestScope.application_status != 4}">
				        <button type="button" class="btn btn-primary" id="updateBtn" onclick="location.href='${pageContext.request.contextPath}/student/application_status.lms?num=4'">자퇴신청</button>
					</c:if>
				    <c:if test="${requestScope.member_student.status == 3}">
				        졸업한 학생은 학적변경이 불가합니다.
					</c:if>
				    </div>
				    <div> 
				        <button type="button" class="btn btn-success" id="updateBtn" onclick="goEdit('<%=ctxPath%>')">수정하기</button>
				        <input type="reset" class="btn btn-danger" value="취소하기" onclick="self.close()" />
				    </div>
				</div>
			</form>
	    	
			
			</div>
	  	</div>
	</div>
</div>


