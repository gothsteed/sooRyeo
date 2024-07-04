<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
   String ctxPath = request.getContextPath();
%>     

<%-- Bootstrap CSS --%>



<style type="text/css">

.btns {
  display: flex;
  position: fixed;
  right: 200px;
  bottom: 200px;
}



</style>

<script type="text/javascript">


function scrollToTarget_up() {
	
    var target = document.getElementById('target');
    target.scrollIntoView({ behavior: 'smooth' });
    
}


function scrollToTarget_down() {
	
    var target = document.getElementById('target2');
    target2.scrollIntoView({ behavior: 'smooth' });
    
}

</script>

<div id="target"></div>
<div class="container ml-5">
<h3>강의 개요</h3>
<hr>
	<div class="card-body" style="">
		<button type="button" class="btn btn-outline-light" style="width:20%; height:150px;">
			<img src="<%=ctxPath%>/resources/images/annoucement.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="annoucement" style="color:black; font-weight: bold;">공지사항</span>
			<br>
		</button> 	
		<button type="button" class="btn btn-outline-light ml-5" style="width:20%; height:150px;">
			<img src="<%=ctxPath%>/resources/images/tasks.png" class="img-fluid" style="width:30%;">
			<br><br>
			<span id="tasks" style="color:black; font-weight: bold;">과제</span>
			<br>
		</button>
	</div>
</div>


<div class="container ml-5" style="margin-top:5%;">
<h3>이번주 강의</h3>
<hr>
	<div class="card mb-5">
		<h5 class="card-header" style="font-weight:bold;">1주차 [3월 01일 ~ 3월 08일]</h5>
		<div class="card-body">
			<h5 class="card-title">제 1장. 집에 가고 싶은 이유</h5>
			<hr>
			<a href="#play" class="card-link"><img src="<%=ctxPath%>/resources/images/play.png" class="img-fluid" style="width:3%;">&nbsp;1단원 영상</a>
			<span class="card-text" style="color:orange;">2024-07-01 ~ 2024-07-31 <span style="color:green;">&nbsp;36:00</span></span>
			<a href="#pdf" class="card-link mt-3 ml-5"><img src="<%=ctxPath%>/resources/images/pdf.png" class="img-fluid" style="width:2.5%;">&nbsp;1주차 수업 자료</a>
		</div>
	</div>


<h3>주차 별 학습활동</h3>
<hr>
	<div class="card mb-5">
		<h5 class="card-header" style="font-weight:bold;">1주차 [3월 01일 ~ 3월 08일]</h5>
		<div class="card-body">
			<h5 class="card-title">제 1장. 집에 가고 싶은 이유</h5>
			<hr>
			<a href="#play" class="card-link"><img src="<%=ctxPath%>/resources/images/play.png" class="img-fluid" style="width:3%;">&nbsp;1단원 영상</a>
			<span class="card-text" style="color:orange;">2024-07-01 ~ 2024-07-31 <span style="color:green;">&nbsp;36:00</span></span>
			<a href="#pdf" class="card-link mt-3 ml-5"><img src="<%=ctxPath%>/resources/images/pdf.png" class="img-fluid" style="width:2.5%;">&nbsp;1주차 수업 자료</a>
		</div>
	</div>
	<div class="card mb-5">
		<h5 class="card-header" style="font-weight:bold;">2주차 [3월 01일 ~ 3월 08일]</h5>
		<div class="card-body">
			<h5 class="card-title">제 2장. 집이 좋은 이유</h5>
			<hr>
			<a href="#play" class="card-link"><img src="<%=ctxPath%>/resources/images/play.png" class="img-fluid" style="width:3%;">&nbsp;2단원 영상</a>
			<span class="card-text" style="color:orange;">2024-07-01 ~ 2024-07-31 <span style="color:green;">&nbsp;36:00</span></span>
			<a href="#pdf" class="card-link mt-3 ml-5"><img src="<%=ctxPath%>/resources/images/pdf.png" class="img-fluid" style="width:2.5%;">&nbsp;2주차 수업 자료</a>
		</div>
	</div>
	<div class="card mb-5">
		<h5 class="card-header" style="font-weight:bold;">3주차 [3월 01일 ~ 3월 08일]</h5>
		<div class="card-body">
			<h5 class="card-title">제 3장. 집에 가는 이유</h5>
			<hr>
			<a href="#play" class="card-link"><img src="<%=ctxPath%>/resources/images/play.png" class="img-fluid" style="width:3%;">&nbsp;3단원 영상</a>
			<span class="card-text" style="color:orange;">2024-07-01 ~ 2024-07-31 <span style="color:green;">&nbsp;36:00</span></span>
			<a href="#pdf" class="card-link mt-3 ml-5"><img src="<%=ctxPath%>/resources/images/pdf.png" class="img-fluid" style="width:2.5%;">&nbsp;3주차 수업 자료</a>
		</div>
	</div>
</div>
<div id="target2"></div>



<div class="btns" style="display:inline;">
  	<div class="moveTopBtn" onclick="scrollToTarget_up()"><img src="<%=ctxPath%>/resources/images/btn_up_light.png"></div>
  	<div class="moveDownBtn" onclick="scrollToTarget_down()"><img src="<%=ctxPath%>/resources/images/btn_down_light.png"></div>
</div>






