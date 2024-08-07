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

		.error {
			color: red;
			font-size: 0.9em;
			margin-top: 5px;
		}
	</style>
</head>
<body>
<div class="card">
	<h5 class="card-header text-center">커리큘럼 추가</h5>
	<div class="card-body">
		<form id="curriculumForm" action="/admin/add_curriculum_end.lms" method="post" onsubmit="return validateForm()">
			<div class="form-group row">
				<label for="fk_department_seq" class="col-sm-4 col-form-label">학과</label>
				<div class="col-sm-8">
					<select class="form-control" name="fk_department_seq" id="fk_department_seq">
						<option value="">교양</option>
						<!-- Departments would be populated here -->
					</select>
				</div>
			</div>

			<hr>

			<div class="form-group row">
				<label for="name" class="col-sm-4 col-form-label">강의 이름</label>
				<div class="col-sm-8">
					<input type="text" id="name" name="name" class="form-control" placeholder="강의 이름 입력">
					<div id="nameError" class="error"></div>
				</div>
			</div>
			<hr>

			<div class="form-group row">
				<label for="grade" class="col-sm-4 col-form-label">학년</label>
				<div class="col-sm-8">
					<select class="form-control" name="grade" id="grade">
						<option value="">선택하세요</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
					</select>
					<div id="gradeError" class="error"></div>
				</div>
			</div>
			<hr>

			<div class="form-group row">
				<label for="credit" class="col-sm-4 col-form-label">학점</label>
				<div class="col-sm-8">
					<input type="text" id="credit" name="credit" class="form-control" placeholder="이수 학점 입력">
					<div id="creditError" class="error"></div>
				</div>
			</div>
			<hr>

			<div class="form-group row">
				<label for="required" class="col-sm-4 col-form-label">필수여부</label>
				<div class="col-sm-8">
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" id="requiredTrue" name="required" value="1">
						<label class="form-check-label" for="requiredTrue">필수</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" id="requiredFalse" name="required" value="0">
						<label class="form-check-label" for="requiredFalse">선택</label>
					</div>
					<div id="requiredError" class="error"></div>
				</div>
			</div>

			<button type="submit" class="btn btn-primary">개설신청하기</button>
		</form>
	</div>
</div>

<script>
	function validateForm() {
		let isValid = true;
		const name = document.getElementById('name').value.trim();
		const grade = document.getElementById('grade').value;
		const credit = document.getElementById('credit').value.trim();
		const required = document.querySelector('input[name="required"]:checked');

		// Validate name
		if (name === '') {
			document.getElementById('nameError').textContent = '강의 이름을 입력해주세요.';
			isValid = false;
		} else {
			document.getElementById('nameError').textContent = '';
		}

		// Validate grade
		if (grade === '') {
			document.getElementById('gradeError').textContent = '학년을 선택해주세요.';
			isValid = false;
		} else {
			document.getElementById('gradeError').textContent = '';
		}

		// Validate credit
		if (credit === '') {
			document.getElementById('creditError').textContent = '학점을 입력해주세요.';
			isValid = false;
		} else if (isNaN(credit) || credit < 1 || credit > 5) {
			document.getElementById('creditError').textContent = '유효한 학점을 입력해주세요 (1-5).';
			isValid = false;
		} else {
			document.getElementById('creditError').textContent = '';
		}

		// Validate required
		if (!required) {
			document.getElementById('requiredError').textContent = '필수 여부를 선택해주세요.';
			isValid = false;
		} else {
			document.getElementById('requiredError').textContent = '';
		}

		return isValid;
	}
</script>
</body>
</html>