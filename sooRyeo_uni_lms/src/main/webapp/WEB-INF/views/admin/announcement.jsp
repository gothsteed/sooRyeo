<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

.a_title:hover {
    color: #d1e0e0;
    cursor: pointer; /* 마우스를 올렸을 때 포인터 모양으로 변경 */
}

</style>

<script type="text/javascript">

	function goView(announcement_seq){
		
	}
	
	

</script>

<div class="container">
    <div class="card">
        <div class="card-header" style="text-align: center; background-color: #d1e0e0">
            <h2>학사 공지사항</h2>
        </div>
        <div class="card-body">
			<div class="input-group input-group-sm mb-3" style="width: 35%;">
				 <div class="input-group-prepend">
				   <label class="input-group-text" for="inputGroupSelect01">제목검색</label>
				 </div>
				<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
				&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-primary btn-sm">검색하기</button>
			</div>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">NO</th>
			      <th scope="col">제목</th>
			      <th scope="col">날짜 / 시간</th>
			      <th scope="col">조회수</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach var="list" items="${requestScope.announcementList}" varStatus="status">    
			    <tr>
			      <th scope="row">${((requestScope.currentPage- 1) * requestScope.perPageSize) + status.count}</th>
			      <td><span type="button" class="a_title" onclick="goView('${list.announcement_seq}')">${list.a_title}</span></td>
			      <td>${list.writeday}</td>
			      <td>${list.viewcount}</td>
			    </tr>
              </c:forEach>
			  </tbody>
			</table>
			<div class="pagination justify-content-center">${requestScope.pageBar}</div>
		</div>
	</div>
</div>
