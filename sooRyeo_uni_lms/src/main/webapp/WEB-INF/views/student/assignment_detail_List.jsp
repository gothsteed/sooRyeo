<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>


<style type="text/css">

span.move  {cursor: pointer; color: navy;}

.moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}

td.comment {text-align: center;}

a {text-decoration: none !important;}

</style>


<script type="text/javascript">


$(document).ready(function(){
	
 
	
}); // end of $(document).ready(function(){})


</script>  


<div style="display: flex;">
  <div style="margin: auto; padding-left: 3%;">

 	<h3 style="margin-bottom: 2%; margin-top:3%; font-weight:bold;">과제 내용보기</h3>
	<hr style="margin-bottom: 3%;">
	 <c:forEach var="item" items="${requestScope.assignment_detail_List}">
		<table class="table table-bordered table table-striped" style="width: 1024px; word-wrap: break-word; table-layout: fixed;"> 
	   	 
	   	  <tr>
	   		<th style="width: 15%">과제번호</th>
   				<td style="font-weight:bold;">${item.schedule_seq_assignment}</td>
	   	  </tr>	
	   	
	   	  <tr>
   		  	<th>제목</th>
   	      		<td style="font-weight:bold;">${item.title}</td>
	   	  </tr> 
	   	
	   	  <tr>
	   		  <th>내용</th>
	   	      	<td>
	   	      	<p style="word-break: break-all;">${item.content}</p>
	   	      	</td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>시작일자</th>
	   	      	<td><fmt:formatDate value="${item.start_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>마감일자</th>
	   	      	<td style="color:red;"><fmt:formatDate value="${item.end_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>점수</th>
		   		 <td>  
			   		 <c:if test="${item.score == null}">
			   		  	<p style="color:green;">아직 채점되지 않은 과제입니다.</p>
			   		 </c:if>
			   		 <c:if test="${item.score != null}">
			   		  	${item.score}
			   		 </c:if>
	   	     	</td>
	   	  </tr>
	   	  <tr>
	   		  <th>제출시간</th>
		   	      <td>			   		 
		   	      	<c:if test="${item.submit_datetime == null}">
				   		<p style="color:green;">아직 제출되지 않은 과제입니다.</p>
				   	</c:if>
				   		 <c:if test="${item.submit_datetime != null}">
				   		  	${item.submit_datetime}
				   	</c:if>
				  </td>
	   	  </tr>

	   	  <%-- === #182. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기  --%>
	   	  <tr>
	   		  <th>첨부파일</th>
		   		  <td>			   		 
		   	      	<c:if test="${item.attatched_file == null}">
				   		<p style="color:green;">첨부파일이 없습니다.</p>
				   	</c:if>
				   		 <c:if test="${item.attatched_file != null}">
				   		  	${item.attatched_file}
				   	</c:if>
				  </td>
	   	  </tr>
	   	</table>
	 </c:forEach>
	 
	 
	 <div class="mt-5">
	 	<button type="button" class="btn btn-success btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/student/assignment_List.lms'">목록보기</button> 

	 
	 	<%-- === #83. 댓글쓰기 폼 추가 === --%>
 	    <h3 style="margin-top: 50px;">댓글쓰기</h3>
 	    
 	    <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
   	      <table class="table" style="width: 1024px">
			   <tr style="height: 30px;">
			      <th width="10%">학번</th>
			      <td>
			         <input type="text" name="student_id" value="" readonly />
			      </td>
			   </tr>
			   
			   <tr style="height: 30px;">
			      <th>댓글내용</th>
			      <td>
			         <input type="text" name="content" size="100" maxlength="1000" /> 
			         
			         <%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
			         <input type="text" name="parentSeq" value="" readonly /> 
			      </td>
			   </tr>
				   
			   <%-- === #189. 댓글쓰기에 파일첨부하기 === --%>
			   <tr style="height: 30px;">
			      <th>파일첨부</th>
			      <td>
			         <input type="file" name="attach" /> 
			      </td>
			   </tr>  
			   
			   <tr>
			      <th colspan="2">
			      	<button type="button" class="btn btn-success btn-sm mr-3" onclick="">댓글쓰기 확인</button>
			      	<button type="reset" class="btn btn-success btn-sm">댓글쓰기 취소</button>
			      </th>
			   </tr>
		  </table>	      
   	   </form>     
	 	 
	 	 
	 	<%-- === #94. 댓글 내용 보여주기 === --%>
    	<h3 style="margin-top: 50px;">댓글내용</h3>
		<table class="table" style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
			<thead>
			   <tr>
				  <th style="width: 6%">순번</th>
				  <th style="text-align: center;">내용</th>
				  
				  <%-- === 댓글쓰기에 첨부파일이 있는 경우 시작 === --%>
				  <th style="width:10%;">첨부파일</th>
				  <th style="width:8%;">bytes</th>
				  <%-- === 댓글쓰기에 첨부파일이 있는 경우 끝 === --%>
				  
				  <th style="width: 8%; text-align: center;">작성자</th>
				  <th style="width: 12%; text-align: center;">작성일자</th>
				  <th style="width: 12%; text-align: center;">수정/삭제</th>
			   </tr>
			</thead>
			<tbody id="commentDisplay"></tbody>
		</table> 
	 	
	 	<%-- === #155. 댓글페이지바가 보여지는 곳 === --%> 
	 	<div style="display: flex; margin-bottom: 50px;">
    	   <div id="pageBar" style="margin: auto; text-align: center;"></div>
    	</div>
	 	 
	 </div>
	 
  </div>
</div>	

<%-- === #138. 이전글제목, 다음글제목 보기 === --%>
<form name="goViewFrm">
   <input type="text" name="seq" />
   <input type="text" name="goBackURL" />
</form>







