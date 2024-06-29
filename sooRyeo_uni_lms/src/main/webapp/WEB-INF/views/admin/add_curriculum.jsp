<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Curriculum Addition</title>
<style>
.card {
	max-width: 600px;
	margin: 20px auto;
	border: none;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

.form-group label {
	font-weight: bold;
}

.btn-primary {
	width: 100%;
	padding: 10px;
	font-size: 16px;
}
</style>
</head>
<body>
	<div class="card">
		<h5 class="card-header text-center">커리큘럼 추가</h5>
		<div class="card-body">
			<form action="<%=ctxPath%>/admin/add_curriculum_end.lms" method="post">
				<div class="form-group row">
					<label for="fk_department_seq" class="col-sm-4 col-form-label">학과</label>
					<div class="col-sm-8">
						<select class="form-control" name="fk_department_seq">
							<option value = "">교양</option>
							<c:forEach var="major" items="${requestScope.departments}" varStatus="status">
								<option value="${major.department_seq}">${major.department_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<hr>

				<div class="form-group row">
					<label for="name" class="col-sm-4 col-form-label">강의 이름</label>
					<div class="col-sm-8">
						<input type="text" id="name" name="name" class="form-control" placeholder="강의 이름 입력">
					</div>
				</div>
				<hr>

				<div class="form-group row">
					<label for="grade" class="col-sm-4 col-form-label">학년</label>
					<div class="col-sm-8">
						<select class="form-control" name="grade">
							<option></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
					</div>
				</div>
				<hr>

				<div class="form-group row">
					<label for="credit" class="col-sm-4 col-form-label">학점</label>
					<div class="col-sm-8">
						<input type="text" id="credit" name="credit" class="form-control" placeholder="이수 학점 입력">
					</div>
				</div>
				<hr>

				<div class="form-group row">
					<label for="required" class="col-sm-4 col-form-label">필수여부</label>
					<div class="col-sm-8">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" id="requiredTrue" name="required" value="1"> <label class="form-check-label" for="requiredTrue">필수</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" id="requiredFalse" name="required" value="0"> <label class="form-check-label" for="requiredFalse">선택</label>
						</div>
					</div>
				</div>

				<button type="submit" class="btn btn-primary">개설신청하기</button>
			</form>
		</div>
	</div>
</body>