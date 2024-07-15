<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	// Function Declaration
	function goView(announcement_seq){
		const goBackURL = "${requestScope.goBackURL}";
		
		const frm = document.goViewFrm
		frm.seq.value = announcement_seq;
		frm.goBackURL.value = goBackURL;
		
		frm.method = "post";
		frm.action = "<%= ctxPath%>/admin/announcementView_2.lms";
		frm.submit();
		
	}// end of function goView('${boardvo.seq}'){}-----------------------------------------

	function goDel(){
		
		if(confirm("정말로 삭제하시겠습니까?")){
			const frm = document.Del
	
			frm.method = "post";
			frm.action = "<%= ctxPath%>/admin/del.lms";
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
		   	   <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/admin/edit.lms?seq=${requestScope.an.announcement_seq}'">글수정하기</button>
        	        <form name="Del">
						<input type="text" name="announcement_seq" value="${requestScope.an.announcement_seq}"/>  
					</form>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" style="width:10%;">제목</th>
			      <th scope="col">${requestScope.an.a_title}</th>
			    </tr>
			  </thead>
			  <tbody class="table-group-divider">
			    <tr>
			      <th scope="row">날짜</th>
			      <td>${requestScope.an.writeday}</td>
			    </tr>
			    <tr>
			      <th scope="row" >내용</th>
			      <td>${requestScope.an.a_content}</td>
			    </tr>
			    <tr>
			      <th scope="row">첨부파일</th>
			      <c:if test="${requestScope.an.attatched_file != null}">
				      <td colspan="2"><a href="<%= ctxPath%>/admin/download.lms?seq=${requestScope.an.announcement_seq}">${requestScope.an.orgfilename}</a></td>
			      </c:if>
			      <c:if test="${requestScope.an.attatched_file == null}">
				      <td colspan="2">첨부파일이 없습니다.</td>
			      </c:if>
			    </tr>
			    <tr>
			      <th scope="row" >조회수</th>
			      <td>${requestScope.an.viewcount}</td>
			    </tr>
			  </tbody>
			</table>
			<div style="display: flex; justify-content: space-between; width: 100%;">
				<c:if test="${requestScope.an.previousseq != null}">
	                <button type="button" class="btn btn-secondary" onclick="goView('${requestScope.an.previousseq}')">이전글</button>
				</c:if>
                <div>
	                <button type="button" class="btn btn-secondary" onclick="javascript:location.href='<%= ctxPath%>/admin/announcement.lms'">전체목록보기</button>
	                <button type="button" class="btn btn-secondary" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'">검색목록보기</button>
                </div>
				<c:if test="${requestScope.an.nextseq != null}">
	                <button type="button" class="btn btn-secondary" onclick="goView('${requestScope.an.nextseq}')">다음글</button>
				</c:if>
            </div>
		</div>
	</div>
</div>

<form name="goViewFrm">
	<input type="hidden" name="seq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchWord" value="${requestScope.paraMap.searchWord}"/>  
</form>
   