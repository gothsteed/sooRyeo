<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Styled Sidebar</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Highcharts -->
    <script src="<%= ctxPath%>/Highcharts-10.3.1/code/highcharts.js"></script>
    <script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/exporting.js"></script>
    <script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/export-data.js"></script>
    <script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/accessibility.js"></script>
</head>
<body>

    <div class="content">
        <div class="main-content">
            <div class="justify-content-center">
                <div class="card">
                  <h5 class="card-header">
                    	방문 통계 차트
                  </h5>
                  <div class="card-body">
                    <h5 class="card-title">교수 학생 방문통계</h5>
                    <p class="card-text" id="columStackedBar">highcharts</p>
                  </div>
                </div>
                
                <br>
                
                <div class="card">
                  <h5 class="card-header">
                    	강의개설 신청승인
                  </h5>
                  <div class="card-body">
                    <h5 class="card-title">개설신청 리스트</h5>
                    <p class="card-text">
                        <table class="table">
                            <thead class="thead-dark">
                              <tr>
                                <th scope="col">#</th>
                                <th scope="col">학기</th>
                                <th scope="col">교수명</th>
                                <th scope="col">학과</th>
                                <th scope="col">정원</th>
                                <th scope="col">강의소개</th>
                                <th scope="col">계획서</th>
                                <th scope="col">개설일자</th>
                                <th scope="col">관리자 승인</th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <th scope="row">1</th>
                                <td>1학기</td>
                                <td>이정연</td>
                                <td>국제통상학과</td>
                                <td>30명</td>
                                <td>이부분은 modal같은거 해야할 듯</td>
                                <td>계획서 파일이 첨부</td>
                                <td>2024-08-09</td>
                                <td><a href="#" class="btn btn-primary">승인</a>&nbsp;<a href="#" class="btn btn-primary">반려</a></td>
                                
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td>2학기</td>
                                <td>이경현</td>
                                <td>국어국문과</td>
                                <td>20명</td>
                                <td>강의력이 좋습니다.</td>
                                <td>계획서 파일이 첨부</td>
                                <td>2024-08-09</td>
                                <td><a href="#" class="btn btn-primary">승인</a>&nbsp;<a href="#" class="btn btn-primary">반려</a></td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td>1학기</td>
                                <td>강민정</td>
                                <td>컴퓨터공학과</td>
                                <td>30명</td>
                                <td>잘가르칩니다.</td>
                                <td>계획서 파일이 첨부</td>
                                <td>2024-08-09</td>
                                <td><a href="#" class="btn btn-primary">승인</a>&nbsp;<a href="#" class="btn btn-primary">반려</a></td>
                              </tr>
                            <tr>
                                <th scope="row">4</th>
                                <td>2학기</td>
                                <td>손혜정</td>
                                <td>의예과</td>
                                <td>30명</td>
                                <td>치료를 잘합니다.</td>
                                <td>계획서 파일이 첨부</td>
                                <td>2024-08-09</td>
                                <td><a href="#" class="btn btn-primary">승인</a>&nbsp;<a href="#" class="btn btn-primary">반려</a></td>
                              </tr>
                            <tr>
                                <th scope="row">5</th>
                                <td>1학기</td>
                                <td>손영관</td>
                                <td>연극영화과</td>
                                <td>30명</td>
                                <td>연기를 잘가르칩니다.</td>
                                <td>계획서 파일이 첨부</td>
                                <td>2024-08-09</td>
                                <td><a href="#" class="btn btn-primary">승인</a>&nbsp;<a href="#" class="btn btn-primary">반려</a></td>
                              </tr>
                            </tbody>
                        </table>
                    </p>
                  </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS and dependencies -->

</body>
</html>
