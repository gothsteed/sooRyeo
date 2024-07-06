<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>


<style type="text/css">
.subject-container {
	width: 100%;
	height: 300px; /* 원하는 높이로 설정 */
	overflow-x: auto;
	overflow-y: auto;
}

#top_container {
	border: solid 0px gray;
}

#bottom_container {
	border: solid 0px gray;
}

#total_container {
	border: solid 0px black;
}

#right_top_card {
	width: 90%;
}

#left_top_card {
	width: 90%;
}

th {
	text-align: center;
}

#time_table th, #time_table td {
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	width: 100px;
	padding: 5px;
	height: 20px;
	text-align: center;
}

.ml-n1 {
	margin-left: -2.5rem !important;
}

.pagination {
	justify-content: center;
}
</style>


<script>

/**
 * 
 */
 
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
                row.innerHTML = '<td> <input type="radio" name="curriculum_seq" value="${curriculum.curriculum_seq}"> </td>' +
                				'<td>' + curriculum.name + '</td>' +
                                '<td>' + (curriculum.department_name==''?'교양':curriculum.department_name) + '</td>' +
                                '<td>' + (typeof curriculum.grade == 'undefined' ?'':curriculum.grade) + '</td>' +
                                '<td>' + curriculum.credit + '</td>' +
                                '<td>' + (curriculum.required == 1 ? 'Yes' : 'No') + '</td>';

                tableBody.appendChild(row);
            });

            const pagination = document.querySelector(".pagination");
            pagination.innerHTML = data.pageBar;
        })
        .catch(error => console.error("Error fetching data:", error));
}



function fetchProfTimeTable(prof_id) {

    const url = '<%=ctxPath%>' + '/admin/profTimetableJSON.lms?prof_id=' + prof_id;

    console.log(url);

    fetch(url)
        .then(response => response.json())
        .then(data => {

			console.log(data);

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
    handleDepartmentChange();
    
    
    
    const profSearchButton = document.getElementById("profSearchButton");
    profSearchButton.addEventListener('click', function() {

    	let profId = document.getElementById("professor-search").value;
    	console.log(profId)
    	fetchProfTimeTable(profId)

    });


    
});









</script>

<div class="justify-content-center" id="total_container">
	<div class="row justify-content-center" id="top_container">
		<div class="card col-md-6 pl-0 pr-0" id="left_top_card">
			<div class="card-header">
				<h3>커리큘럼 검색</h3>
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
							<th>선택</th>
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



		<div class="card col-md-5 ml-2" id="right_top_card">
			<div class="card-header row">
				<div class="col-md-5 h3 pl-0 pr-0">교수 검색</div>
				<div class="col-md-5 ml-auto">
					<input id="professor-search" class="form-control" placeholder="교번을 입력하시오">
				</div>
				<div class="col-md-2 ml-auto">
					<button type="button" class="btn btn-primary" id="profSearchButton">검색</button>
				</div>
				
			</div>
			<div class="card-body">
				<!-- time_table start -->
				<table class="table table-bordered table-hover table-responsive-md" id="time_table">
					<caption>수려대학교 시간표</caption>
					<thead class="thead-light">
						<tr>
							<th></th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>1교시</th>
							<td style="background: Plum;">문화와 역사2</td>
							<td></td>
							<td style="background: LavenderBlush;" rowspan="2">정보통신융합공학개론</td>
							<td style="background: Pink;" rowspan="2">화일구조</td>
							<td style="background: LightGoldenRodYellow;" rowspan="2">참삶의길</td>
						</tr>
						<tr>
							<th>2교시</th>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>3교시</th>
							<td></td>
							<td></td>
							<td style="background: LightCyan;" rowspan="2">프로그래밍언어구조론</td>
							<td style="background: Lavender;" rowspan="2">웹/xml프로그래밍</td>
							<td></td>
						</tr>
						<tr>
							<th>4교시</th>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>5교시</th>
							<td style="background: Lavender;" rowspan="2">웹/xml프로그래밍</td>
							<td style="background: Salmon;" rowspan="4">c++</td>
							<td style="background: MintCream;" rowspan="4">임베디드프로그래밍실습</td>
							<td style="background: Wheat;" rowspan="4">리눅스컴퓨팅실무</td>
							<td></td>
						</tr>
						<tr>
							<th>6교시</th>
							<td></td>
						</tr>
						<tr>
							<th>7교시</th>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>8교시</th>
							<td style="background: LightCyan;">프로그래밍언어구조론</td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<!-- time_table end -->
			</div>
		</div>

	</div>

	<br>

	<div class="row justify-content-center" id="bottom_container">
		<div class="card col-md-11 ">
			<div class="card-header d-flex justify-content-between align-items-center">
				<h4 class="align-middle">개설신청</h4>
				<div>
					<button type="button" class="btn btn-primary">나의신청현황</button>
					<button type="button" class="btn btn-success">강의계획서</button>
					<button type="button" class="btn btn-danger">신청</button>
				</div>
			</div>
			<div class="card-body">
				<div class="row mb-2">
					<div class="col-md-1">교수명</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">소속학과</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">교번</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">연락처</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
				</div>
				<div class="row mb-2">
					<div class="col-md-1">교과목명</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">과목코드</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">대상학년</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">수업구분</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
				</div>
				<div class="row mb-2">
					<div class="col-md-1">시수</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">학점</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">개설연도</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">개설학기</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
				</div>
				<div class="row mb-2">
					<div class="col-md-1">시작교시</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
					<div class="col-md-1">강의요일</div>
					<div class="col-md-2 ml-n1 mr-4">
						<input type="text" readonly class="form-control" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>