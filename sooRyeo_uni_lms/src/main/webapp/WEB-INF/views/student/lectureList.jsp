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
<title>Lecture List</title>



<script type="text/javascript">

	$(document).ready(function(){
		$("div#major").show();
		$("div#minor").hide();
		
		$("input#option1").click(function(){
			$("div#major").show();
			$("div#minor").hide();
		})
		$("input#option2").click(function(){
			$("div#minor").show();
			$("div#major").hide();
		})
		
	});

</script>
</head>
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
    
        <div class="d-flex justify-content-center">
            <div class="card" style="width: 80%;" id="major">
              <h5 class="card-header">
                 	전공과목
              </h5>
              <div style="display: flex;">
                  <div class="card-body">
                    <p class="card-text" />
                        <table class="table table-dark table-striped">
                            <tr>
	                            <th>컴퓨터 과학과 사회적 통찰</th>
	                            <th></th>
	                        </tr>
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
                    <a href="#" class="btn btn-primary">수강철회하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text" />
                        <table class="table table-dark table-striped">
                            <tr>
	                            <th>컴퓨터 과학과 사회적 통찰</th>
	                            <th></th>
	                        </tr>
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
                    <a href="#" class="btn btn-primary">수강철회하기</a><!-- 일정 기간이 지나면 비활성화 시키는 작업 필요 -->
                  </div>
                  <div class="card-body">
                    <p class="card-text" />
                        <table class="table table-dark table-striped">
                            <tr>
	                            <th>컴퓨터 과학과 사회적 통찰</th>
	                            <th></th>
	                        </tr>
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
                    <a href="#" class="btn btn-primary">수강철회하기</a>
                  </div>

              </div>
            </div>
        </div>

        <div class="d-flex justify-content-center">
            <div class="card" style="width: 80%;" id="minor">
              <h5 class="card-header">
                	 비전공과목
              </h5>
              <div style="display: flex;">
                  <div class="card-body" >
                    <p class="card-text" />
                        <table class="table table-dark table-striped">
                            <tr>
	                            <th>컴퓨터 과학과 사회적 통찰</th>
	                            <th></th>
	                        </tr>
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
                    <a href="#" class="btn btn-primary">수강철회하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text" />
                        <table class="table table-dark table-striped">
                            <tr>
	                            <th>컴퓨터 과학과 사회적 통찰</th>
	                            <th></th>
	                        </tr>
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
                    <a href="#" class="btn btn-primary">수강철회하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text" />
                        <table class="table table-dark table-striped">
                            <tr>
	                            <th>컴퓨터 과학과 사회적 통찰</th>
	                            <th></th>
	                        </tr>
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
                    <a href="#" class="btn btn-primary">수강철회하기</a>
                  </div>
                  <div class="card-body">
                    <p class="card-text" />
                        <table class="table table-dark table-striped">
                            <tr>
	                            <th>컴퓨터 과학과 사회적 통찰</th>
	                            <th></th>
	                        </tr>
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
                    <a href="#" class="btn btn-primary">수강철회하기</a>
                  </div>
              </div>
            </div>
        </div>


</body>
</html>
