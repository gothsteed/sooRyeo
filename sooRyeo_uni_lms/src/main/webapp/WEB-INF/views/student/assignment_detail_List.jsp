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

th {
	text-align : center;

	align-content: center;
}

</style>


<!-- jQuery Form Plugin 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>

<script type="text/javascript">


$(document).ready(function(){
	
	$("div#form").hide();
	
	goReadComment();	// 과제제출내역 읽어오기

	
}); // end of $(document).ready(function(){})



//function declaration

function goaddWriteFrm(){
	
	$("div#form").show();
		
} // end of function goaddWriteFrm
	
	
// 과제제출하기
function goAddWrite(){
	
	const comment_content = $("input:text[name='content']").val().trim();
	if(comment_content == "") {
		alert("과제 내용을 입력하세요.");
		return;	// 종료
	}
	
	<%-- 과제 첨부파일 여부 --%>
	if($("input:file[name='attach']").val() == "") {
		// 첨부파일이 없는 과제 제출인 경우
		goAddWrite_noAttach();
	}
	else {
		// 첨부파일이 있는 과제 제출인 경우
		goAddWrite_withAttach();
	}
	
} // end of function goAddWrite	
	
	
	
// 첨부파일이 없는 과제 제출인 경우
function goAddWrite_noAttach() {
	
	const queryString = $("form[name='addWriteFrm']").serialize();
	
	$.ajax({
		
		url:"<%=ctxPath%>/addComment.lms",
		data:queryString,
		type:"post",
		dataType:"json",
		success:function(json){
			
			// console.log(JSON.stringify(json));
			alert("한번 제출한 과제는 수정 및 삭제가 불가합니다. 신중하게 제출해주세요.");
			
			let schedule_seq_assignment = '${requestScope.assignment_detail_1.schedule_seq_assignment}';
			
			location.href='<%=ctxPath%>/student/assignment_detail_List.lms?schedule_seq_assignment='+schedule_seq_assignment;
			 
			
		},
		error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of $.ajax
	
} // end of function goAddWrite_noAttach



// 첨부파일이 있는 과제 제출인 경우
function goAddWrite_withAttach(){
	
	const queryString = $("form[name='addWriteFrm']").serialize();
	
	// console.log(queryString);
	
	$("form[name='addWriteFrm']").ajaxForm({
		
		url:"<%=ctxPath%>/addComment_withAttach.lms",
		data:queryString,
		type:"post",
		enctype:"multipart/form-data",
		dataType:"json",
		success:function(json){
			
			// console.log(JSON.stringify(json));
			alert("한번 제출한 과제는 수정 및 삭제가 불가합니다. 신중하게 제출해주세요.");
			
			let schedule_seq_assignment = '${requestScope.assignment_detail_1.schedule_seq_assignment}';
			
			location.href='<%=ctxPath%>/student/assignment_detail_List.lms?schedule_seq_assignment='+schedule_seq_assignment;
			

		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of $("form[name='addWriteFrm']").ajaxForm
	
	$("form[name='addWriteFrm']").submit();
	
} // end of function goAddWrite_withAttach



// 제출한 과제 읽어오기
function goReadComment(){

	
	$.ajax({
	    url: "<%= ctxPath%>/readComment.lms",
	    data: {"fk_schedule_seq_assignment": ${requestScope.assignment_detail_1.schedule_seq_assignment} },
	    type: "post",
	    dataType: "json",
	    success: function (json) {
	    	
	    	//console.log(JSON.stringify(json));
	    	
	    	//console.log(json.submit_datetime);
	    	
	        let v_html = "";
	        
	        if (json.assignment_submit_seq != "") {
	        	
	            v_html += "<tr>";
	            v_html += "<td class='comment'>" + json.assignment_submit_seq + "</td>";
	            v_html += "<td class='comment'>" + json.fk_student_id + "</td>";
	            v_html += "<td class='comment'>" + json.title + "</td>";
	            v_html += "<td class='comment'>" + json.content + "</td>";
	            
	            <%-- 첨부파일 시작 --%>
	            if (${requestScope.assignment_detail_2.orgfilename != null} ) {
	                v_html += "<td><a href='<%=ctxPath%>/downloadComment.lms?assignment_submit_seq=${requestScope.assignment_detail_2.assignment_submit_seq}'>${requestScope.assignment_detail_2.orgfilename}</a></td>";
	            } 
	            else {
	                v_html += "<td>파일 없음</td>";
	            }
	            
	            // 날짜 형식 변환
	            let originalDatetime = json.submit_datetime;
				console.log(originalDatetime)
	            let date = new Date(originalDatetime);
	            let year = date.getFullYear();
				console.log(date)
	            let month = ('0' + (date.getMonth() + 1)).slice(-2);
	            let day = ('0' + date.getDate()).slice(-2);
	            let hours = ('0' + date.getHours()).slice(-2);
	            let minutes = ('0' + date.getMinutes()).slice(-2);
	            let seconds = ('0' + date.getSeconds()).slice(-2);
	            let formattedDatetime = `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;
				console.log(formattedDatetime)

	            v_html += "<td class='comment'>" + formattedDatetime + "</td>";
	            
	            v_html += "</tr>";
	            
	            
	           // console.log(formattedDatetime);
	            
	        } 
	        else {
	            v_html += "<tr>";
	            v_html += "<td colspan='6'>제출한 과제가 없습니다</td>";
	            v_html += "</tr>";
	        }
	
	        $("tbody#commentDisplay").html(v_html);
	    },
	    error: function (request, status, error) {
	        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	    }
	});
	
}// end of function goReadComment()

</script>  



<div style="display: flex;">
  <div style="margin: auto; padding-left: 3%;">

 	<h3 style="margin-bottom: 2%; margin-top:3%; font-weight:bold;">과제 내용보기</h3>
	<hr style="margin-bottom: 3%;">
		<table class="table table-bordered table table-striped" style="width: 1024px; word-wrap: break-word; table-layout: fixed;"> 
	   	  <tr>
	   		<th style="width: 10%;">과제번호</th>
   				<td id="schedule_seq_assignment" style="font-weight:bold;">${requestScope.assignment_detail_1.schedule_seq_assignment}</td>
	   	  </tr>	
	   	
	   	  <tr>
   		  	<th>제목</th>
   	      		<td style="font-weight:bold;">${requestScope.assignment_detail_1.title}</td>
	   	  </tr> 
	   	
	   	  <tr>
	   		  <th>내용</th>
	   	      	<td>
	   	      	<p style="word-break: break-all;">${requestScope.assignment_detail_1.content}</p>
	   	      	</td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>시작일자</th>
		   	    <td>
					<fmt:formatDate value="${requestScope.assignment_detail_1.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> 
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>마감일자</th>
		   	      <td style="color:red;"> 
				   	<fmt:formatDate value="${requestScope.assignment_detail_1.end_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
				  </td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>점수</th>
		   		 <td>  
			   		 <c:if test="${requestScope.assignment_detail_2.score == null}">
			   		  	<p style="color:green;">아직 채점되지 않은 과제입니다.</p>
			   		 </c:if>
			   		 <c:if test="${requestScope.assignment_detail_2.score != null}">
			   		  	${requestScope.assignment_detail_2.score}
			   		 </c:if>
	   	     	</td>
	   	  </tr>
	   	  <tr>
	   		  <th>제출시간</th>
		   	      <td>			   		 
		   	      	<c:if test="${requestScope.assignment_detail_2.submit_datetime == null}">
				   		<p style="color:green;">아직 제출되지 않은 과제입니다.</p>
				   	</c:if>
				   	<c:if test="${requestScope.assignment_detail_2.submit_datetime != null}">
		   				<fmt:formatDate value="${requestScope.assignment_detail_2.submit_datetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				   	</c:if>
				  </td>
	   	  </tr>

	   	  <%-- === #182. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기  --%>
	   	  <tr>
	   		  <th>첨부파일</th>
		   		  <td>			   		 
		   	      	<c:if test="${requestScope.assignment_detail_1.attatched_file == null}">
				   		<p style="color:green;">첨부파일이 없습니다.</p>
				   	</c:if>
				   		 <c:if test="${requestScope.assignment_detail_1.attatched_file != null}">
				   		  	<a href="<%=ctxPath%>/downloadfile.lms?schedule_seq_assignment=${requestScope.assignment_detail_1.schedule_seq_assignment}">${requestScope.assignment_detail_1.attatched_file}</a>
				   	</c:if>
				  </td>
	   	  </tr>
	   	</table>
	 <div class="mt-5">
	 	<button type="button" class="btn btn-success btn-sm mr-3" onclick="history.back()">과제 목록</button> 
		<c:if test="${requestScope.assignment_detail_2.submit_datetime == null}">
			<button type="button" name="submit" class="btn btn-success btn-sm ml-3" onclick="goaddWriteFrm()">과제 제출</button>
		</c:if>
	 	
	 	<%-- === #83. 과제제출 폼 추가 === --%>
	 	<div id="form">
	 	<c:if test="${not empty sessionScope.loginuser.student_id}">
	 	    <h3 style="margin-top: 100px;">과제 제출</h3>
	 	    
	 	    <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px; margin-bottom: 5%;" method="post" enctype="multipart/form-data">
	   	      <table class="table table-bordered" style="width: 1024px">
				   <tr style="height: 30px;">
				      <th width="10%">학번</th>
				      <td>
				         <input type="text" name="fk_student_id" value="${sessionScope.loginuser.student_id}" readonly/>
				      </td>
				   </tr>
				   
				   <tr style="height: 30px;">
				   	   <th width="10%">제목</th>
				   	   <td>
				   	   	   <input type="text" name="title" style="width:50%;" value="${requestScope.assignment_detail_1.title}" readonly/>
				   	   </td>
				   </tr>
				   
				   <tr style="height: 30px;">
				      <th>내용</th>
				      <td>
				      
				         <input type="text" name="content" size="100" maxlength="1000"/> 
				         
				         <%-- 과제제출에 달리는 원게시물 글번호(즉, 과제제출의 부모글 글번호) --%>
				         <input type="hidden" name="fk_schedule_seq_assignment" value="${requestScope.assignment_detail_1.schedule_seq_assignment}" readonly /> 
				      </td>
				   </tr>
					   
				   <%-- === #189. 과제제출에 파일첨부하기 === --%>
				   <tr style="height: 30px;">
				      <th>파일첨부</th>
				      <td>
				         <input type="file" name="attach" />  	
				      </td>
				   </tr>  
			   </table> 
			  </form>   	
				  
		   <button type="button" name="btnUpdateComment" class="btn btn-success btn-sm" style="margin-left:80%;" onclick="goAddWrite()">제출하기</button>
		   <button type="reset" name="btnDeleteComment" class="btn btn-danger btn-sm ml-4">취소</button>
		</c:if>
		
	   	</div>
	   	
	    <%-- === 과제 내용 보여주기 === --%>
    	<h3 style="margin-top: 50px;">제출내용</h3>
		<table class="table" style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
			<thead>
			   <tr>
				  <th style="width: 6%">순번</th>
				  <th style="width: 8%; text-align: center;">학번</th>
				  <th style="text-align: center;">제목</th>
				  <th style="text-align: center;">내용</th>
				  <th style="width:10%;">첨부파일</th>
				  <th style="width: 12%; text-align: center;">제출시간</th>
			   </tr>
			</thead>
			<tbody id="commentDisplay"></tbody>
		</table> 
	 
	 </div>
	 	 
  </div>

</div>	






