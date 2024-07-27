<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String ctxPath = request.getContextPath();
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Terms Agreement</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .terms-scroll {
            height: 210px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card shadow">
                <div class="card-header bg-danger text-white">
                    <h3 class="mb-0">응시 전 서약</h3>
                </div>
                <div class="card-body">
                    <p class="mb-3">서버시간: <span id="server-time" class="fw-bold text-primary"></span></p>

                    <div class="card mb-3">
                        <div class="card-header">
                            서약서
                        </div>
                        <div class="card-body terms-scroll">
                            <p>시험에 응시하기 전에 다음 서약서을 읽고 동의해 주시기 바랍니다:</p>
                            <ol>
                                <li>외부의 도움 없이 독립적으로 시험을 완료할 것에 동의합니다.</li>
                                <li>시험 내용을 다른 사람과 공유하지 않으며, 시험 중에 허가되지 않은 자료를 사용하지 않을 것에 동의합니다.</li>
                                <li>시험 중의 행동이 학문적 성실성 목적으로 모니터링될 수 있음을 이해합니다.</li>
                                <li>시험에 설정된 시간 제한을 준수할 것에 동의합니다.</li>
                                <li>이 약관을 위반할 경우 징계 조치를 받을 수 있음을 인정합니다.</li>
                            </ol>
                        </div>

                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="agree-checkbox">
                        <label class="form-check-label" for="agree-checkbox">
                            모든 사항을 읽었고 동의합니다
                        </label>
                    </div>

                    <button id="agree-button" class="btn btn-success" disabled>응시하기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="redirectForm" action="<%=ctxPath%>/student/exam/test.lms" method="post" style="display:none;">
    <input type="hidden" name="schedule_seq" id="scheduleSeqInput">
</form>

<script>
    function updateServerTime() {
        const now = new Date();
        document.getElementById('server-time').textContent = now.toLocaleString();
    }

    function updateAgreeButton() {
        const agreeCheckbox = document.getElementById('agree-checkbox');
        const agreeButton = document.getElementById('agree-button');
        agreeButton.disabled = !agreeCheckbox.checked;
    }

    // Update server time every second
    setInterval(updateServerTime, 1000);

    // Initial call to display the time immediately
    updateServerTime();

    // Add event listener to checkbox
    document.getElementById('agree-checkbox').addEventListener('change', updateAgreeButton);

    // Add event listener to button
    document.getElementById('agree-button').addEventListener('click', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const scheduleSeq = urlParams.get('schedule_seq');
        console.log(scheduleSeq)

        alert('You have agreed to the terms. Redirecting to the exam page...');
        // Here you would typically redirect to the actual exam page
        // window.location.href = 'exam-page.html';

        document.getElementById('scheduleSeqInput').value = scheduleSeq;

        // Submit the form
        document.getElementById('redirectForm').submit();


    });
</script>
</body>
</html>