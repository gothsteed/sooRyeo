<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>

<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<title>SooRyeo Univ.</title>


<style>

.majorO {

	border:solid 1px #175F30;
	background-color: #175F30;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}

.majorX {

	border:solid 1px #A0D468;
	background-color: #A0D468;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}

.no-majorO {

	border:solid 1px #FFD400;
	background-color: #FFD400;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}

.no-majorX {

	border:solid 1px #FF9500;
	background-color: #FF9500;
	width: 8%;
	height: 22px;
	font-size: 11pt;
	text-align: center;
	margin-left : 2.5%;
	margin-top: 1.5%;
	color: white;

}


.border1 {
	height: 60px;
	display: flex;
	color: #175F30;
	text-align : center;
	padding : 20px 20px;
	font-size: 14pt;
	font-weight: bold;
	margin-left: 8%;
}

.border2 {
	height: 60px;
	display: flex;
	text-align : center;
	padding : 20px 20px;
	margin-left: 8%;
}

</style>


<div style="display: flex; width : 100%;" class="row">

	<div style="margin-top: 5%; width : 80%; border: solid 0px green;">
	
		<c:forEach var="mapList" items="${requestScope.mapList}">
			<div class="border" style="width: 80%; height: 90px; margin: 0 auto; font-size: 26pt; color: #175F30; font-weight: bold;">
			   <div style="display: flex;">
			      <div><img src="<%= ctxPath%>/resources/images/user.png" style="width: 50px; height: 50px; margin-left: 2%; margin-left: 20%; margin-top: 30%;"/></div>
			      <c:if test="${mapList.department_seq != null && mapList.required == '1'}">
			      	<div class="majorO rounded">전공필수</div>
			      </c:if>
			      <c:if test="${mapList.department_seq != null && mapList.required == '0'}">
			      	<div class="majorX rounded">전공선택</div>
			      </c:if>
			      <c:if test="${mapList.department_seq == null && mapList.required == '1'}">
			      	<div class="no-majorO rounded">교양필수</div>
			      </c:if>
			      <c:if test="${mapList.department_seq != null && mapList.required == '0'}">
			      	<div class="no-majorX rounded">교양선택</div>
			      </c:if>
			      <div style="width: 60%; margin-left: 3%; margin-top: 1%;">
					  <div style="font-size: 20pt; color: black;">${mapList.className}</div>
		         	  <div style="font-size: 12pt; color: black;">${mapList.professorName}</div>	
			      </div>
			      <div style=" margin-top: 1%; margin-left: 14%;"><img src="<%= ctxPath%>/resources/images/right-arrow.png" style="width: 35px;"/></div>
			   </div>
			</div>
		</c:forEach>

	</div>
	
	
	<div style="width: 20%; height: 200px; border-left:solid 2px #DEE2E6; height: 800px;">
		<div class="border border1">· 공지사항</div>
		<div class="border border2">등록된 게시글이 없습니다.</div>
		<div class="border border1">· 예정된 할일(03-03 ~ 03-24)</div>
		<div class="border border2">계획된 일정이 없습니다.</div>
	</div>

</div>



