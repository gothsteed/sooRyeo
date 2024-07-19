<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">
	.a_title:hover {
		color: #d1e0e0;
		cursor: pointer;
	}
	.start-consult-btn {
		background-color: #4CAF50;
		border: none;
		color: white;
		padding: 5px 10px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 16px;
		margin: 4px 2px;
		cursor: pointer;
	}
	.container {
		display: flex;
		justify-content: space-between;
	}
	.main-content {
		width: 75%;
	}
	.side-panel {
		width: 23%;
		background-color: #f1f1f1;
		padding: 15px;
		border-radius: 5px;
	}
	.chat-room {
		margin-bottom: 10px;
		padding: 10px;
		background-color: white;
		border-radius: 5px;
		box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
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

	function startConsult(consultId) {
		const formData = new FormData();
		formData.append('schedule_seq', consultId);

		fetch('<%= ctxPath %>/chat/start.lms', {
			method: 'POST',
			body: formData
		})
				.then(response => {
					if (!response.ok) {
						return response.text().then(errorMsg => {
							throw new Error('오류가 발생했습니다: ' + errorMsg);
						});
					}
					return response.text();
				})
				.then(successMessage => {
					alert(successMessage);
					loadCurrentChatRooms();  // Reload chat rooms after starting a new one
				})
				.catch(error => {
					console.error('승인도중 오류가 발생했습니다.:', error);
					alert('승인도중 오류가 발생했습니다.: ' + error.message);
				});
	}

	function loadCurrentChatRooms() {
		fetch('<%= ctxPath %>/chat/currentChatRoomREST.lms', {
			method: 'POST'
		})
				.then(response => response.json())
				.then(rooms => {
					const sidePanel = document.getElementById('currentChatRooms');
					sidePanel.innerHTML = '';
					rooms.forEach(room => {
						console.log(room)
						const roomElement = document.createElement('div');
						roomElement.className = 'chat-room';

						const strongElement = document.createElement('strong');
						strongElement.textContent = room.studentName;
						roomElement.appendChild(strongElement);

						roomElement.appendChild(document.createElement('br'));

						sidePanel.appendChild(roomElement);
					});
				})
				.catch(error => console.error('Failed to load chat rooms:', error));
	}

	// Load chat rooms when the page loads
	window.onload = loadCurrentChatRooms;
</script>

<div class="container">
	<div class="main-content">
		<div class="card">
			<div class="card-header" style="text-align: center; background-color: #d1e0e0">
				<h2>상담 스케줄</h2>
			</div>
			<div class="card-body">
				<table class="table">
					<thead>
					<tr>
						<th scope="col">NO</th>
						<th scope="col">학생이름</th>
						<th scope="col">날짜 / 시간</th>
						<th scope="col">이메일</th>
						<th scope="col">상담 시작</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="consult" items="${requestScope.consultList}" varStatus="status">
						<tr>
							<th scope="row">${((requestScope.currentPage - 1) * requestScope.perPageSize) + status.count}</th>
							<td>${consult.student.name}</td>
							<td><script>document.write(formatDateTime('${consult.schedule.start_date}') + ' ~ ' + formatDateTime('${consult.schedule.end_date}').split(' ')[1]);</script></td>
							<td>${consult.student.email}</td>
							<td><button class="start-consult-btn" onclick="startConsult(${consult.fk_schedule_seq}); event.stopPropagation();">상담시작</button></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<div class="pagination justify-content-center">${requestScope.pageBar}</div>
			</div>
		</div>
	</div>
	<div class="side-panel">
		<h3>현재 진행 중인 상담</h3>
		<div id="currentChatRooms">
			<!-- Current chat rooms will be loaded here -->
		</div>
	</div>
</div>