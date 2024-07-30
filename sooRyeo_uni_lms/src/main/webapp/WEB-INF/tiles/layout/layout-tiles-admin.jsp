<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<%
	String ctxPath = request.getContextPath();
%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Styled Sidebar</title>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!--     <link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/4.3.1/gridstack.min.css" rel="stylesheet"/> -->
<%-- <link href="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack.min.css" rel="stylesheet"/> --%>

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
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
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
	width: 100px;
	height: 100px;
	border-radius: 50%;
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
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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

/*         .grid-stack-item-content {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .grid-stack-item-content:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        } */
</style>
</head>
<body>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	
	
	


	<div class="sidebar">
		<div class="profile">
			<img src="https://via.placeholder.com/100" alt="Profile Picture">
			<h3>${requesetScope.loginuser.name }</h3>
			<p>${requesetScope.loginuser.department_name}</p>
		</div>
		<ul class="nav flex-column">
			<li class="nav-item"><a href="<%=ctxPath %>/admin/dashboard.lms" class="nav-link active"><span class="icon">🏠</span>대쉬보드</a></li>

			<li class="nav-item dropdown"><a href="#classes" class="nav-link dropdown-toggle" id="classesMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📚</span>회원관리</a>
				<div class="dropdown-menu" aria-labelledby="classesMenu">
					<a class="dropdown-item" href="<%=ctxPath%>/admin/MemberList.lms">회원조회</a> 
					<a class="dropdown-item" href="<%=ctxPath%>/admin/MemberCheck.lms">학적승인</a> 
					<a class="dropdown-item" href="<%=ctxPath%>/admin/MemberRegister.lms">학생등록</a>
					<a class="dropdown-item" href="<%=ctxPath%>/admin/ProfessorRegister.lms">교수등록</a>
				</div></li>
			<li class="nav-item"><a href="#schedule" class="nav-link dropdown-toggle" id="scheduleMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📅</span>수업관리</a>
				<div class="dropdown-menu" aria-labelledby="scheduleMenu">
					<a class="dropdown-item" href="<%=ctxPath%>/admin/add_curriculum.lms">커리큘럼 추가</a> 
					<a class="dropdown-item" href="<%=ctxPath%>/admin/curriculum.lms">커리큘럼 관리</a> 
					<a class="dropdown-item" href="<%=ctxPath%>/admin/courseRegister.lms">강의관리</a>
				</div></li>
			<li class="nav-item"><a href="#grades" class="nav-link dropdown-toggle" id="gradesMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📈</span>장학금관리</a>
				<div class="dropdown-menu" aria-labelledby="gradesMenu">
					<a class="dropdown-item" href="#">장학생등록</a> 
				</div>
			</li>
			<li class="nav-item"><a href="#groups" class="nav-link dropdown-toggle" id="groupsMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">👥</span>커뮤니티관리</a>
				<div class="dropdown-menu" aria-labelledby="groupsMenu">
					<a class="dropdown-item" href="#">내 친구</a> 
					<a class="dropdown-item" href="<%=ctxPath%>/board/addList.lms">공지사항쓰기</a>
					<a class="dropdown-item" href="<%=ctxPath%>/board/announcement.lms">학사공지사항</a>
				</div>
			</li>
			<li class="nav-item">
				<a href="#settings" class="nav-link">
					<span class="icon">⚙️</span>내정보
				</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="certificatesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <span class="icon">📜</span>증명서
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
				<span class="icon">🔎</span> <input type="text" placeholder="메뉴검색">
			</div>
			<div class="icons">
				<span class="icon">📫</span> <span class="icon">🔔</span> <span class="icon">❔</span>
			</div>
		</div>


		<div class="main-content">

			<tiles:insertAttribute name="content" />


		</div>

		<!--         <div class="main-content grid-stack">
            <div class="grid-stack-item" data-gs-width="4" data-gs-height="2">
                <div class="grid-stack-item-content">Item 1</div>
            </div>
            <div class="grid-stack-item" data-gs-width="4" data-gs-height="2">
                <div class="grid-stack-item-content">Item 2</div>
            </div>
            <div class="grid-stack-item" data-gs-width="4" data-gs-height="2">
                <div class="grid-stack-item-content">Item 3</div>
            </div>
        </div>
 -->
	</div>

	<!-- Bootstrap JS and dependencies -->


	<%--     <script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
    <script type="text/javascript">
        var grid = GridStack.init();
    </script> --%>
</body>
</html>
