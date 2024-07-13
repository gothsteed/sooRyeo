<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">
	.a_title:hover {
		color: #d1e0e0;
		cursor: pointer; /* 마우스를 올렸을 때 포인터 모양으로 변경 */
	}
</style>

<script type="text/javascript">
	function formatDateTime(datetime) {
		const date = new Date(datetime);
		const month = (date.getMonth() + 1).toString().padStart(2, '0');
		const day = date.getDate().toString().padStart(2, '0');
		const hours = date.getHours().toString().padStart(2, '0');
		const minutes = date.getMinutes().toString().padStart(2, '0');
		return `\${month}/\${day} \${hours}:\${minutes}`;
	}


	function showDetails(consultId) {
		// Make AJAX call to fetch consult details
		$.ajax({
			url: '<%= ctxPath %>/schedule/detailREST.lms',
			method: 'POST',
			data: { schedule_seq: consultId },
			dataType: "json",
			success: function(response) {
				console.log(response);

				// Populate modal fields
				document.getElementById('studentName').innerText = response.studentName;
				const formattedStartDate = formatDateTime(response.start_date);
				const formattedEndDate = formatDateTime(response.end_date).split(' ')[1]; // only take time part for end date
				document.getElementById('scheduleTime').innerText = `\${formattedStartDate} ~ \${formattedEndDate}`;
				document.getElementById('studentEmail').innerText = response.email; // Decrypt this if necessary
				document.getElementById('content').innerText = response.content;
				document.getElementById('departmentName').innerText = response.departmentName;

				document.querySelector('#detailsModal .btn-primary').setAttribute('data-schedule-seq', consultId);
				document.querySelector('#detailsModal .btn-danger').setAttribute('data-schedule-seq', consultId);

				// Show the modal
				$('#detailsModal').modal('show');
			},
			error: function(error) {
				console.error('Error fetching consult details:', error);
			}
		});
	}

	function approveConsult(button) {
		// Get the current consult ID from a data attribute
		const consultId = button.getAttribute('data-schedule-seq');

		// Prepare the request data
		const requestData = {
			isApproved: true,
			schedule_seq: consultId
		};

		// Make Fetch call to approve consult
		fetch('<%= ctxPath %>/schedule/approveREST.lms', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(requestData)
		})
				.then(response => {
					console.log(response);

					if (!response.ok) {
						response.text().then(errorMsg => {
							throw new Error('오류가 발생했습니다: ' + errorMsg);
						});
					}
					alert('상담이 승인되었습니다.');
					refreshConsultationList();

				})
				.catch(error => {
					console.error('승인도중 오류가 발생했습니다.:', error);
					alert('승인도중 오류가 발생했습니다.: ' + error);
				});
	}

	function cancelConsult(button) {
// Get the current consult ID from a data attribute
		const consultId = button.getAttribute('data-schedule-seq');

		// Prepare the request data
		const requestData = {
			isApproved: false,
			schedule_seq: consultId
		};

		// Make Fetch call to approve consult
		fetch('<%= ctxPath %>/schedule/approveREST.lms', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(requestData)
		})
				.then(response => {
					console.log(response);

					if (!response.ok) {
						response.text().then(errorMsg => {
							throw new Error('오류가 발생했습니다: ' + errorMsg);
						});
					}
					alert('상담이 거절되었습니다');
					refreshConsultationList();

				})
				.catch(error => {
					console.error('거절 중 오류가 발생했습니다.:', error);
					alert('거절 중 오류가 발생했습니다.: ' + error);
				});
	}


	function refreshConsultationList() {
		// Implement this function to reload the table data
		location.reload(); // Simple page reload as a placeholder
	}
</script>

<div class="container">
	<div class="card">
		<div class="card-header" style="text-align: center; background-color: #d1e0e0">
			<h2>상담승인</h2>
		</div>
		<div class="card-body">
			<table class="table">
				<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">학생이름</th>
					<th scope="col">날짜 / 시간</th>
					<th scope="col">이메일</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="consult" items="${requestScope.consultList}" varStatus="status">
					<tr onclick="showDetails(${consult.fk_schedule_seq})">
						<th scope="row">${((requestScope.currentPage - 1) * requestScope.perPageSize) + status.count}</th>
						<td>${consult.student.name}</td>
						<td><script>document.write(formatDateTime('${consult.schedule.start_date}') + ' ~ ' + formatDateTime('${consult.schedule.end_date}').split(' ')[1]);</script></td>
						<td>${consult.student.email}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="pagination justify-content-center">${requestScope.pageBar}</div>
		</div>
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="detailsModal" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="detailsModalLabel">상담 상세 정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p><strong>학생 이름:</strong> <span id="studentName"></span></p>
				<p><strong>날짜 / 시간:</strong> <span id="scheduleTime"></span></p>
				<p><strong>이메일:</strong> <span id="studentEmail"></span></p>
				<p><strong>내용:</strong> <span id="content"></span></p>
				<p><strong>학과:</strong> <span id="departmentName"></span></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="approveConsult(this)" data-schedule-seq="">승인</button>
				<button type="button" class="btn btn-danger" onclick="cancelConsult(this)" data-schedule-seq="">거절</button>
			</div>
		</div>
	</div>
</div>

