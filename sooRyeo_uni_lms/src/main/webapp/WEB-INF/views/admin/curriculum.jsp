<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>커리큘럼</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
        box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Subtle shadow for depth */
        border: none; /* Remove card border */
        border-radius: 0.5rem; /* Rounded corners */
        overflow: hidden; /* Ensure inner content is not outside the card */
    }
    .card-header {
        background-color: #d1e0e0; /* Bootstrap primary color */
        color: white; /* White text */
        padding: 1rem 1.5rem; /* Better padding */
        text-align: center;
    }
    .card-body {
        padding: 2rem 1.5rem; /* Better padding */
    }
    .table-hover tbody tr:hover {
        background-color: #e9ecef; /* Hover state for table rows */
    }
    .pagination {
        justify-content: center; /* Center pagination */
        margin-top: 20px; /* Spacing after table */
    }
    .form-control, .btn {
        border-radius: 0.25rem; /* Slight rounding of corners for inputs/buttons */
    }
    .btn-primary {
        background-color: #d1e0e0; /* Bootstrap primary color */
        border-color: #007bff; /* Matching border */
    }
    label {
        font-weight: 600; /* Bold labels for better readability */
    }
</style>

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
                console.log(curriculum.name);
                console.log(curriculum.department_name);
                row.innerHTML = '<td>' + curriculum.name + '</td>' +
                                '<td>' + curriculum.department_name + '</td>' +
                                '<td>' + curriculum.grade + '</td>' +
                                '<td>' + curriculum.credit + '</td>' +
                                '<td>' + (curriculum.required == 1 ? 'Yes' : 'No') + '</td>';
                tableBody.appendChild(row);
            });

            const pagination = document.querySelector(".pagination");
            pagination.innerHTML = data.pageBar;
        })
        .catch(error => console.error("Error fetching data:", error));
}

document.addEventListener("DOMContentLoaded", function() {
    departmentSelect = document.getElementById("department");
    gradeSelect = document.getElementById("grade");

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
});

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
                        <label for="department">학과</label>
                        <select id="department" name="department" class="form-control">
                            <option value="">--학과 선택--</option>
                            <c:forEach items="${departments}" var="department">
                                <option value="${department.department_seq}" ${department.department_seq == selectedDepartment ? 'selected' : ''}>${department.department_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group col-md-5">
                        <label for="grade">학년</label>
                        <select id="grade" name="grade" class="form-control">
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
                        <th>강이 이름</th>
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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
