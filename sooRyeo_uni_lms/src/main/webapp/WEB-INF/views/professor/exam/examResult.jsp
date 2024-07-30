<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-07-24
  Time: 오후 4:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%
    String ctxPath = request.getContextPath();
    int scheduleSeq =  (int) request.getAttribute("schedule_seq");


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Results and Statistics</title>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/histogram-bellcurve.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/highcharts-more.js"></script>
    <script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/solid-gauge.js"></script>
    <script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
    <script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>
    <script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/series-label.js"></script>

    <script>
        $(document).ready(function() {
            var scheduleSeq = '<%= scheduleSeq %>';
            var url = '<%= ctxPath %>/professor/exam/resultREST.lms?schedule_seq=' + scheduleSeq;

            $.getJSON(url, function(data) {
                populateResults(data.studuentScoreList);
                populateStats([{
                    averageScore: data.averageScore,
                    highestScore: data.highestScore,
                    lowestScore: data.lowestScore
                }]);
                renderScoreDistributionChart(data.studuentScoreList);

            });

            function populateResults(results) {
                var resultsTable = $("#results tbody");
                resultsTable.empty();
                $.each(results, function(index, result) {
                    var row = "<tr>" +
                        "<td>" + result.studentId + "</td>" +
                        "<td>" + result.studentName + "</td>" +
                        "<td>" + result.correctCount + "</td>" +
                        "<td>" + result.wrongSCount + "</td>" +
                        "<td>" + result.score + "</td>" +
                        "</tr>";
                    resultsTable.append(row);
                });
            }

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
        });


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

            Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Score Distribution'
                },
                xAxis: {
                    title: {
                        text: 'Score'
                    },
                    categories: seriesData.map(function(item) {
                        return item[0];
                    })
                },
                yAxis: {
                    title: {
                        text: 'Number of Students'
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
</head>
<body>
<div class="container">
    <div class="row">
        <section class="col-md-6 section test-result" id="results">
            <h2>시험 결과</h2>
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                    <tr>
                        <th>학번</th>
                        <th>이름</th>
                        <th>맞은개수</th>
                        <th>틀린개수</th>
                        <th>점수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Data will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>
        </section>

        <section class="col-md-6 section test-stats" id="stats">
            <h2>기본 통계</h2>
            <div class="table-responsive">
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
        </section>
    </div>

    <div id="container" style="width:100%; height:400px;"></div>
</div>
</body>
</html>
