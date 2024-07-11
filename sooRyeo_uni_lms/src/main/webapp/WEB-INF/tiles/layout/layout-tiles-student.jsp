<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<% String ctxPath = request.getContextPath(); %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Styled Sidebar</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0; 
            display: flex;
            height: 100vh;
            background-color: white;
        }

        .sidebar {
            width: 250px;
            background-color: #d1e0e0;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            font-weight: bold;
        }

        .sidebar ul li:hover {
            background-color: white;
            margin-left: 10%;
            width: 85%;
        }

        .sidebar .profile {
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar .profile img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: white;
        }

        .sidebar .profile h3 {
            margin: 10px 0 5px 0;
            font-size: 18px;
        }

        .sidebar .profile p {
            margin: 0;
            font-size: 14px;
            color: white;
        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
            width: 100%;
        }

        .sidebar ul li {
            width: 100%;
            margin: 5px;
        }

        .sidebar ul li a {
            width: 70%;
            margin: 0 auto;
            display: flex;
            align-items: center;
            padding: 15px 20px;
            text-decoration: none;
            color: #666;
            transition: background 0.3s ease, color 0.3s ease;
            font-size: 16px;
        }

        .sidebar ul li a .icon {
            margin-right: 10px;
            font-size: 18px;
        }

        .sidebar ul li a.active .icon {
            color: white;
        }

        .dropdown-menu {
            background-color: white;
        }

        .dropdown-item {
            padding-bottom: 2px;
            background-size: 0 2px;
            transition: background-size 0.5s;
        }

        .dropdown-item:hover {
            background-size: 100% 2px;
            background-image: linear-gradient(#175F30, #175F30);
            background-repeat: no-repeat;
            background-position: top left;
        }
        
        .content {
            flex-grow: 1;
            overflow-y: auto;
        }

        .main-content {
            padding: 20px;
        }

        .header {
            background-color: white;
            color: #666;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: -webkit-sticky; /* Safari */
            position: sticky;
            top: 0;
            z-index: 1000;
            border-radius: 10px; /* Rounded edges */
            margin: 10px; /* Margin to prevent clipping */
        }

        .header .search-bar {
            display: flex;
            align-items: center;
            background-color: #f4f4f4;
            padding: 10px 20px;
            border-radius: 20px;
            width: 100%;
            max-width: 500px;
        }

        .header .search-bar input {
            border: none;
            background: none;
            outline: none;
            margin-left: 10px;
            font-size: 16px;
            width: 100%;
        }

        .header .icons {
            display: flex;
            align-items: center;
        }

        .header .icons span {
            margin-left: 20px;
            font-size: 25px;
            cursor: pointer;
        }
    </style>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    
    <div class="sidebar">
        <div class="profile">        
        	<c:if test="${empty sessionScope.loginuser.img_name}"> <%-- 이미지가 없을 경우 --%>
            	<img src="<%=ctxPath%>/resources/images/student.png" alt="Profile Picture">
            </c:if>
            <c:if test="${not empty sessionScope.loginuser.img_name}"> <%-- 이미지가 있을 경우 --%>
            	<img src="<%=ctxPath%>/resources/files/${sessionScope.loginuser.img_name}" alt="Profile Picture">
            </c:if>
            <h3 style="color:black;">${sessionScope.loginuser.name}</h3>
            <p style="color:black;">학번 : ${sessionScope.loginuser.student_id}</p>
            <p style="color:black;">${sessionScope.loginuser.department_name}</p>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="<%=ctxPath%>/student/dashboard.lms" class="nav-link active"><span class="icon">🏠</span>대쉬보드</a></li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="classesMenu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📚</span>수업</a>
                <div class="dropdown-menu" aria-labelledby="classesMenu">
                    <a class="dropdown-item" href="<%=ctxPath%>/student/classList.lms">내 수업</a>
                    <a class="dropdown-item" href="<%=ctxPath%>/student/courseRegister.lms">수강신청</a>
                    <a class="dropdown-item" href="#">출석현황</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" href="#" id="scheduleMenu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📅</span>스케줄</a>
                <div class="dropdown-menu" aria-labelledby="scheduleMenu">
                    <a class="dropdown-item" href="#">시간표</a>
                    <a class="dropdown-item" href="#">과제</a>
                    <a class="dropdown-item" href="#">시험</a>
                    <a class="dropdown-item" href="#">오늘 할 일</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" href="#" id="gradesMenu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📈</span>성적</a>
                <div class="dropdown-menu" aria-labelledby="gradesMenu">
                    <a class="dropdown-item" href="#">학점 통계</a>
                    <a class="dropdown-item" href="#">취득 현황</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" href="#" id="groupsMenu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">👥</span>커뮤니티</a>
                <div class="dropdown-menu" aria-labelledby="groupsMenu">
                    <a class="dropdown-item" href="#">내 친구</a>
                    <a class="dropdown-item" href="#">커뮤니티</a>
                </div>
            </li>
            <li class="nav-item"><a href="<%=ctxPath%>/student/myInfo.lms" class="nav-link"><span class="icon">⚙️</span>내정보</a></li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="certificatesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon">📜</span>증명서
                </a>
                <div class="dropdown-menu" aria-labelledby="certificatesDropdown">
                    <a class="dropdown-item" href="#certificate1">성적증명서</a>
                    <a class="dropdown-item" href="#certificate2">재학증명서</a>
                    <a class="dropdown-item" href="#certificate3">졸업증명서</a>
                </div>
            </li>
            <li class="nav-item"><a href="<%=ctxPath%>/logout.lms" class="nav-link"><span class="icon">➡️</span>로그아웃</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header sticky-top">
            <div class="search-bar">
                <span class="icon">🔎</span>
                <input type="text" placeholder="메뉴검색">
            </div>
            <div class="icons">
                <span class="icon">📫</span>
                <span class="icon">🔔</span>
                <span class="icon">❔</span>
            </div>
        </div>
        
        <div class="main-content">
            <tiles:insertAttribute name="content" />
        </div>
    </div>
</body>
</html>
