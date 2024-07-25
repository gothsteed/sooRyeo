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
    String scheduleSeq = (String) request.getAttribute("schedule_seq");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Results and Statistics</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var scheduleSeq = '<%= scheduleSeq %>';
            var url = '<%= ctxPath %>/professor/exam/resultREST.lms?schedule_seq=' + scheduleSeq;

            $.getJSON(url, function(data) {
                populateResults(data.studuentScoreList);
                populateStats([{
                    subject: 'Overall',
                    averageScore: data.averageScore,
                    highestScore: data.highestScore,
                    lowestScore: data.lowestScore
                }]);
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
                        "<td>" + stat.subject + "</td>" +
                        "<td>" + stat.averageScore + "</td>" +
                        "<td>" + stat.highestScore + "</td>" +
                        "<td>" + stat.lowestScore + "</td>" +
                        "</tr>";
                    statsTable.append(row);
                });
            }
        });
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <section class="col-md-6 section test-result" id="results">
            <h2>Test Results</h2>
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
            <h2>Test Statistics</h2>
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                    <tr>
                        <th>Subject</th>
                        <th>Average Score</th>
                        <th>Highest Score</th>
                        <th>Lowest Score</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Data will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>
        </section>
    </div>
</div>
</body>
</html>
