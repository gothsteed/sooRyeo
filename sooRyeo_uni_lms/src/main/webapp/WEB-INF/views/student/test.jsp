<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	  let time = 600; // 타이머 시간을 10분으로 지정함.

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

	      h2_timer.html(`\${minute}:\${second}`);

	      time--;
	    }
	  };
	  // === 타이머 함수 만들기 끝 === //

	  timer(); // 타이머 함수 호출

	  // const interval_timer = setInterval(function(){ timer(); }, 1000); // 1초 마다 주기적으로 타이머 함수가 호출되도록 지정함.
	  // 또는
	  const interval_timer = setInterval(timer, 1000); // 1초 마다 주기적으로 타이머 함수가 호출되도록 지정함.
});
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
                    	시험지 pdf가 들어갈 곳
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
                    <div>1. <input type="text" style="width:50%; margin-bottom:5%" maxlength="1"/></div>
                    <div>2. <input type="text" style="width:50%; margin-bottom:5%" maxlength="1"/></div>
                    <div>3. <input type="text" style="width:50%; margin-bottom:5%" maxlength="1"/></div>
                </p>
            </div>
        </div>
    </div>
</div>

<button id="login" class="btn btn-success btn-lg" style="font-size:16pt; font-weight: bold; margin-top: 1%;" type="button" onclick="">제출하기</button>

		
