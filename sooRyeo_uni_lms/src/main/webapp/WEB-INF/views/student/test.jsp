<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>

<style>
.body {
    display: flex;
}

.card {
    height: 100%; /* Ensure each card expands to fill its container */
}
</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>


<script type="text/javascript">
$(document).ready(function () {
	
	  // const btnSubmit = $("button#btnSubmit"); // "제출하기" 버튼

	  const h2_timer = $("#timer"); // 타이머를 보여줄 장소

	  let time = ${requestScope.examView.end_date_seconds}; // 타이머 시간을 10분으로 지정함.

	  // === 타이머 함수 만들기 시작 === //
	  const timer = function () {
	    if (time < 0) {
	      alert("시험시간 종료!!\n자동으로 제출됩니다.");

	      clearInterval(interval_timer); // 타이머 삭제하기
	      // interval_timer 는 중단해야할 setInterval 함수를 가리키는 것이다.

	     // btnSubmit.attr("disabled", true); // "제출하기" 버튼 비활성화
	      // [참고] btnSubmit.attr('disabled', false); // "제출하기" 버튼 활성화

	      check(); // 채점하는 함수 호출
	    } else {
	      let minute = "";
	      let second = "";


	      minute = parseInt(time / 60); // 소수부는 없애 버리고 정수부만 가져오는 것이다.
	      if (minute < 10) {
	        minute = "0" + minute;
	      }

	      second = time % 60; // time 을 60으로 나누었을때의 나머지
	      if (second < 10) {
	        second = "0" + second;
	      }

	      h2_timer.html(`남은 시간 : \${minute}분 \${second}초`);

	      time--;
	    }
	  };
	  // === 타이머 함수 만들기 끝 === //

	  timer(); // 타이머 함수 호출

	  // const interval_timer = setInterval(function(){ timer(); }, 1000); // 1초 마다 주기적으로 타이머 함수가 호출되도록 지정함.
	  // 또는
	  const interval_timer = setInterval(timer, 1000); // 1초 마다 주기적으로 타이머 함수가 호출되도록 지정함.
});

function goCheck(){
	
	$.ajax({
        url:"testCheck.lms",
        type:"post", 
        async:true,  
        dataType : "json", 
        success:function(json){

			  $("div#submit_div").css({ display: "none" }); // 제출하기 버튼 영역은 안보이도록 한다.
        	
        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });
};

</script>


<div class="body d-flex">
    <div style="flex:90%; min-width: 0;">
        <div class="card">
			<div class="card-header d-flex">
			    <span style="flex: 1;">시험지</span>
			    <span id="timer" style="font-weight: bold;"></span>
			</div>
            <div class="card-body">
                <p class="card-text">
                    <iframe width="100%" height="600" src="<%= ctxPath %>/resources/exam/${examView.file_name}#toolbar=0&navpanes=0&scrollbar=0"></iframe>
                </p>
            </div>
        </div>
    </div>
    <div style="flex:10%; min-width: 0;">
        <div class="card">
            <div class="card-header">
                	답안지
            </div>
            <div class="card-body">
                <p class="card-text">
				    <c:forEach begin="1" end="${requestScope.examView.question_count}" varStatus="questionStatus">
				        <div>${questionStatus.index}. <input id="${questionStatus.index}" type="text" style="width:50%; margin-bottom:5%" maxlength="1"/></div>
				    </c:forEach>
                </p>
            </div>
        </div>
    </div>
</div>

        <div class="card">
            <div class="card-header">
                	답안지
            </div>
            <div class="card-body">
                <p class="card-text">
                
					<table class="table">
					  <thead>
					    <tr>
					      <th scope="col">#</th>
					      <c:forEach begin="1" end="${requestScope.examView.question_count}" varStatus="questionStatus">
						      <th scope="col">${questionStatus.index}번</th>
					      </c:forEach>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="row">정답</th>
					      <c:forEach begin="1" end="${requestScope.examView.question_count}" varStatus="questionStatus">
 						      <td id="co${questionStatus.index}">1</td>
					      </c:forEach>
					    </tr>
					    <tr>
					      <th scope="row">선택한 답</th>
					      <c:forEach begin="1" end="${requestScope.examView.question_count}" varStatus="questionStatus">
						      <td id="sel${questionStatus.index}">1</td>
					      </c:forEach>
					    </tr>
					    <tr>
					      <th scope="row">채점결과</th>
					      <c:forEach begin="1" end="${requestScope.examView.question_count}" varStatus="questionStatus">
						      <td id="res${questionStatus.index}">1</td>
					      </c:forEach>
					    </tr>
					  </tbody>
					</table>
                	
            </div>
        </div>
        
<button id="login" class="btn btn-success btn-lg" style="font-size:16pt; font-weight: bold; margin-top: 1%;" type="button" onclick="goCheck()">제출하기</button>

		
