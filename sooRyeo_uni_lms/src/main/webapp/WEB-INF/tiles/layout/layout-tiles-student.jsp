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
            position: relative;
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

		#displayList {
		    max-height: 250px; /* 최대 높이 설정 */
		    background-color: #f4f4f4; /* 배경색 변경 */
		    margin-left: 50px; /* 검색 바와의 간격 */
		    height: auto; /* 내용에 따라 자동 높이 조정 */
		    box-sizing: border-box; /* 패딩과 경계를 너비에 포함 */
		    position: absolute; /* 헤더와 겹치도록 절대 위치 설정 */
		    z-index: 10000; /* .header보다 높은 z-index */
		    overflow: auto; /* 내용이 넘칠 경우 스크롤 추가 */
		    border-radius: 0 0 20px 20px; /* 모서리 둥글게 */
		    padding: 10px; /* 내부 여백 추가 */
		    padding-left: 20px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 추가 */
		    transition: box-shadow 0.3s; /* 마우스 오버 시 효과를 위한 전환 */
		    opacity: 0.9;
		    border: none;
		    margin-left:2.5%;
		    width: 100%;
		}
		
		span.result:hover {
			color: purple;
			font-weight: bold;
		
		}

    	#alertLecture {
		    
	        width: 300px; /* 넓은 알림창 */
		    max-height: 400px; /* 높이 조정 */
		    background-color: #ffffff; /* 배경색을 하얀색으로 설정 */
		    border: 1px solid #e0e0e0; /* 연한 회색 테두리 */
		    border-radius: 8px; /* 부드러운 모서리 */
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
		    position: absolute; /* 절대 위치 지정 */
		    z-index: 10000; /* 높은 z-index */
		    overflow-y: auto; /* 내용 넘침 처리 */
		    right: 10px; /* 오른쪽에서의 위치 */
		    padding: 15px; /* 내부 여백 */
		    font-family: Arial, sans-serif; /* 간결한 글꼴 */
		    color: #333; /* 어두운 텍스트 색상 */
		}
        
        /* 알림 항목 스타일 */
		.result2 {
		    display: block;
		    padding: 10px;
		    margin-bottom: 10px;
		    border-radius: 5px;
		    background-color: #f4f4f9; /* 항목 배경색 */
		    color: #555; /* 텍스트 색상 */
		    cursor: pointer; /* 클릭 커서 */
		    transition: background-color 0.3s ease, color 0.3s ease; /* 부드러운 색상 전환 */
		}
		
		.result2:hover {
		    background-color: #e0e0e0; /* 호버 시 배경색 */
		    color: #333; /* 호버 시 텍스트 색상 */
		}
		
		#lectureAlertSpan {
		    color: #6a0dad; /* 교수 이름과 수업명에 사용될 색상 */
		    font-weight: bold; /* 강조된 텍스트 */
		}
    </style>

</head>
<body>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    
<script type="text/javascript">

$(document).ready(function(){
	
	$("div#alertLecture").hide();
	
	$.ajax({
		  url: "<%= ctxPath%>/student/alertLecture.lms",
		  method: 'GET',
		  dataType: 'json', // 예상되는 서버 응답의 데이터 타입
		  success: function(response) {
		    // 성공적으로 데이터를 받았을 때 처리할 코드
			  if(response == ""){ // 데이터가 없을때
			    $("span#bell").text("🔔");
			  
			  }
			  else{ // 데이터가 있을때 
			    $("span#bell").text("🔔");
			  
			  document.getElementById('bell').innerHTML += `

	                <div class="badge" id="unreadCountBadge" style="position: absolute; right: 4.3%; background-color: red; color:white; align-content: center; font-size: 12px; border-radius: 50%; width: 23px; height: 23px;">
	                	\${response.length}
	                </div>

	                `;
			  
			  
			  }// else---------------------------------
		  },
		  error: function(request, status, error){
	          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	});
	
	$("div#displayList").hide();
	
	$("input[name='searchWord']").keyup(function(){
		
		const wordLength = $(this).val().trim().length;
		// 검색어에서 공백을 제외한 길이를 알아온다.
		
		if(wordLength == 0){
			$("div#displayList").hide();
			// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
		}
		else{
			$.ajax({
				url:"<%= ctxPath%>/student/wordSearchShow.lms",
				type:"get",
				data:{"searchWord":$("input[name='searchWord']").val()},
				dataType:"json",
				success:function(json){
					<%-- #120. 검색어 입력시 자동글 완성하기 7 --%>
					if(json.length > 0){
						// 검색된 데이터가 있는 경우임.
						
						let v_html = ``;
						
						$.each(json, function(index, item){
							
							const urlIdx = item.name.indexOf(",");
							
							const name = item.name.substring(0,urlIdx);
							const url = item.name.substring(urlIdx+1);
							
							// word ==> javascript 는 재미가 있어요
							// word ==> 그러면 javaScript  는 뭔가요? ==> 대문자 포함됨
							
							// word.toLowerCase() 은 word 를 모두 소문자로 변경하는 것이다.
							// word ==> javascript 는 재미가 있어요
							// word ==> 그러면 javascript  는 뭔가요? ==> 대문자 사라짐
							
							const idx = name.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
							// 만약에 검색어가 JavA 같이 적었다면
							/*
								그러면 javascript  는 뭔가요?   는 idx 가 4 이다.
								javascript 는 재미가 있어요             는 idx 가 0 이다.
							*/
							
							const len = $("input[name='searchWord']").val().length;
							// 검색어(JavA)의 길이 len은 4가 된다.
							/*
								console.log("~~~~~ 시작 ~~~~~");
								console.log(word.substring(0,idx));         // 검색어 전까지         ==> 저는
								console.log(word.substring(idx,idx + len)); // 검색어                   ==> java
								console.log(word.substring(idx + len));     // 검색어 이후 나머지  ==> 에 대해서 궁금해요~~
								console.log("~~~~~ 끝 ~~~~~");
							*/
							const result = `<img src='<%=ctxPath%>/resources/images/glass.png' style='width:15px; height:15px; margin-right:4%; vertical-align: middle;'>` 
											+ "<span style='vertical-align: middle;'>" + name.substring(0, idx) + "</span>" 
											+ "<span style='color:purple; font-weight:bold; vertical-align: middle;'>" + name.substring(idx, idx + len) + "</span>" 
											+ "<span style='vertical-align: middle;'>" + name.substring(idx + len) + "</span>";
							
							v_html += `<span style='cursor:pointer;' data-custom="\${url}" class='result'><br>\${result}<br></span>`;
						}); // end of $.each(json, function(index, item){})------------------------------------
						
						const input_width = $("input[name='searchWord']").css("width"); // 검색어 input 태그 width 값 알아오기
						
						$("div#displayList").css({"width":input_width}); // 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기 
						
						$("div#displayList").html(v_html);
						
						$("div#displayList").show();
					}
				},
				error: function(request, status, error){
		          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			});// ajax------------------------------
		}
	
	}); // $("input[name='searchWord']").keyup(function(){})-------------------------------
		
	<%-- #121. 검색어 입력시 자동글 완성하기 8 --%>
	$(document).on("click", "span.result", function(e){
		
		const url = $(this).data('custom');
		const name = $(this).text();
		
		$("input[name='searchWord']").val(name); // 텍스트 박스에 검색된 결과의 문자열을 입력해준다. 클릭하면 그 클릭한 문장을 검색 텍스트에 적어주는 것.
		$("div#displayList").hide(); // 검색할 문장을 선택했으면 리스트를 숨겨주는 것
		
		location.href = `<%=ctxPath%>\${url}`;
		
	}); // end of $(document).on("click", "span.result", function(e)
			
	
	// 마우스로 다른 곳을 클릭 시 검색 결과 리스트 숨기기
	$(document).click(function(e) {
		if (!$(e.target).closest("div#displayList").length && !$(e.target).is("input[name='searchWord']")) {
			$("div#displayList").hide();
		}
	});
	
	

});

function alertLecture(){
	
	$("div#alertLecture").hide();
	
	$.ajax({
		  url: "<%= ctxPath%>/student/alertLecture.lms",
		  method: 'GET',
		  dataType: 'json', // 예상되는 서버 응답의 데이터 타입
		  success: function(response) {

		    let v_html = ``;
		    
		    if(response != ""){
			  	$.each(response, function(index, item){
	
					const lecName = item.Lname;
					const profName = item.Pname;
					const lId = item.LId;
					const id = item.Id;
			  		
					const result ="<span id='lectureAlertSpan' style='color:purple;'>"+ profName + "교수님의 " + "'"+lecName+ "' " +"수업이 추가되었습니다."+"</span>";
					
					v_html += `<span style='cursor:pointer;' data-custom="\${lId}" data-role="\${id}" class='result2'>\${result}<br></span>`
					
				}); // end of $.each(json, function(index, item){})------------------------------------
			  	
				$("div#alertLecture").html(v_html);
				
				$("div#alertLecture").show();
		    }
		  },
		  error: function(request, status, error){
	          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	});
	
	$(document).on("click", "span.result2", function(e){
		
		const url = $(this).data('custom');
		const id = $(this).data('role');
		
		$("div#alertLecture").hide(); // 검색할 문장을 선택했으면 리스트를 숨겨주는 것
		
		$.ajax({
			  url: "<%= ctxPath%>/student/alertLectureDel.lms",
			  method: 'GET',
			  dataType: 'json', // 예상되는 서버 응답의 데이터 타입
		      data: {id: id},
			  success: function(response) {

				alert(response.alertLecture); // undefined
				  
				if(response.alertLecture == null){
					location.href = `<%=ctxPath%>/student/myLecture.lms?course_seq=\${url}`;
				}
				else{
					alert("오류발생");
				}
			  },
			  error: function(request, status, error){
		          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		});
	});
}
function alertLecture1(){
	$("div#alertLecture").hide();
}
</script>
    
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
                    <a class="dropdown-item" href="<%=ctxPath%>/student/attendance.lms">출석현황</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" href="#" id="scheduleMenu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📅</span>스케줄</a>
                <div class="dropdown-menu" aria-labelledby="scheduleMenu">
                    <%-- <a class="dropdown-item" href="<%=ctxPath%>/student/lectureList.lms">시간표</a>
                    <a class="dropdown-item" href="#">과제</a>
                    <a class="dropdown-item" href="#">시험</a> --%>
                    <a class="dropdown-item" href="<%=ctxPath%>/student/scheduleManagement.lms">캘린더</a>
                    <a class="dropdown-item" href="<%=ctxPath%>/student/consult.lms">상담</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" href="#" id="gradesMenu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="icon">📈</span>성적</a>
                <div class="dropdown-menu" aria-labelledby="gradesMenu">
                    <a class="dropdown-item" href="<%=ctxPath%>/student/Statistics.lms">학점 통계</a>
                    <a class="dropdown-item" href="<%=ctxPath%>/student/Acquisition_status.lms">취득 현황</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" href="#" id="groupsMenu" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                	<span class="icon">👥</span>커뮤니티
                </a>
                <div class="dropdown-menu" aria-labelledby="groupsMenu">
                    <a class="dropdown-item" href="<%=ctxPath %>/student/chatting.lms">채팅</a>
<!--                     <a class="dropdown-item" href="#">내 친구</a>
                    <a class="dropdown-item" href="#">커뮤니티</a> -->
                    <a class="dropdown-item" href="<%=ctxPath %>/board/announcement.lms">학사공지사항</a>
                </div>
            </li>
            <li class="nav-item"><a href="<%=ctxPath%>/student/myInfo.lms" class="nav-link"><span class="icon">⚙️</span>내 정보</a></li>
            <li class="nav-item">
                <a class="nav-link" href="<%=ctxPath%>/student/certificate/menu.lms" id="certificatesDropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    <span class="icon">📜</span>증명서
                </a>
<%--                <div class="dropdown-menu" aria-labelledby="certificatesDropdown">
                    <a class="dropdown-item" href="#certificate1">성적증명서</a>
                    <a class="dropdown-item" href="#certificate2">재학증명서</a>
                    <a class="dropdown-item" href="#certificate3">졸업증명서</a>
                </div>--%>
            </li>
            <li class="nav-item"><a href="<%=ctxPath%>/logout.lms" class="nav-link"><span class="icon">➡️</span>로그아웃</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header sticky-top">
            <div style="width:100%;">
	            <div class="search-bar">
	                <span class="icon">🔎</span>
	                <input type="text" name="searchWord" placeholder="메뉴검색" autocomplete='off'>
	            </div>
	            <div id="displayList"></div>
            </div>
            <div>
	            <div class="icons">
	                <span class="icon">📫</span>
	                <span class="icon" id="bell" onclick="alertLecture()" ></span>
	                <span class="icon">❔</span>
	            </div>
	            <div class="dropdown" id="alertLecture">
	            </div>
            </div>
        </div>
        
        <div class="main-content">
            <tiles:insertAttribute name="content" />
        </div>
    </div>
</body>
</html>
