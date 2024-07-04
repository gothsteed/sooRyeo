<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- jQueryUI CSS 및 JS --%>
<script type="text/javascript">
	$(document).ready(function(){
		$("table#professor").show();
		$("table#student").hide();

		// 교수나 학생 중 선택하여 조회
		$("select#selectTag").change(function(){
			
			if($(event.target).val() == '1'){
				$("select#selectTag").val("1");
				$("table#student").hide();
				$("table#professor").show();
			}
			
			if($(event.target).val() == '2'){
				$("select#selectTag").val("2");
				$("table#professor").hide();
				$("table#student").show();
			}
		});
	});
</script>

</head>
<body>
<div style="display: flex; justify-content: space-between;">
    <div>
        <button type="button" class="btn btn-primary">휴학처리</button>
        <button type="button" class="btn btn-primary">수정하기</button>
    </div>
    <div>
        <button type="button" class="btn btn-danger">삭제하기</button>
    </div>
</div>

<hr>

<select id="selectTag" name="searchType">
	<option>선택하세요</option>
	<option value="1">교수</option>
	<option value="2">학생</option>
</select>

<br>

<table class="table table-success table-striped-columns" id="student">
  <th>
  	<div class="form-check">
	  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
	  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
	  </label>
	</div>
  </th>
  <th>학생 아이디</th>
  <th>이름</th>
  <th>이메일</th>
  <th>등록일</th>
  <th>회원상태</th>
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400003
  	</td>
  	<td>
  		이정연
  	</td>
  	<td>
  		King@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400004
  	</td>
  	<td>
  		손혜정
  	</td>
  	<td>
  		KingWang@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400005
  	</td>
  	<td>
  		김경현
  	</td>
  	<td>
  		KingWangJJang@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400006
  	</td>
  	<td>
  		강민정
  	</td>
  	<td>
  		KingWangJJangMan@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400007
  	</td>
  	<td>
  		손영관
  	</td>
  	<td>
  		KingWangJJangManGood@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
</table>

<table class="table table-success table-striped-columns" id="professor">
  <th>
  	<div class="form-check">
	  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
	  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
	  </label>
	</div>
  </th>
  <th>교수 아이디</th>
  <th>이름</th>
  <th>이메일</th>
  <th>등록일</th>
  <th>회원상태</th>
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400003
  	</td>
  	<td>
  		이정연
  	</td>
  	<td>
  		King@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400004
  	</td>
  	<td>
  		손혜정
  	</td>
  	<td>
  		KingWang@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
  <tr>
  	<td>
  		<div class="form-check">
		  <input class="form-check-input" type="checkbox" value="" id="flexCheckIndeterminateDisabled">
		  <label class="form-check-label" for="flexCheckIndeterminateDisabled">
		  </label>
		</div>
  	</td>
  	<td>
  		202400005
  	</td>
  	<td>
  		김경현
  	</td>
  	<td>
  		KingWangJJang@naver.com
  	</td>
  	<td>
  		2024-06-26
  	</td>
  	<td>
  		N
  	</td>
  </tr>
  
</table>

</body>
</html>