<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	// Function Declaration
	function goView(seq){
		const goBackURL = "${requestScope.goBackURL}";
		
		const frm = document.goViewFrm
		frm.seq.value = seq;
		frm.goBackURL.value = goBackURL;
		
		frm.method = "post";
		frm.action = "<%= ctxPath%>/board/lecture_notice_view_2.lms";
		frm.submit();
		
	}// end of function goView('${boardvo.seq}'){}-----------------------------------------

	function goDel(){
		
		if(confirm("정말로 삭제하시겠습니까?")){
			const frm = document.Del
	
			frm.method = "post";
			frm.action = "<%= ctxPath%>/board/del.lms";
			frm.submit();
		}
		else{
			return;
		}
		
	}// end of function goView('${boardvo.seq}'){}-----------------------------------------

</script>

<div class="container">
    <div class="card">
        <div class="card-header" style="text-align: center; background-color: #d1e0e0">
            <h2>학사 공지사항</h2>
        </div>
        <div class="card-body">
        	   <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="goDel()">글삭제하기</button>
		   	   <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/board/edit.lms?seq=${requestScope.bdto.seq}&fk_course_seq=${requestScope.fk_course_seq}'">글수정하기</button>
  	        <form name="Del">
				<input type="hidden" name="seq" value="${requestScope.bdto.seq}"/>
				<input type="hidden" name="fk_course_seq" value="${requestScope.fk_course_seq}"/>
			</form>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" style="width:10%;">제목</th>
			      <th scope="col">${requestScope.bdto.title}</th>
			    </tr>
			  </thead>
			  <tbody class="table-group-divider">
			    <tr>
			      <th scope="row">번호</th>
			      <td>${requestScope.bdto.seq}</td>
			    </tr>
			    <tr>
			      <th scope="row">날짜</th>
			      <td>${requestScope.bdto.writeday}</td>
			    </tr>
			    <tr>
			      <th scope="row" >내용</th>
			      <td>${requestScope.bdto.content}</td>
			    </tr>
			    <tr>
			      <th scope="row" >조회수</th>
			      <td>${requestScope.bdto.viewcount}</td>
			    </tr>
			  </tbody>
			</table>
			<div style="display: flex; justify-content: space-between; width: 100%;">
				<c:if test="${requestScope.bdto.previousseq != null}">
	                <button type="button" class="btn btn-secondary" onclick="goView('${requestScope.bdto.previousseq}')">이전글</button>
				</c:if>
                <div>
	                <button type="button" class="btn btn-secondary" onclick="javascript:location.href='<%= ctxPath%>/board/lecture_notice.lms?fk_course_seq=${requestScope.fk_course_seq}'">전체목록보기</button>
	                <button type="button" class="btn btn-secondary" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'">검색목록보기</button>
                </div>
				<c:if test="${requestScope.bdto.nextseq != null}">
	                <button type="button" class="btn btn-secondary" onclick="goView('${requestScope.bdto.nextseq}')">다음글</button>
				</c:if>
            </div>
		</div>
	</div>
</div>

<form name="goViewFrm">
	<input type="hidden" name="fk_course_seq" value="${requestScope.fk_course_seq}"/>
	<input type="hidden" name="seq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchWord" value="${requestScope.paraMap.searchWord}"/>  
</form>
   