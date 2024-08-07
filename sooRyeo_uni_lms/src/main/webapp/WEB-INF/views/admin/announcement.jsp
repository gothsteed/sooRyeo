<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">

.a_title:hover {
    color: #86acac;
    cursor: pointer; /* 마우스를 올렸을 때 포인터 모양으로 변경 */
}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("input.form-control").keyup(function(key){
		    if(key.keyCode == 13) {
		    	goSearch(); 
		    }
		 });
	});


	function goView(announcement_seq){
		const goBackURL = "${requestScope.goBackURL}";
		
		const frm = document.goViewFrm;
		frm.seq.value = announcement_seq;
		frm.goBackURL.value = goBackURL;
		
		frm.method = "post";
		frm.action = "<%= ctxPath %>/board/announcementView.lms";
		frm.submit();
	}

	// 첫 번째 입력 필드 값이 변경될 때 두 번째 searchWord 입력 필드에 실시간으로 반영하는 함수
	function updateSearchWord(value) {
		document.getElementsByName("searchWord")[0].value = value;
	}

	function goSearch(){
		const frm = document.goViewFrm;
		<%-- frm.method = "get"; --%>						 <%-- 이거 두개 빼면  --%>
		<%-- frm.action = "<%= ctxPath%>/list.action"; --%>  <%-- 자기페이지로 간다. --%>
		frm.submit();
	}// end of function goSearch(){}--------------------------------------------
	
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
				<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" oninput="updateSearchWord(this.value)">
				&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-primary btn-sm"  onclick="goSearch()">검색하기</button>
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
			  
			  <c:forEach var="fix" items="${requestScope.staticList}" varStatus="status"  begin="0" end="4">    
			    <tr style="background-color: #d1e0e0;">
			      <th scope="row" style="font-weight: bold; color: red;">♬</th>
			      <td><span type="button" class="a_title" onclick="goView('${fix.announcement_seq}')">${fix.a_title}</span></td>
			      <td>${fix.writeday}</td>
			      <td>${fix.viewcount}</td>
			    </tr>
			  </c:forEach>  
			  
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

<form name="goViewFrm">
	<input type="hidden" name="seq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchWord" value="${searchWord}"/>  
</form>
