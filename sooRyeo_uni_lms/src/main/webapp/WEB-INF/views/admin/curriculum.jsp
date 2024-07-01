<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>커리큘럼</title>
<style>
    body {
        font-family: 'Arial', sans-serif; /* Modern font */
    }
    .container {
        max-width: 960px; /* Better width management */
    }
    .card {
        box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Subtle shadow for depth */
        margin-top: 20px; /* Spacing from top */
    }
    .table-hover tbody tr:hover {
        background-color: #f5f5f5; /* Hover state for table rows */
    }
    .pagination {
        justify-content: center; /* Center pagination */
        margin-top: 20px; /* Spacing after table */
    }
    .form-control, .btn {
        border-radius: 0.25rem; /* Slight rounding of corners for inputs/buttons */
    }
    .btn-primary {
        background-color: #0056b3; /* Updated primary color */
    }
    label {
        font-weight: 600; /* Bold labels for better readability */
    }
</style>
</head>
<body>
<div class="container mt-3">
    <div class="card">
        <div class="card-header text-center">
            <h2>커리큐럼 검색</h2>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/curriculumList" method="get" class="mb-4">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="department">Select Department:</label>
                        <select id="department" name="department" class="form-control" onchange="this.form.submit()">
                            <option value="">--Select--</option>
                            <c:forEach items="${departments}" var="department">
                                <option value="${department.department_seq}" ${department.department_seq == selectedDepartment ? 'selected' : ''}>${department.department_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="grade">Select Grade:</label>
                        <select id="grade" name="grade" class="form-control" onchange="this.form.submit()">
                            <option value="">--Select--</option>
                            <option value="1" ${"1".equals(selectedGrade) ? "selected" : ""}>1</option>
                            <option value="2" ${"2".equals(selectedGrade) ? "selected" : ""}>2</option>
                            <option value="3" ${"3".equals(selectedGrade) ? "selected" : ""}>3</option>
                            <option value="4" ${"4".equals(selectedGrade) ? "selected" : ""}>4</option>
                        </select>
                    </div>
                </div>
            </form>

            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>Curriculum Name</th>
                        <th>Grade</th>
                        <th>Credit</th>
                        <th>Required</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${curriculums}" var="curriculum">
                        <tr>
                            <td>${curriculum.name}</td>
                            <td>${curriculum.grade}</td>
                            <td>${curriculum.credit}</td>
                            <td>${curriculum.required == 1 ? 'Yes' : 'No'}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <nav>
                <ul class="pagination">
                    <c:if test="${pageNum != 1}">
                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/curriculumList?department=${selectedDepartment}&grade=${selectedGrade}&page=${pageNum-1}">Previous</a></li>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == pageNum ? 'active' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/curriculumList?department=${selectedDepartment}&grade=${selectedGrade}&page=${i}">${i}</a></li>
                    </c:forEach>
                    <c:if test="${pageNum != totalPages}">
                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/curriculumList?department=${selectedDepartment}&grade=${selectedGrade}&page=${pageNum+1}">Next</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
