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
    	#displayList {
		    width: 100%;
		    max-width: 400px; /* Match the search bar's maximum width */
		    max-height: 100px; /* Set a height for the example */
		    background-color: #ddd; /* Just for visibility */
		    margin-left: 50px; /* Space between search bar and #dd */
		    height: 100px;
		    box-sizing: border-box; /* Include padding and border in the width */
   			position: absolute; /* Position absolute to overlap the header */
		    z-index: 10000; /* Higher than .header */
		    overflow:auto;
		}
        
    </style>

</head>
<body>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    
<script type="text/javascript">

$(document).ready(function(){
	

	$.ajax({
		  url: "<%= ctxPath%>/student/alertLecture.lms",
		  method: 'GET',
		  dataType: 'json', // 예상되는 서버 응답의 데이터 타입
		  success: function(response) {
		    // 성공적으로 데이터를 받았을 때 처리할 코드
			  if(response == null){
			    $("span#bell").val("🔔");
			  }
			  else{
			    $("span#bell").val("★");
			  }
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
							
							const result = name.substring(0,idx) + "<span style='color:purple;'>"+name.substring(idx,idx + len)+"</span>" + name.substring(idx + len);
							
							v_html += `<span style='cursor:pointer;' data-custom="\${url}" class='result'>\${result}<br></span>`;
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
		
	});
});

function alertLecture (){
	
	
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
            <li class="nav-item"><a href="<%=ctxPath%>/student/myInfo.lms" class="nav-link"><span class="icon">⚙️</span>내정보</a></li>
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
            <div class="icons">
                <span class="icon">📫</span>
                <span class="icon" id="bell">🔔</span>
                <span class="icon">❔</span>
            </div>
        </div>
        
        <div class="main-content">
            <tiles:insertAttribute name="content" />
        </div>
    </div>
</body>
</html>
