<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %> 
<!DOCTYPE html>
<% String ctxPath = request.getContextPath(); %>
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
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            font-weight: bold;
        }

		.sidebar ul li:hover {
			background-color: white;
			margin-left: 10%;
			width:85%;
		
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

		/* Timeline holder */
		ul.timeline {
		    list-style-type: none;
		    position: relative;
		    padding-left: 1.5rem;
		}
		
		 /* Timeline vertical line  일자 바*/
		ul.timeline:before {
		    content: ' ';
		    background: #E2E2E2;
		    display: inline-block;
		    position: absolute;
		    left: 16px;
		    width: 4px;
		    height: 100%;
		    z-index: 400;
		    border-radius: 1rem;
		}
		
		li.timeline-item {
		    margin: 20px 0;
		}
		
		/* Timeline item arrow */
		.timeline-arrow-1 {
		    border-top: 0.5rem solid transparent;
		    border-right: 0.5rem solid #D6F1EA;
		    border-bottom: 0.5rem solid transparent;
		    display: block;
		    position: absolute;
		    left: 2rem;
		}
		.timeline-arrow-2 {
		    border-top: 0.5rem solid transparent;
		    border-right: 0.5rem solid #C9E9F8;
		    border-bottom: 0.5rem solid transparent;
		    display: block;
		    position: absolute;
		    left: 2rem;
		}
		.timeline-arrow-3 {
		    border-top: 0.5rem solid transparent;
		    border-right: 0.5rem solid #FCDFD4;
		    border-bottom: 0.5rem solid transparent;
		    display: block;
		    position: absolute;
		    left: 2rem;
		}
		
		/* Timeline item circle marker  바에 원형모양*/
		li.timeline-item-1::before {
		    content: ' ';
		    background: #99CC99;
		    display: inline-block;
		    position: absolute;
		    border-radius: 50%;
		    border: 3px solid #fff;
		    left: 11px;
		    width: 16px;
		    height: 16px;
		    z-index: 400;
		    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		}
		
		li.timeline-item-2::before {
		    content: ' ';
		    background: #87CEEB;
		    display: inline-block;
		    position: absolute;
		    border-radius: 50%;
		    border: 3px solid #fff;
		    left: 11px;
		    width: 16px;
		    height: 16px;
		    z-index: 400;
		    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		}
		
		li.timeline-item-3::before {
		    content: ' ';
		    background: pink;
		    display: inline-block;
		    position: absolute;
		    border-radius: 50%;
		    border: 3px solid #fff;
		    left: 11px;
		    width: 16px;
		    height: 16px;
		    z-index: 400;
		    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		}
		
		
		
		
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <img src="https://via.placeholder.com/100" alt="Profile Picture">
            <h3>${requesetScope.loginuser.name }</h3>
            <p>${requesetScope.loginuser.department_name}</p>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="#dashboard" class="nav-link active"><span class="icon">🏠</span>대쉬보드</a></li>

            <li class="nav-item dropdown">
                <a href="#classes" class="nav-link dropdown-toggle" id="classesMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📚</span>수업</a>
                <div class="dropdown-menu" aria-labelledby="classesMenu">
                    <a class="dropdown-item" href="#">내 수업</a>
                    <a class="dropdown-item" href="#">수강신청</a>
                    <a class="dropdown-item" href="#">수강취소</a>
                    <a class="dropdown-item" href="#">출석현황</a>
                </div>
            </li>
            <li class="nav-item">
                <a href="#schedule" class="nav-link dropdown-toggle" id="scheduleMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📅</span>스케줄</a>
                <div class="dropdown-menu" aria-labelledby="scheduleMenu" >
                    <a class="dropdown-item" href="#">시간표</a>
                    <a class="dropdown-item" href="#">과제</a>
                    <a class="dropdown-item" href="#">시험</a>
                    <a class="dropdown-item" href="#">오늘 할 일</a>
                </div>
            </li>
            <li class="nav-item">
                <a href="#grades" class="nav-link dropdown-toggle" id="gradesMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📈</span>성적</a>
                <div class="dropdown-menu" aria-labelledby="gradesMenu" >
                    <a class="dropdown-item" href="#">학점 통계</a>
                    <a class="dropdown-item" href="#">취득 현황</a>
                </div>
            </li>
            <li class="nav-item">
                <a href="#groups" class="nav-link dropdown-toggle" id="groupsMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">👥</span>커뮤니티</a>
                <div class="dropdown-menu" aria-labelledby="groupsMenu" >
                    <a class="dropdown-item" href="#">내 친구</a>
                    <a class="dropdown-item" href="#">커뮤니티</a>
                </div>
            </li>
            <li class="nav-item"><a href="#settings" class="nav-link"><span class="icon">⚙️</span>내정보</a></li>
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
                      <h5 class="card-title" style="text-align: center;">캘린더</h5>
                      <div style="height: 355px; text-align: center;">
                        <br><br>
                      		  캘린더 넣을 예정
                      </div>
                    </div>
                  </div>
                </div>

                <!-- 학시 일정 타임라인 -->
                <div class="col-sm-8">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="card-title" style="text-align: center">2024년도 08월 학사 일정</h5>
                      <hr>

                      <div class="row">
                        <div class="col-lg-7 mx-auto">
                            
                            <!-- Timeline -->
                            <ul class="timeline">
                                <li class="timeline-item-1 rounded ml-3 mb-3 p-4 shadow" style="background-color: #D6F1EA; ">
                                    <div class="timeline-arrow-1"></div>
                                    <h5 class="mb-0" style="text-align: center; color: gray;">수강신청 3학년</h5>
                                    <h5 class="mb-0" style="text-align: center;">2024-08-14 ~ 2024-08-19</h5>
                                </li>
                                <li class="timeline-item-2 rounded ml-3 mb-3 p-4 shadow" style="background-color: #C9E9F8; ">
                                    <div class="timeline-arrow-2"></div>
                                    <h5 class="mb-0" style="text-align: center; color: gray;">수강신청 2학년</h5>
                                    <h5 class="mb-0" style="text-align: center;">2024-08-21 ~ 2024-08-26</h5>
                                </li>
                                <li class="timeline-item-3 rounded ml-3 mb-3 p-4 shadow" style="background-color: #FCDFD4; ">
                                    <div class="timeline-arrow-3"></div>
                                    <h5 class="mb-0" style="text-align: center; color: gray;">수강신청 1학년</h5>
                                    <h5 class="mb-0" style="text-align: center;">2024-08-21 ~ 2024-08-26</h5>
                                </li>
                            </ul><!-- End -->
            
                        </div>
                      </div>
                     
                    </div>
                  </div>
                </div><!-- 학시 일정 타임라인 끝-->
            </div>
	
            <!-- Nav tabs -->


            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" data-toggle="tab" data-target="#school_info" style="font-weight: bold; font-size: 14pt; color: #175F30;">학사공지</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" data-toggle="tab" data-target="#Recruit_info" style="font-weight: bold; font-size: 14pt; color: #175F30;">채용공지</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" data-toggle="tab" data-target="#department_info" style="font-weight: bold; font-size: 14pt; color: #175F30;">학과공지</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="school_info" role="tabpanel" aria-labelledby="home-tab">
                    <table style="width: 100%;">
                        <tr style="border : solid 1px #175F30; background-color: #175F30;">
                            <th style="color: #FFFFFF; width: 70%; text-align: center; font-size: 18pt;">제목</th>
                            <th style="color: #FFFFFF; width: 30%; text-align: center; font-size: 18pt;">등록일자</th>
                        </tr>
                        <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px; margin-top: 10%;">
                            <td style="width: 70%; text-align: left; font-size: 15pt; ">
                                2024학년도 2학기 등록금 납부안내 
                            </td>
                            <td style="width: 70%; text-align: center; font-size: 15pt;">
                                24.06.23 
                            </td>
                        </tr>
                        <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                            <td style="width: 70%; text-align: left; font-size: 15pt; ">
                               [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                            </td>
                            <td style="width: 70%; text-align: center; font-size: 15pt;">
                                24.06.28 
                            </td>
                        </tr>
                        <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                            <td style="width: 70%; text-align: left; font-size: 15pt; ">
                               [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                            </td>
                            <td style="width: 70%; text-align: center; font-size: 15pt;">
                                24.06.28 
                            </td>
                        </tr>
                        <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                            <td style="width: 70%; text-align: left; font-size: 15pt; ">
                               [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                            </td>
                            <td style="width: 70%; text-align: center; font-size: 15pt;">
                                24.06.28 
                            </td>
                        </tr>
                        <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                            <td style="width: 70%; text-align: left; font-size: 15pt; ">
                               [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                            </td>
                            <td style="width: 70%; text-align: center; font-size: 15pt;">
                                24.06.28 
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="tab-pane fade" id="Recruit_info" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="tab-pane fade show active" id="school_info" role="tabpanel" aria-labelledby="home-tab">
                        <table style="width: 100%;">
                            <tr style="border : solid 1px #175F30; background-color: #175F30;">
                                <th style="color: #FFFFFF; width: 70%; text-align: center; font-size: 18pt;">제목</th>
                                <th style="color: #FFFFFF; width: 30%; text-align: center; font-size: 18pt;">등록일자</th>
                            </tr>
                            <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px; margin-top: 10%;">
                                <td style="width: 70%; text-align: left; font-size: 15pt; ">
                                    2024학년도 2학기 등록금 납부안내 
                                </td>
                                <td style="width: 70%; text-align: center; font-size: 15pt;">
                                    24.06.23 
                                </td>
                            </tr>
                            <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                                <td style="width: 70%; text-align: left; font-size: 15pt; ">
                                   [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                                </td>
                                <td style="width: 70%; text-align: center; font-size: 15pt;">
                                    24.06.28 
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="department_info" role="tabpanel" aria-labelledby="contact-tab">
                    <div class="tab-pane fade show active" id="school_info" role="tabpanel" aria-labelledby="home-tab">
                        <table style="width: 100%;">
                            <tr style="border : solid 1px #175F30; background-color: #175F30;">
                                <th style="color: #FFFFFF; width: 70%; text-align: center; font-size: 18pt;">제목</th>
                                <th style="color: #FFFFFF; width: 30%; text-align: center; font-size: 18pt;">등록일자</th>
                            </tr>
                            <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px; margin-top: 10%;">
                                <td style="width: 70%; text-align: left; font-size: 15pt; ">
                                    2024학년도 2학기 등록금 납부안내 
                                </td>
                                <td style="width: 70%; text-align: center; font-size: 15pt;">
                                    24.06.23 
                                </td>
                            </tr>
                            <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                                <td style="width: 70%; text-align: left; font-size: 15pt; ">
                                   [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                                </td>
                                <td style="width: 70%; text-align: center; font-size: 15pt;">
                                    24.06.28 
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        
        
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
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<%--     <script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
    <script type="text/javascript">
        var grid = GridStack.init();
    </script> --%>
</body>
</html>
