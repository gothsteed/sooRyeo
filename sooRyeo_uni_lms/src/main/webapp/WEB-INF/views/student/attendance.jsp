<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>


<style type="text/css">
div.display-flex {
    display: flex;
    justify-content: space-between;
}

</style>



<script type="text/javascript">

</script>

<div style="display: flex; margin-top: 2%;">   
  	<div style="width: 80%; min-height: 1100px; margin:auto; ">

	<h3 style="margin-bottom: 2%; margin-top:2%;"><img src="<%=ctxPath%>/resources/images/attendance.png" style="width:3%; margin-right:2%;">출석현황</h3>
	<hr class="mt-3 mb-3">
		
     	<form class="mb-3" name="searchFrm">
     		<select name="gender" style="height: 30px; width: 120px; margin: 10px 30px 0 0;"> 
         		<option value="">수업명 선택</option>
         		<option>국어</option>
         		<option>수학</option>
       		</select>
     		<%-- <button type="button" class="btn btn-secondary btn-sm" id="btnSearch">검색하기</button> --%>
       		&nbsp;&nbsp;
     		<button type="button" class="btn btn-info btn-sm" id="btnSearchAjax">검색하기(AJAX)</button>
       		&nbsp;&nbsp;
     		<button type="button" class="btn btn-success btn-sm" id="btnExcel">Excel 파일로 저장</button>
     	</form>
     	
     	
		<!-- ==== #209. 엑셀관련파일 업로드 하기 시작 ==== -->
		<form class="mb-3 mt-5" name="excel_upload_frm" method="post" enctype="multipart/form-data" >
		<div class="display-flex">
			<input type="file" id="upload_excel_file" name="excel_file" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" />
			<button type="button" class="btn btn-info btn-sm" id="btn_upload_excel">Excel 업로드</button>
		</div>
		</form>
		<!-- ==== 엑셀관련파일 업로드 하기 끝 ==== -->

		
		<div class="table-responsive">
		  <table class="table">
		    <thead class="table-info">
		    	<tr>
		    		<th>학번</th>
		    		<th>수업명</th>
		    		<th>강의명</th>
		    		<th>출석날짜</th>
		    	</tr>
		    </thead>
		    <tbody class="table-group-divider">
		    	<tr>
		    		<td>20124214</td>
		    		<td>집에가고싶다수업</td>
		    		<td>집에가고싶은이유</td>
		    		<td>2024-07-01</td>
		    	</tr>
		    	<tr>
		    		<td>20124214</td>
		    		<td>집에가고싶다수업</td>
		    		<td>집에가고싶은이유</td>
		    		<td>2024-07-01</td>
		    	</tr>
		    </tbody>
		  </table>
		</div>

	</div>
</div>







