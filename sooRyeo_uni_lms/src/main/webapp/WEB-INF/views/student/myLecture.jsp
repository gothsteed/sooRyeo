<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
   String ctxPath = request.getContextPath();
%>     

<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>


<style type="text/css">


</style>

<script type="text/javascript">


</script>


<div class="container">
<h3>▶ 이번주 강의</h3>
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
</div>

<h3>▶ 주차 별 학습활동</h3>
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















