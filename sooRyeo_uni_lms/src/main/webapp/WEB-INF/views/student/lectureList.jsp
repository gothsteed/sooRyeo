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

    <!-- DataPicker -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    
    <!-- Font Awesome 6 Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <script type="text/javascript">

    $(document).ready(function(){
    	
    	
    });
    
    </script>

        <div class="main-content d-flex justify-content-center">
            <div class="btn-group btn-group-toggle" data-toggle="buttons" style="width: 70%">
                <label class="btn btn-secondary active">
                  <input type="radio" name="options" id="option1" autocomplete="off" onclick="showmajor()" checked> 전공과목
                </label>
                <label class="btn btn-secondary">
                  <input type="radio" name="options" id="option2" autocomplete="off" onclick="showminor()"> 비전공과목
                </label>
            </div>
        </div>

        <div class="d-flex justify-content-center" id="majorsubject">
            <div class="card" style="width: 80%;">
              <h5 class="card-header">
                 	전공과목
              </h5>
              <div style="display: flex;">
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>

              </div>
            </div>
        </div>


        <div class="d-flex justify-content-center" id="minorsubject">
            <div class="card" style="width: 80%;">
              <h5 class="card-header">
                	 비전공과목
              </h5>
              <div style="display: flex;">
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text">
                        <table class="table table-dark table-striped">
                            <th>컴퓨터 과학과 사회적 통찰</th>
                            <th></th>
                            <tr>
                                <td>교수명</td>
                                <td>이정연</td>
                            </tr>
                            <tr>
                                <td>학점</td>
                                <td>3학점</td>
                            </tr>
                            <tr>
                                <td>시간</td>
                                <td>월 3 - 6</td>
                            </tr>
                        </table>
                    </p>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>

              </div>
            </div>
        </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
