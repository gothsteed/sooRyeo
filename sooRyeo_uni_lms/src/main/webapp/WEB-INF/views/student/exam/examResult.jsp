<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Exam Result</title>

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Highcharts -->
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/histogram-bellcurve.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/highcharts-more.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/solid-gauge.js"></script>
    <script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
    <script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>
    <script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/series-label.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border: none;
        }
        .card-header {
            background-color: #d1e0e0;
            color: white;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4 text-center">시험 결과</h1>

    <div class="row mb-4">
        <div class="col-lg-6 mb-4">
            <div class="card h-100">
                <div class="card-header">
                    <h2 class="h5 mb-0">점수 개요</h2>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>점수:</strong> <span id="totalScore" class="badge bg-primary"></span></p>
                            <p><strong>맞은 개수:</strong> <span id="correctCount" class="badge bg-success"></span></p>
                            <p><strong>틀린 개수:</strong> <span id="wrongCount" class="badge bg-danger"></span></p>
                        </div>
                        <div class="col-md-6">
                            <canvas id="scoreChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mb-4">
            <div class="card h-100">
                <div class="card-header">
                    <h2 class="h5 mb-0">성적 정규분포</h2>
                </div>
                <div class="card-body">
                    <div id="class-result-container" style="width:100%; height:300px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">
            <h2 class="h5 mb-0">답안지</h2>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover" id="answerTable">
                    <thead class="table-light">
                    <tr>
                        <th>질문</th>
                        <th>정답</th>
                        <th>내가 입력한 정답</th>
                        <th>결과</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Table rows will be dynamically added here -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        const urlParams = new URLSearchParams(window.location.search);
        const scheduleSeq = urlParams.get('schedule_seq');

        $.ajax({
            url: `<%=ctxPath%>/student/exam/resultREST.lms?schedule_seq=\${scheduleSeq}`,
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                populateScoreSummary(data);
                renderScoreChart(data);
                populateAnswerComparison(data);
            },
            error: function(xhr, status, error) {
                console.error('Error fetching exam data:', error);
                alert('Failed to load exam results. Please try again later.');
            }
        });

        var url = '<%= ctxPath %>/professor/exam/resultREST.lms?schedule_seq=' + scheduleSeq;

        $.getJSON(url, function(data) {
            renderNormalDistributionChart(data.studuentScoreList);
        });
    });

    function populateScoreSummary(data) {
        $('#totalScore').text(data.score);
        $('#correctCount').text(data.correctCount);
        $('#wrongCount').text(data.wrongSCount);
    }

    function renderScoreChart(data) {
        const ctx = document.getElementById('scoreChart').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['맞음', '틀림'],
                datasets: [{
                    data: [data.correctCount, data.wrongSCount],
                    backgroundColor: ['#28a745', '#dc3545']
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                    },
                    title: {
                        display: true,
                        text: '정답 비율'
                    }
                }
            }
        });
    }

    function populateAnswerComparison(data) {
        const tableBody = $('#answerTable tbody');
        tableBody.empty();

        data.testAnswers.forEach((answer, index) => {
            const studentAnswer = data.studentAnswers[index];
            const isCorrect = answer === studentAnswer;

            const row = `
                <tr>
                    <td>Q\${index + 1}</td>
                    <td>\${answer}</td>
                    <td>\${studentAnswer}</td>
                    <td>
                        <span class="badge \${isCorrect ? 'bg-success' : 'bg-danger'}">
                            \${isCorrect ? '정답' : '오답'}
                        </span>
                    </td>
                </tr>
            `;
            tableBody.append(row);
        });
    }

    function renderNormalDistributionChart(results) {
        var scores = results.map(function(result) {
            return result.score;
        });

        Highcharts.chart('class-result-container', {
            title: {
                text: '성적 정규분포'
            },
            xAxis: [{
                title: { text: 'Data' },
                alignTicks: false
            }, {
                title: { text: 'Histogram' },
                alignTicks: false,
                opposite: true
            }],
            yAxis: [{
                title: { text: 'Data' }
            }, {
                title: { text: 'Histogram' },
                opposite: true
            }],
            series: [{
                name: 'Histogram',
                type: 'histogram',
                xAxis: 1,
                yAxis: 1,
                baseSeries: 's1',
                zIndex: -1
            }, {
                name: 'Data',
                type: 'scatter',
                data: scores,
                id: 's1',
                marker: {
                    radius: 1.5
                }
            }]
        });
    }
</script>
</body>
</html>