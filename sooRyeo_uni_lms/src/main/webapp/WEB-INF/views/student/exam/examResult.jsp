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
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4 text-center" style="font-weight: bold">시험 결과</h1>

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

                    <div class="table-responsive" id="stats">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-light">
                            <tr>
                                <th>평균 점수</th>
                                <th>최고 점수</th>
                                <th>최저 점수</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Data will be populated by JavaScript -->
                            </tbody>
                        </table>
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
                console.error('Error fetching exam data:', error.text);
                alert(xhr.responseText);
            }
        });

        var url = '<%= ctxPath %>/professor/exam/resultREST.lms?schedule_seq=' + scheduleSeq;

        $.getJSON(url, function(data) {
            renderScoreDistributionChart(data.studuentScoreList);
            populateStats([{
                averageScore: data.averageScore,
                highestScore: data.highestScore,
                lowestScore: data.lowestScore
            }]);
        });
    });

    function populateStats(stats) {
        var statsTable = $("#stats tbody");
        statsTable.empty();
        $.each(stats, function(index, stat) {
            var row = "<tr>" +
                "<td>" + stat.averageScore + "</td>" +
                "<td>" + stat.highestScore + "</td>" +
                "<td>" + stat.lowestScore + "</td>" +
                "</tr>";
            statsTable.append(row);
        });
    }

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
            const isCorrect = (answer ===  parseInt(studentAnswer));

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


    function renderScoreDistributionChart(results) {
        var scores = results.map(function(result) {
            return result.score;
        });

        // Calculate the frequency of each score
        var scoreFrequency = {};
        scores.forEach(function(score) {
            scoreFrequency[score] = (scoreFrequency[score] || 0) + 1;
        });

        // Convert the frequency object to an array of [score, frequency] pairs
        var seriesData = Object.entries(scoreFrequency).map(function([score, frequency]) {
            return [parseFloat(score), frequency];
        });

        // Sort the data by score
        seriesData.sort(function(a, b) {
            return a[0] - b[0];
        });

        Highcharts.chart('class-result-container', {
            chart: {
                type: 'column'
            },
            title: {
                text: '성적 분포'
            },
            xAxis: {
                title: {
                    text: '점수 '
                },
                categories: seriesData.map(function(item) {
                    return item[0];
                })
            },
            yAxis: {
                title: {
                    text: '학생 수'
                }
            },
            series: [{
                name: 'Students',
                data: seriesData.map(function(item) {
                    return item[1];
                })
            }],
            tooltip: {
                formatter: function() {
                    return 'Score: ' + this.x + '<br>Students: ' + this.y;
                }
            },
            plotOptions: {
                column: {
                    zones: [{
                        value: 5,
                        color: '#FF9800'
                    }, {
                        value: 10,
                        color: '#4CAF50'
                    }, {
                        color: '#2196F3'
                    }]
                }
            }
        });

    }
</script>
</body>
</html>