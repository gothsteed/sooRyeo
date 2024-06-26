<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	#top_container {
		border: solid 0px gray;
	
		
	}
	
	#bottom_container {
		border: solid 0px gray;

	}
	
	#total_container {
		border: solid 0px black;


	}
	
	#right_top_card {
		width: 90%;
	}
	
	#left_top_card {
		width: 90%;
	}
	
	th{
		text-align: center;
	
	}
	
	#time_table th, #time_table td {
	    border: 1px solid black;
	    border-collapse: collapse;
	    text-align: center;
	    width : 100px;
        padding: 5px;
        height: 20px;
	    text-align: center;
	}
	
	.ml-n1 {
  		margin-left: -2.5rem !important;
	}
		

</style>

<div class="justify-content-center" id="total_container">
    <div class="row justify-content-center" id="top_container">
        <div class="card col-md-6" id="left_top_card">
            <div class="card-header row">
                <div class="col-md-2">교과목 조회</div>
                <div class="col-md-4 ml-auto">
                    <select class="form-select" aria-label="Default select example">
                        <option selected>단과선택</option>
                        <option value="1">인문대학</option>
                        <option value="2">공학대학</option>
                        <option value="3">스마트융합대학</option>
                    </select>
                </div>
                <div class="col-md-4 ml-auto">
                    <select class="form-select" aria-label="Default select example">
                        <option selected>학과선택</option>
                        <option value="1">국어국문학과</option>
                        <option value="2">영어영문학과</option>
                        <option value="3">중국어중문학과</option>
                    </select>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-hover">
                    <tr>
                        <th>과목코드</th>
                        <th>학과</th>
                        <th>학년</th>
                        <th>과목명</th>
                        <th>구분</th>
                        <th>학점</th>
                        <th>시수</th>
                    </tr>
                    <tr>
                        <td>SUB001</td>
                        <td>컴퓨터공학과</td>
                        <td>1</td>
                        <td>컴퓨터개론</td>
                        <td>전필</td>
                        <td>3</td>
                        <td>3</td>
                    </tr>    
                </table>
            </div>
        </div>
        <div class="card col-md-5 ml-2" id="right_top_card">
            <div class="card-header row">
                <div class="col-md-3">강의시간표</div>
                <div class="col-md-4 ml-auto">
                    <select class="form-select" aria-label="Default select example">
                        <option selected>과목선택</option>
                        <option value="1">전공과목</option>
                        <option value="2">교양과목</option>
                    </select>
                </div>
                <div class="col-md-4 ml-auto">
                    <select class="form-select" aria-label="Default select example">
                        <option selected>이수단위선택</option>
                        <option value="1">2학점</option>
                        <option value="2">3학점</option>
                    </select>
                </div>
            </div>
            <div class="card-body">
                <table class="table" id="time_table" style="width:100%">
			 	<caption>수려대학교 시간표</caption>
			  	<tr>
			    	<th> </th>
				    <th>월</th>
				    <th>화</th>
				    <th>수</th>
				    <th>목</th>
				    <th>금</th>
			  	</tr>
		    	<tr>
				    <th>1교시</th>
				    <td style = "background : Plum  ;">문화와 역사2</td>
				    <td> </td>
				    <td style = "background : LavenderBlush ;"rowspan="2">정보통신융합공학개론</td>
				    <td style = "background : Pink ;" rowspan="2">화일구조</td>
				    <td style = "background : LightGoldenRodYellow;" rowspan="2">참삶의길</td>
			   	</tr>
				    <tr>
				    <th>2교시</th>
				    <td> </td>
				    <td> </td>
			  	</tr>
				    <tr>
				    <th>3교시</th>
				    <td> </td>
				    <td> </td>
				    <td style = "background : LightCyan  ;" rowspan="2">프로그래밍언어구조론</td>
				    <td style = "background : Lavender;" rowspan="2">웹/xml프로그래밍</td>
				    <td> </td>
			  	</tr>
			   	<tr>
				    <th>4교시</th>
				    <td> </td>
				    <td> </td>
				    <td> </td>
			  	</tr>
			   	<tr>
				    <th>5교시</th>
				    <td style = "background : Lavender  ;" rowspan="2">웹/xml프로그래밍</td>
				    <td style = "background : Salmon  ;" rowspan="4">c++ </td>
				    <td style = "background : MintCream  ;" rowspan="4">임베디드프로그래밍실습</td>
				    <td style = "background : Wheat   ;" rowspan="4">리눅스컴퓨팅실무</td>
				    <td> </td>
			  	</tr>
			   	<tr>
				    <th>6교시</th>
				    <td> </td>
			  	</tr>
			   	<tr>
				    <th>7교시</th>
				    <td> </td>
				    <td> </td>
			  	</tr>
			  	<tr>
				   <th>8교시</th>
				   <td style = "background : LightCyan  ;">프로그래밍언어구조론</td>
				   <td></td>
			  	</tr>
				</table>
            </div>
        </div>
    </div>    
    
    <br>
    
    <div class="row justify-content-center" id="bottom_container">
        <div class="card col-md-11 ">
  			<div class="card-header d-flex justify-content-between align-items-center">
                <h4 class="align-middle">개설신청</h4>
                <div>
                    <button type="button" class="btn btn-primary">나의신청현황</button>
                    <button type="button" class="btn btn-success">강의계획서</button>
                    <button type="button" class="btn btn-danger">신청</button>
                </div>
            </div>
				<div class="card-body">
				    <div class="row mb-2">
				        <div class="col-md-1">교수명</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				        <div class="col-md-1">소속학과</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
     				    <div class="col-md-1">교번</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				        <div class="col-md-1">연락처</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				    </div>
				    <div class="row mb-2">
				        <div class="col-md-1">교과목명</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				        <div class="col-md-1">과목코드</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
     				    <div class="col-md-1">대상학년</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				        <div class="col-md-1">수업구분</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				    </div>
				    <div class="row mb-2">
				        <div class="col-md-1">시수</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				        <div class="col-md-1">학점</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
     				    <div class="col-md-1">개설연도</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				        <div class="col-md-1">개설학기</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				    </div>
				    <div class="row mb-2">
				        <div class="col-md-1">시작교시</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				        <div class="col-md-1">강의요일</div>
				        <div class="col-md-2 ml-n1 mr-4"><input class="form-control" /></div>
				    </div>
				</div>
        </div>
    </div> 
</div>