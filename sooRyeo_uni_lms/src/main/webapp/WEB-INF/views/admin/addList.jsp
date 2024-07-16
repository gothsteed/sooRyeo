<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

</style>    

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

  $(document).ready(function(){
	     
     $(".form-select").change(function() {
        
    	 var selectedValue = $(this).val();
         $("#Listtype").val(selectedValue);
     });
	  
	  <%-- === #166-1. 스마트 에디터 구현 시작 === --%>
      //전역변수
      var obj = [];
      
      //스마트에디터 프레임생성
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: obj,
          elPlaceHolder: "content", // id가 content인 textarea에 에디터를 넣어준다.
          sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,            
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,    
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,
          }
      });
     <%-- === 스마트 에디터 구현 끝 === --%>
     
     // 글쓰기 버튼
     $("button#btnWrite").click(function(){
    	
    	 <%-- === 스마트 에디터 구현 시작 === --%>
         // id가 content인 textarea에 에디터에서 대입
           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
         <%-- === 스마트 에디터 구현 끝 === --%>
    	 
    	 // 글제목 유효성 검사
    	 const subject = $("input:text[name='subject']").val(); <%-- name 값은 컬럼명과 같아야 한다. --%>
    	 if(subject == ""){
    		 alert("글제목은 필수 항목입니다.");
    		 $("input:text[name='subject']").val(""); <%-- 공백 없애주기 --%>
    		 return; // 종료
    	 }
    	 
    	 if($(".form-select").val() == "글 유형 선택"){
    		 alert("글유형을 선택하세요.");
    		 return;
    	 }
    	 
    	 // 글내용 유효성 검사(스마트에디터를 사용할 경우)
    	 let content_val = $("textarea[name='content']").val().trim(); <%-- name 값은 컬럼명과 같아야 한다. --%>
    	 // <p>&nbsp;&nbsp;&nbsp;</p> 이라고 나온다.
    	 
    	 content_val = content_val.replace(/&nbsp;/gi, "");   // 공백(&nbsp;)을 "" 으로 변환한다. ==> 정규표현식

    	 content_val = content_val.substring(content_val.indexOf("<p>")+3);
    	 content_val = content_val.substring(0, content_val.indexOf("</p>")-1);
    	 
    	 if(content_val.trim().length == 0){
    		 alert("글내용은 필수 항목입니다.");
    		 return; // 종료
    	 }
    	 
    	 console.log(content_val);
    	 
    	 // 폼(form)을 전송(submit)
    	 const frm = document.addFrm;
    	 frm.method = "post";
    	 frm.action = "<%= ctxPath%>/board/addListEnd.lms";
    	 frm.submit();
    	 
     });
     
  }); // end of $(document).ready(function(){})-----------
</script>

<div style="display: flex;">
  <div style="margin: auto; padding-left: 3%;">
       <h2 style="margin-bottom: 30px;">글쓰기</h2>
      <select class="form-select" aria-label="Default select example">
          <option selected>글 유형 선택</option>
          <option value="0">일반글</option>
          <option value="1">고정글</option>
      </select>
       <form name="addFrm" enctype="multipart/form-data">
       <input type="hidden" id="Listtype" name="Listtype"/>
        <table style="width: 1024px" class="table table-bordered">
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">제목</th>
            <td>
                <input type="text" name="title" size="100" maxlength="200" />
            </td>
         </tr>
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">내용</th> 
            <td>
                <textarea style="width: 100%; height: 612px;" name="content" id="content"></textarea>
            </td>
         </tr>
          <%-- === #170. 파일첨부 타입 추가하기 --%>
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">파일첨부</th>  
            <td>
                <input type="file" name="attach" /> <!-- name이 attach이기에 제출되면 boardvo에 set 되어진다 -->
            </td>
         </tr>
        </table>
        <div style="margin: 20px;">
            <button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
            <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
            <%-- === 타입에 버튼을 명시하지 않으면 submit으로 인식되어 의도치 않은 제출이 될 수 있다. === --%>
        </div>
       </form>
       
  </div>
</div>