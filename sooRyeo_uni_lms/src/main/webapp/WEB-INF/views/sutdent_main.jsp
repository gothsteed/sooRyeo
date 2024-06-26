<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String ctxPath = request.getContextPath();
%> 

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Styled Sidebar</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="<%=ctxPath %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            background-color: #f4f4f4;
        }

        .sidebar {
            width: 300px;
            background-color: white;
            color: #666;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
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
            color: #999;
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
            font-size: 16px;
            transition: background 0.3s ease, color 0.3s ease;
            border-radius: 20px;
        }

        .sidebar ul li a .icon {
            margin-right: 10px;
            font-size: 18px;
        }

        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #00308F;
            color: white;
        }

        .sidebar ul li a.active .icon {
            color: white;
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

        nav {
            background-color: #333;
            color: #fff;
            display: flex;
            justify-content: center;
            padding: 10px 0;
        }

        nav ul {
            display: flex;
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        nav li {
         margin: 0 20px;
        }

        nav a {
            color: #fff;
            text-decoration: none;
        }

        nav a:hover {
            color: #ccc;
        }



    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <img src="https://via.placeholder.com/100" alt="Profile Picture">
            <h3>이정연</h3>
            <p>컴퓨터 공학부</p>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="#dashboard" class="nav-link active"><span class="icon">🏠</span>대쉬보드</a></li>
            <li class="nav-item"><a href="#classes" class="nav-link"><span class="icon">📚</span>수업</a></li>
            <li class="nav-item"><a href="#schedule" class="nav-link"><span class="icon">📅</span>스케줄</a></li>
            <li class="nav-item"><a href="#grades" class="nav-link"><span class="icon">📈</span>성적</a></li>
            <li class="nav-item"><a href="#groups" class="nav-link"><span class="icon">👥</span>친구</a></li>
            <li class="nav-item"><a href="#settings" class="nav-link"><span class="icon">⚙️</span>내정보</a></li>
            <li class="nav-item"><a href="#trash" class="nav-link"><span class="icon">📜</span>증명서</a></li>
            <li class="nav-item"><a href="#logout" class="nav-link"><span class="icon">➡️</span>로그아웃</a></li>
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

            <div class="row">
                <div class="col-sm-4" style="height: 20rem;">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="card-title">Special title treatment</h5>
                      <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                    </div>
                  </div>
                </div>
                <div class="col-sm-8">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="card-title">Special title treatment</h5>
                      <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                    </div>
                  </div>
                </div>
            </div>
	
            <!-- Nav tabs -->
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="#school_info" style="font-weight: bold; font-size: 14pt; color: #1D4A7A;">학사공지</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#Recruit_info" style="font-weight: bold; font-size: 14pt; color: #1D4A7A;">채용공지</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#department_info" style="font-weight: bold; font-size: 14pt; color: #1D4A7A;">학과공지</a>
                </li>
            </ul>

   
            <!-- Tab panes -->
            <div class="tab-content pt-5 pb-5">

                <div class="tab-pane container active" id="school_info" style="font-size: 9pt;">
                    학사공지
                </div>
              
                <div class="tab-pane container fade" id="Recruit_info">
                    채용공지
                </div>
                
                <div class="tab-pane container fade" id="department_info">
                    학과공지
                </div>
            </div>




        </div>

      

    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>