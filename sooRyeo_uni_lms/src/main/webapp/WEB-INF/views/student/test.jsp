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

	  let time = ${requestScope.examView.secondsTillEnd}; // 타이머 시간을 10분으로 지정함.
    console.log(time);

	  // === 타이머 함수 만들기 시작 === //
	  const timer = function () {
	    if (time < 0) {
	      alert("시험시간이 종료되었습니다.\n자동으로 제출됩니다.");

	      clearInterval(interval_timer); // 타이머 삭제하기

	      timeoutSubmit(); // 제출하는 함수 호출
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

function goCheck() {
/*
    var answers = {};
    $("input[type='text']").each(function() {
        var id = $(this).attr('id');
        var value = $(this).val();
        answers[id] = value;
        
        // 입력한 답안을 해당 ID의 <td>에 자동으로 채워넣기
        $("#sel" + id).text(value);

    });
    $.ajax({
        url: "testCheck.lms",
        type: "post",
        async: true,
        dataType: "json",
        data: answers,  // 수집한 답안 데이터를 전송
        success: function(json) {
            $("button#submit_div").css({ display: "none" });
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });
*/
    
    
    if(confirm("정말로 제출하시겠습니까?")){
		const frm = document.SelectAnswer
		
		 console.log(frm);

		frm.method = "post";
		frm.action = "<%= ctxPath%>/exam/SelectAnswer.lms";
		frm.submit();
	}
	else{
		return;
	}
    
};

function timeoutSubmit() {

		const frm = document.SelectAnswer
		console.log(frm);
		
		frm.method = "post";
		frm.action = "<%= ctxPath%>/exam/SelectAnswer.lms";
		frm.submit();
    
};

</script>


<div class="body d-flex">
    <div style="flex:85%; min-width: 0;">
        <div class="card">
			<div class="card-header d-flex">
			    <span style="flex: 1;">시험지</span>
			    <span id="timer" style="font-weight: bold;"></span>
			</div>
            <div class="card-body">
                <p class="card-text">
                    <iframe width="100%" height="600" src="<%= ctxPath %>/resources/files/${examView.file_name}#toolbar=0&navpanes=0&scrollbar=0"></iframe>
                </p>
            </div>
        </div>
    </div>
    <div style="flex:15%; min-width: 0;">
        <div class="card">
            <div class="card-header text-center">
                답안지
            </div>
            <div class="card-body text-center" style="display: flex; flex-direction: column; justify-content: space-between; height: 100%;">
                <form name="SelectAnswer" style="flex: 1;">
                    <c:forEach begin="1" end="${requestScope.examView.question_count}" varStatus="questionStatus">
                        <div>${questionStatus.index}. 
                            <input name="${questionStatus.index}" type="text" style="width:30%; margin-bottom:5%" maxlength="1"/>
                        </div>
                    </c:forEach>
                    <input name="selCount" style="display: none;" value="${requestScope.examView.question_count}"/>
                    <input name="schedule_seq" style="display: none;" value="${requestScope.schedule_seq}"/>
                </form>
                <button id="submit_div" class="btn btn-success btn-lg" style="font-size:16pt; font-weight: bold; margin-top: 1%;" type="button" onclick="goCheck()">제출하기</button>
            </div>
        </div>
    </div>
</div>