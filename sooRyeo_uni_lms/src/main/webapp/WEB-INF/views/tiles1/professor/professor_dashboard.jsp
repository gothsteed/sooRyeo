<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

	section{
		border: solid 1px black;
	    background-color: white;
	    padding: 2em;
	    margin: 2em auto;
	    width: 80%;
	}
	
	li{
		list-style-type: none;
	}


</style>

<script type="text/javascript">




</script>

<head>
    <meta charset="UTF-8">
    <title>Professor Dashboard</title>
</head>


<body>
<header>
    <h1>교수 관리 페이지</h1>
    <nav>
        <ul style="display: flex;">
            <li><a href="">메인 페이지</a>&nbsp;&nbsp;</li>
            <li><a href="">강좌 관리</a>&nbsp;&nbsp;</li>
            <li><a href="">과제 관리</a>&nbsp;&nbsp;</li>
            <li><a href="">학생 관리</a>&nbsp;&nbsp;</li>
        </ul>
    </nav>
</header>


<h2>환영합니다! ooo교수님!</h2>

<div style="display: flex;">
<section class="col-sm-3 col-md-3">
    <h3>강좌 관리</h3>
    <ol>
        <li>강좌 1: 컴퓨터 공학의 기초이론</li>
        <li>강좌 2: 데이터 구조 이론</li>
        <li>강좌 3: 프로그래밍 언어 이론</li>
    </ol>
</section>
<section class="col-sm-3 col-md-3">
    <h3>과제 관리</h3>
    <ol>
        <li>과제 1 마감기한 : 2024-07-01</li>
        <li>과제 2 마감기한 : 2024-07-15</li>
        <li>과제 3 마감기한 : 2024-08-01</li>
    </ol>
</section>
<section class="col-sm-3 col-md-3">
    <h3>학생 관리</h3>
    <ol>
        <li>김경현1</li>
        <li>김경현2</li>
        <li>김경현3</li>
    </ol>
</section>
</div>
<br>
<br>
<div style="display: flex;">
<section class="col-sm-3 col-md-3">
    <h3>시험 관리</h3>
    <ol>
        <li>강좌 1 시험마감: 2024-08-01</li>
        <li>강좌 2 시험마감: 2024-08-15</li>
        <li>강좌 3 시험마감: 2024-09-01</li>
    </ol>
</section>
<section class="col-sm-3 col-md-3">
    <h3>상담 관리</h3>
    <ol>
        <li>현재 예약된 상담이 없습니다.</li>
    </ol>
</section>
<section class="col-sm-3 col-md-3">
    <h3>강의 개설 신청</h3>
    <ol>
        <li>STS 강좌 개설 신청합니다.</li>
        <li>Spring boot 강좌 개설 신청합니다.</li>
    </ol>
</section>
</div>
