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

a {text-decoration: none !important;}

</style>


<script type="text/javascript">


$(document).ready(function(){
	
    // === #144. Ajax 로 불러온 댓글내용들을 페이징 처리하기 === //
    
    goViewComment(1); // 페이징 처리 한 댓글 읽어오기
    
	$("span.move").hover(function(e){
			              $(e.target).addClass("moveColor");
                        }, 
                        function(e){
   	                      $(e.target).removeClass("moveColor");  
   	                      
    }); // end of $("span.move").hover
	
	$("input:text[name='content']").bind("keydown", function(e){
		
		if(e.keyCode == 13){ // 엔터
			goAddWrite();
		} // end of if(e.keyCode == 13)
			
	}); // end of $("input:text[name='content']").bind("keydown"){})
	
	
	
	// ===== 댓글 수정 ===== //
	let origin_comment_content = "";
	
	$(document).on("click", "button.btnUpdateComment", function(e){
	    
		const $btn = $(e.target);
		
		if($(e.target).text() == "수정"){
		 alert("댓글수정");
		 //	alert($(e.target).parent().parent().children("td:nth-child(2)").text()); // 수정전 댓글내용
		    const $content = $(e.target).parent().parent().children("td:nth-child(2)");
		    origin_comment_content = $(e.target).parent().parent().children("td:nth-child(2)").text();
		    $content.html(`<input id='comment_update' type='text' value='\${origin_comment_content}' size='40' />`); // 댓글내용을 수정할 수 있도록 input 태그를 만들어 준다.
		    
		    $(e.target).text("완료").removeClass("btn-secondary").addClass("btn-info");
		    $(e.target).next().next().text("취소").removeClass("btn-secondary").addClass("btn-danger"); 
		    
		    $(document).on("keyup", "input#comment_update", function(e){
		    	if(e.keyCode == 13){
		    	  // alert("엔터했어요~~");
		    	  // alert($btn.text()); // "완료"
		    		 $btn.click();
		    	}
		    });
		}
		
		else if($(e.target).text() == "완료"){
		  // alert("댓글수정완료");
		  // alert($(e.target).next().val()); // 수정해야할 댓글시퀀스 번호 
		  // alert($(e.target).parent().parent().children("td:nth-child(2)").children("input").val()); // 수정후 댓글내용
		     const content = $(e.target).parent().parent().children("td:nth-child(2)").children("input").val(); 
		  
		     $.ajax({
		    	 url:"${pageContext.request.contextPath}/updateComment.action",
		    	 type:"post",
		    	 data:{"seq":$(e.target).next().val(),
		    		   "content":content},
		    	 dataType:"json",
		    	 success:function(json){
		    	  // $(e.target).parent().parent().children("td:nth-child(2)").html(content);
		          // goReadComment();  // 페이징 처리 안한 댓글 읽어오기
		    		
		          ////////////////////////////////////////////////////
		          // goViewComment(1); // 페이징 처리 한 댓글 읽어오기   
		             
		             const currentShowPageNo = $(e.target).parent().parent().find("input.currentShowPageNo").val(); 
                  // alert("currentShowPageNo : "+currentShowPageNo);		          
                     goViewComment(currentShowPageNo); // 페이징 처리 한 댓글 읽어오기
		    	  ////////////////////////////////////////////////////
		    	  
		    	     $(e.target).text("수정").removeClass("btn-info").addClass("btn-secondary");
		    		 $(e.target).next().next().text("삭제").removeClass("btn-danger").addClass("btn-secondary");
		    	 },
		    	 error: function(request, status, error){
				    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 }
		     });
		}
		
	}); 
	
	
	
	
	
	
	
	
	
	
	
}); // end of $(document).ready(function(){})


// Function Declaration


</script>  




<div style="display: flex;">
  <div style="margin: auto; padding-left: 3%;">

 	<h3 style="margin-bottom: 2%; margin-top:3%; font-weight:bold;">과제 내용보기</h3>
	<hr style="margin-bottom: 3%;">
		<table class="table table-bordered table table-striped" style="width: 1024px; word-wrap: break-word; table-layout: fixed;"> 
	   	  <tr>
	   		  <th style="width: 15%">과제번호</th>
	   	      <td></td>
	   	  </tr>	
	   	
	   	  <tr>
	   		  <th>제목</th>
	   	      <td></td>
	   	  </tr> 
	   	
	   	  <tr>
	   		  <th>내용</th>
	   	      <td>
	   	      <p style="word-break: break-all;"></p>
	   	      </td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>시작일자</th>
	   	      <td></td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>마감일자</th>
	   	      <td></td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>점수</th>
	   	      <td></td>
	   	  </tr>
	   	  
	   	  <tr>
	   		  <th>제출시간</th>
	   	      <td></td>
	   	  </tr>

	   	  <%-- === #182. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기  --%>
	   	  <tr>
	   		  <th>첨부파일</th>
	   	      <td>
	   	        <c:if test="">
	   	           <a href=""></a>  
	   	        </c:if>
	   	        <c:if test="">
	   	           
	   	        </c:if>
	   	      </td>
	   	  </tr>
	   	</table>
	 
	 
	 
	 <div class="mt-5">
	    <%-- === #137. 이전글제목, 다음글제목 보기 --%>
	    <%-- >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다.  시작  <<< --%>
	    <div style="margin-bottom: 1%;">이전글제목&nbsp;&nbsp;<span class="move" onclick=""></span></div>
	 	<div style="margin-bottom: 1%;">다음글제목&nbsp;&nbsp;<span class="move" onclick=""></span></div>
	    <%-- >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다.  끝  <<< --%>   
	    	
	 	<br>
	 	
	 	<button type="button" class="btn btn-success btn-sm mr-3" onclick="">전체목록보기</button> 

	 
	 	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="">글수정하기</button>
	 	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="">글삭제하기</button> 

	 	
	 	
 	 	<%-- === #161.어떤 글에 대한 답변글쓰기는 로그인 되어진 교수들만 답변글쓰기가 가능하다. === --%>
 
    	<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="">답변글쓰기</button> 
	
	 	
	 	
	 	<%-- === #83. 댓글쓰기 폼 추가 === --%>
 	    <h3 style="margin-top: 50px;">댓글쓰기</h3>
 	    
 	    <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
   	      <table class="table" style="width: 1024px">
			   <tr style="height: 30px;">
			      <th width="10%">학번</th>
			      <td>
			         <input type="text" name="fk_userid" value="" readonly /> 
			         <input type="text" name="name" value="" readonly />
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







