<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>커리큘럼</title>
<style>
body {
	font-family: 'Roboto', sans-serif; /* Modern font */
	background-color: #f8f9fa; /* Light grey background */
	color: #343a40; /* Dark grey text */
}

.container {
	max-width: 960px; /* Better width management */
	padding-top: 20px; /* Spacing from top */
}

.card {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
	border: none; /* Remove card border */
	border-radius: 0.5rem; /* Rounded corners */
	overflow: hidden; /* Ensure inner content is not outside the card */
}

.card-header {
	background-color: #d1e0e0; /* Bootstrap primary color */
	color:black;
	padding: 1rem 1.5rem; /* Better padding */
	text-align: center;
}

.card-body {
	padding: 2rem 1.5rem; /* Better padding */
}

.table-hover tbody tr:hover {
	background-color: #e9ecef; /* Hover state for table rows */
	cursor: pointer; /* Indicate row is clickable */
}

.pagination {
	justify-content: center; /* Center pagination */
	margin-top: 20px; /* Spacing after table */
}

.form-control, .btn {
	border-radius: 0.25rem;
	/* Slight rounding of corners for inputs/buttons */
}

.btn-primary {
	background-color: #d1e0e0; /* Bootstrap primary color */
	color:black;
	border-color: #d1e0e0; /* Matching border */
}

label {
	font-weight: 600; /* Bold labels for better readability */
}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
let departmentSelect;
let gradeSelect;
let selectedDepartment = "";
let selectedGrade = "";

function fetchData(pageNum) {
    console.log(pageNum);

    const url = '<%=ctxPath%>' + '/admin/curriculumJSON.lms?fk_department_seq=' + selectedDepartment + '&grade=' + selectedGrade + '&currentPage=' + pageNum;

    console.log(url);

    fetch(url)
        .then(response => response.json())
        .then(data => {
            const tableBody = document.querySelector("table tbody");
            tableBody.innerHTML = "";
            console.log(data);

            data.curriculumList.forEach(function(curriculum) {
                const row = document.createElement("tr");
                row.innerHTML = '<td>' + curriculum.name + '</td>' +
                                '<td>' + (curriculum.department_name==''?'교양':curriculum.department_name) + '</td>' +
                                '<td>' + (typeof curriculum.grade == 'undefined' ?'':curriculum.grade) + '</td>' +
                                '<td>' + curriculum.credit + '</td>' +
                                '<td>' + (curriculum.required == 1 ? 'Yes' : 'No') + '</td>';
                row.addEventListener('click', function() {
                    showUpdateModal(curriculum);
                });
                tableBody.appendChild(row);
            });

            const pagination = document.querySelector(".pagination");
            pagination.innerHTML = data.pageBar;
        })
        .catch(error => console.error("Error fetching data:", error));
}

function handleDepartmentChange() {
    const departmentValue = departmentSelect.value;
    if (departmentValue === "") {
        gradeSelect.disabled = true;
    } else {
        gradeSelect.disabled = false;
    }
}

document.addEventListener("DOMContentLoaded", function() {
    departmentSelect = document.getElementById("department");
    gradeSelect = document.getElementById("grade");

    departmentSelect.addEventListener("change", handleDepartmentChange);
    
    console.log(departmentSelect.value);
    console.log(gradeSelect.value);

    const searchButton = document.getElementById("searchButton");
    searchButton.addEventListener('click', function() {
        selectedDepartment = departmentSelect.value;
        selectedGrade = gradeSelect.value;
        fetchData(1);
    });

    // Fetch initial data
    fetchData(1);
    document.getElementById('deleteButton').addEventListener('click', function() {
        const curriculumId = this.getAttribute('data-id');
        if (confirm("삭제 하시겠습니까?")) {
            deleteCurriculum(curriculumId);
        }
    });
    
    
    document.getElementById('updateButton').addEventListener('click', function() {
        const curriculumId = this.getAttribute('data-id');
        if (confirm("수정하시겠습니까?")) {
            updateCurriculum(curriculumId);
        }
    });

    
});

function showUpdateModal(curriculum) {
    document.getElementById('updateName').value = curriculum.name;
    document.getElementById('updateCredit').value = curriculum.credit;
    document.getElementById('updateRequired').checked = curriculum.required == 1;

    // Set the grade select tag
    var gradeSelect = document.getElementById('updateGrade');
    for (var i = 0; i < gradeSelect.options.length; i++) {
        if (gradeSelect.options[i].value == curriculum.grade) {
            gradeSelect.options[i].selected = true;
            break;
        }
    }

    // Set the department select tag
    var departmentSelect = document.getElementById('department_update');
    
    for (var i = 0; i < departmentSelect.options.length; i++) {
    	
    	
        if (departmentSelect.options[i].value == curriculum.fk_department_seq) {
            departmentSelect.options[i].selected = true;
            break;
        }
    }
    
    // Set the delete button data attribute
    const deleteButton = document.getElementById('deleteButton');
    deleteButton.setAttribute('data-id', curriculum.curriculum_seq);
    
    const curriculum_seq = document.getElementById('curriculum_seq');
    curriculum_seq.value=curriculum.curriculum_seq;

    $('#updateModal').modal('show');
}


function deleteCurriculum(id) {
    console.log("deleting : " + id);

    const url = '<%=ctxPath%>' + '/admin/deleteCurriculumREST.lms?curriculum_seq=' + id;
    fetch(url, { method: 'DELETE' })
        .then(response => {
            console.log(response);
            return response.text();  // Extract the response body as text
        })
        .then(body => {
            alert(body);
            $('#updateModal').modal('hide');
            fetchData(1); // Refresh the data
        })
        .catch(error => {
            console.error("삭제 실패: ", error);
            alert("삭제 실패");
        });
}

<%-- 
function updateCurriculum(id) {
    console.log("update : " + id);

    const url = '<%=ctxPath%>' + '/admin/updateCurriculumREST.lms';
    fetch(url, { method: 'POST' })
        .then(response => {
            console.log(response);
            return response.text();  // Extract the response body as text
        })
        .then(body => {
            alert(body);
            $('#updateModal').modal('hide');
            fetchData(1); // Refresh the data
        })
        .catch(error => {
            console.error("삭제 실패: ", error);
            alert("삭제 실패");
        });
}
 --%>
 function updateCurriculum() {
	    // Get the curriculum_seq from the hidden input field
	    const curriculum_seq = document.getElementById('curriculum_seq').value;

	    // Get the form element
	    const form = document.getElementById('updateForm');

	    // Create a FormData object from the form
	    const formData = new FormData(form);

	    // Convert FormData to a plain object
	    const data = {};
	    formData.forEach((value, key) => {
	        data[key] = value;
	    });

	    // Check the state of the checkbox and set the value
	    const updateRequiredCheckbox = document.getElementById('updateRequired');
	    data.required = updateRequiredCheckbox.checked ? 1 : 0;

	    // Add the curriculum_seq to the data object
	    data.curriculum_seq = curriculum_seq;

	    console.log(data);

	    // Convert the data object to a JSON string
	    const jsonData = JSON.stringify(data);

	    // URL to your update endpoint
	    const url = '<%=ctxPath%>' + '/admin/updateCurriculumREST.lms';

	    // Send the data with fetch
	    fetch(url, {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: jsonData
	    })
	    .then(response => {
	        console.log(response);
	        return response.text();  // Extract the response body as text
	    })
	    .then(body => {
	        alert(body);
	        $('#updateModal').modal('hide');
	        fetchData(1); // Refresh the data
	    })
	    .catch(error => {
	        console.error("업데이트 실패: ", error);
	        alert("업데이트 실패");
	    });
	}





</script>
</head>
<body>
	<div class="container">
		<div class="card">
			<div class="card-header">
				<h2>커리큘럼 검색</h2>
			</div>
			<div class="card-body">
				<form class="mb-4">
					<div class="form-row">
						<div class="form-group col-md-5">
							<label for="department">학과</label> <select id="department" name="department" class="form-control">
								<option value="">교양</option>
								<c:forEach items="${departments}" var="department">
									<option value="${department.department_seq}" ${department.department_seq == selectedDepartment ? 'selected' : ''}>${department.department_name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group col-md-5">
							<label for="grade">학년</label> <select id="grade" name="grade" class="form-control">
								<option value="">--학년 선택--</option>
								<option value="1" ${"1".equals(selectedGrade) ? "selected" : ""}>1</option>
								<option value="2" ${"2".equals(selectedGrade) ? "selected" : ""}>2</option>
								<option value="3" ${"3".equals(selectedGrade) ? "selected" : ""}>3</option>
								<option value="4" ${"4".equals(selectedGrade) ? "selected" : ""}>4</option>
							</select>
						</div>
						<div class="form-group col-md-2 d-flex align-items-end">
							<button type="button" class="btn btn-primary" id="searchButton">검색</button>
						</div>
					</div>
				</form>

				<table class="table table-bordered table-hover" id="curri_table">
					<thead class="thead-light">
						<tr>
							<th>강의 이름</th>
							<th>학과</th>
							<th>학년</th>
							<th>이수 학점</th>
							<th>필수 여부</th>
						</tr>
					</thead>
					<tbody>
						<%-- <c:forEach items="${curriculums}" var="curriculum">
                        <tr>
                            <td>${curriculum.name}</td>
                            <td>${curriculum.department.name}</td>
                            <td>${curriculum.grade}</td>
                            <td>${curriculum.credit}</td>
                            <td>${curriculum.required == 1 ? 'Yes' : 'No'}</td>
                        </tr>
                    </c:forEach> --%>
					</tbody>
				</table>

				<!-- Pagination -->
				<nav>
					<ul class="pagination">
						<%-- <c:if test="${pageNum != 1}">
                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/curriculumList?department=${selectedDepartment}&grade=${selectedGrade}&page=${pageNum-1}">Previous</a></li>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == pageNum ? 'active' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/curriculumList?department=${selectedDepartment}&grade=${selectedGrade}&page=${i}">${i}</a></li>
                    </c:forEach>
                    <c:if test="${pageNum != totalPages}">
                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/curriculumList?department=${selectedDepartment}&grade=${selectedGrade}&page=${pageNum+1}">Next</a></li>
                    </c:if> --%>
					</ul>
				</nav>
			</div>
		</div>
	</div>

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">강의 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="updateForm">
                    <div class="form-group">
                        <label for="updateName">강의 이름</label>
                        <input type="text" class="form-control" id="updateName" name="name">
                    </div>
                    <div class="form-group">
                        <label for="department_update">학과</label>
                        <select id="department_update" name="department_seq" class="form-control">
                            <option value="">교양</option>
                            <c:forEach items="${departments}" var="department">
                                <option value="${department.department_seq}">${department.department_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="updateGrade">학년</label>
                        <select id="updateGrade" name="grade" class="form-control">
                            <option value="">--학년 선택--</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="updateCredit">이수 학점</label>
                        <input type="number" class="form-control" id="updateCredit" name="credit">
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="updateRequired" name="required">
                        <label class="form-check-label" for="updateRequired">필수 여부</label>
                    </div>
                    <input type="hidden" id="curriculum_seq" value=""/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="updateButton" data-id="">저장</button>
                <button type="button" class="btn btn-danger" id="deleteButton" data-id="">삭제</button>
            </div>
        </div>
    </div>
</div>

	<!-- Include jQuery before Bootstrap JavaScript -->
</body>
</html>
