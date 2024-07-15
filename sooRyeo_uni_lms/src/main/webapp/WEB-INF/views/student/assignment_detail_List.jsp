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
	
	goReadComment();
	
	const schedule_seq_assignment = $("td#schedule_seq_assignment").text();
	// console.log(schedule_seq_assignment);
	
	$.ajax({
		
		url:"<%=ctxPath%>/selectSeq.lms",
		data:{"schedule_seq_assignment" : schedule_seq_assignment},
		type:"post",
		dataType:"json",
		success:function(json){
			
			let v_html = "";
			
			if( json.result == 1 ){
				
				$("button:button[name='submit']").hide();
				
			}

		},
		error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of $.ajax
 
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
			
			/*
			$("button:button[name='btnUpdateComment']").hide();
			$("button:reset[name='btnDeleteComment']").hide();
			*/
			
			let schedule_seq_assignment = '${requestScope.assignment_detail.schedule_seq_assignment}';
			
			location.href='<%=ctxPath%>/student/assignment_detail_List.lms?schedule_seq_assignment='+schedule_seq_assignment;
			
			
		},
		error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of $.ajax
	
} // end of function goAddWrite_noAttach



// 첨부파일이 있는 과제 제출인 경우
function goAddWrite_withAttach(){
	
	const queryString = $("form[name='addWriteFrm']");
	
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
			
		/*	
			$("button:button[name='btnUpdateComment']").hide();
			$("button:reset[name='btnDeleteComment']").hide();
		*/	
			
			let schedule_seq_assignment = '${requestScope.assignment_detail.schedule_seq_assignment}';
			
			location.href='<%=ctxPath%>/student/assignment_detail_List.lms?schedule_seq_assignment='+schedule_seq_assignment;
			

		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	}); // end of $("form[name='addWriteFrm']").ajaxForm
	
	$("form[name='addWriteFrm']").submit();
	
} // end of function goAddWrite_withAttach



function formatDate(dateString) {
    // 'Sun Jul 14 20:49:53 KST 2024' 형식의 문자열을 Date 객체로 변환
    const date = new Date(dateString);
    
    // YYYY-MM-DD HH:mm:ss 형식으로 변환
    const year = date.getFullYear();
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const day = ('0' + date.getDate()).slice(-2);
    const hours = ('0' + date.getHours()).slice(-2);
    const minutes = ('0' + date.getMinutes()).slice(-2);
    const seconds = ('0' + date.getSeconds()).slice(-2);

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}




//과제 읽어오기
function goReadComment(){
	
	$.ajax({
		url:"<%= ctxPath%>/readComment.lms",
		data:{"fk_schedule_seq_assignment" : "${requestScope.assignment_detail.schedule_seq_assignment}"},
		type:"post",
		dataType:"json",
		success:function(json){
			
			// console.log(JSON.stringify(json));
		 
		    let v_html = "";
		    if(json.length > 0){
		    	
		    	$.each(json, function(index, item){
		    		
		    		v_html += "<tr>";
		    		v_html += 	"<td class='comment'>"+item.assignment_submit_seq+"</td>";
		    		v_html +=   "<td class='comment'>"+item.fk_student_id+"</td>";
		    		v_html +=   "<td class='comment'>"+item.title+"</td>";
		    		v_html +=   "<td class='comment'>"+item.content+"</td>";
                    if (item.attached_file) {
                        v_html += "<td class='comment'><a href='<%=ctxPath%>/downloadComment.action?fileName=" + item.attached_file + "'>" + item.attached_file + "</a></td>";
                    } 
                    else {
                        v_html += "<td class='comment'>파일 없음</td>";
                    }
		    		
		    		v_html += 	"<td class='comment'>"+formatDate(item.submit_datetime)+"</td>";
		    		v_html += "</tr>";
		    		
		    	});
		    }
		    
		    else {
		    	v_html += "<tr>";
		    	v_html += "<td colspan='6'>제출한 과제가 없습니다</td>";
		    	v_html += "</tr>";
		    }
			
			$("tbody#commentDisplay").html(v_html);
			
		},
		error: function(request, status, error){
		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
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
   				<td id="schedule_seq_assignment" style="font-weight:bold;">${requestScope.assignment_detail.schedule_seq_assignment}</td>
	   	  </tr>	
	   	
	   	  <tr>
   		  	<th>제목</th>
   	      		<td style="font-weight:bold;">${requestScope.assignment_detail.title}</td>
	   	  </tr> 
	   	
	   	  <tr>
	   		  <th>내용</th>
	   	      	<td>
	   	      	<p style="word-break: break-all;">${requestScope.assignment_detail.content}</p>
	   	      	</td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>시작일자</th>
	   	       	<td><fmt:formatDate value="${requestScope.assignment_detail.start_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td> 
	   	      <%--	<td>${requestScope.assignment_detail.start_date}</td> --%>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>마감일자</th>
	   	       	<td style="color:red;"><fmt:formatDate value="${requestScope.assignment_detail.end_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td> 
	   	      <%--	<td style="color:red;">${requestScope.assignment_detail.end_date}</td> --%>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>점수</th>
		   		 <td>  
			   		 <c:if test="${requestScope.assignment_detail.score == null}">
			   		  	<p style="color:green;">아직 채점되지 않은 과제입니다.</p>
			   		 </c:if>
			   		 <c:if test="${requestScope.assignment_detail.score != null}">
			   		  	${requestScope.assignment_detail.score}
			   		 </c:if>
	   	     	</td>
	   	  </tr>
	   	  <tr>
	   		  <th>제출시간</th>
		   	      <td>			   		 
		   	      	<c:if test="${requestScope.assignment_detail.submit_datetime == null}">
				   		<p style="color:green;">아직 제출되지 않은 과제입니다.</p>
				   	</c:if>
				   		 <c:if test="${requestScope.assignment_detail.submit_datetime != null}">
				   		   	<fmt:formatDate value="${requestScope.assignment_detail.submit_datetime}" pattern="yyyy-MM-dd hh:mm:ss"/> 
				   		  <%--	${requestScope.assignment_detail.submit_datetime}--%>
				   	</c:if>
				  </td>
	   	  </tr>

	   	  <%-- === #182. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기  --%>
	   	  <tr>
	   		  <th>첨부파일</th>
		   		  <td>			   		 
		   	      	<c:if test="${requestScope.assignment_detail.attatched_file == null}">
				   		<p style="color:green;">첨부파일이 없습니다.</p>
				   	</c:if>
				   		 <c:if test="${requestScope.assignment_detail.attatched_file != null}">
				   		  	<a href="<%=ctxPath%>/download.action?schedule_seq_assignment=${requestScope.schedule_seq_assignment}">${requestScope.assignment_detail.attatched_file}</a>
				   	</c:if>
				  </td>
	   	  </tr>
	   	</table>
	 
	 <div class="mt-5">
	 	<button type="button" class="btn btn-success btn-sm mr-3" onclick="history.back()">과제 목록</button> 
	 	
	 <%-- 	<button type="button" name="submit" class="btn btn-success btn-sm ml-3" onclick="goaddWriteFrm()">과제 제출</button> --%>
		
		<c:if test="${requestScope.assignment_detail.submit_yes == 0}">
			<button type="button" name="submit" class="btn btn-success btn-sm ml-3" onclick="">과제 제출</button>
			<%-- <span>제출일자 : ${requestScope.assignment_detail.submit_datetime}</span>--%>
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
				   	   	   <input type="text" name="title" style="width:50%;" value="${requestScope.assignment_detail.title}" readonly/>
				   	   </td>
				   </tr>
				   
				   <tr style="height: 30px;">
				      <th>내용</th>
				      <td>
				      
				         <input type="text" name="content" size="100" maxlength="1000"/> 
				         
				         <%-- 과제제출에 달리는 원게시물 글번호(즉, 과제제출의 부모글 글번호) --%>
				         <input type="hidden" name="fk_schedule_seq_assignment" value="${requestScope.assignment_detail.schedule_seq_assignment}" readonly /> 
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






