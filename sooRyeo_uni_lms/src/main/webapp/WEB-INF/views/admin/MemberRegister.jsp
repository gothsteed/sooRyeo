<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
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

    <!-- jQuery UI CSS 및 JS -->
    <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
	<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>

	<%-- DataPicker --%>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    
    <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
    
    
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
    
	<script type="text/javascript" src="<%= ctxPath%>/resources/js/admin/memberRegister.js"></script>

    <script type="text/javascript">

    $(document).ready(function(){ 

        // === jQuery UI 의 datepicker === //
        $('input#datepicker').datepicker({
            
            dateFormat: 'yy-mm-dd'  //Input Display Format 변경
            ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true        //콤보박스에서 년 선택 가능
            ,changeMonth: true       //콤보박스에서 월 선택 가능                
          // ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
          // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
          // ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
          // ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        //  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        //  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
        });

        // 초기값을 오늘 날짜로 설정
        // $('input#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
        // $('input#datepicker').datepicker('setDate', '-1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // === 전체 datepicker 옵션 일괄 설정하기 ===  
        //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
        $(function() {
            
            //모든 datepicker에 대한 공통 옵션 설정
            $.datepicker.setDefaults({
                 dateFormat: 'yy-mm-dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능   
                ,maxDate: new Date()             
            //  ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
            //  ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            //  ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            //  ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
            //  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            //  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
            });
            
            // input을 datepicker로 선언
            $("input#fromDate").datepicker();                    
            $("input#toDate").datepicker();
            
         });

       ///////////////////////////////////////////////////////////////////////

    });
    </script>
    </head>
<body>
        <div class="main-content">
            <div class="d-flex justify-content-center">
                <div class="card" style="width: 45%;">
                  <h5 class="card-header">
                  	학생 등록
                  </h5>
                  <div class="card-body">
                    <h5 class="card-title">학생 정보</h5>
                    <p class="card-text" />
                        <form action="#" name="registerFrm" method="post" enctype="multipart/form-data">
                            <!-- text, form-control -->
                        
                            <div class="form-group row">
                                <label for="a2" class="col-sm-3 text-sm-left">이름</label>
                                <div class="col-sm-8">
                                    <input type="text" id="a2" class="form-control">
                                </div>
                            </div>
                            <hr>
                            
                            <div class="form-group row">
                                <label for="a2" class="col-sm-3 text-sm-left">아이디</label>
                                <div class="col-sm-8">
                                    <input type="text" id="a2" class="form-control">
                                </div>
                            </div>
                            <hr>

                            <div class="form-group row">
                                <label for="a2" class="col-sm-3 text-sm-left">이메일</label>
                                <div class="col-sm-8">
                                    <input type="text" id="a2" class="form-control">
                                </div>
                            </div>
                            <hr>
                            
                            <!-- password, form-control -->
                            <div class="form-group row">
                                <label for="a2" class="col-sm-3 text-sm-left">비밀번호</label>
                                <div class="col-sm-8">
                                    <input type="password" id="a2" class="form-control">
                                </div>
                            </div>
                            <hr>
                            <div class="form-group row">
                                <label for="email" class="col-sm-3 text-sm-left">이메일</label>
                                <div class="col-sm-8 d-flex justify-content-between align-items-center">
								    <input type="text" name="email" id="email" class="form-control requiredInfo" style="width:70%;">
								    <div>
								        <button type="button" class="btn btn-light" onclick="emailcheck('<%=ctxPath%>')">중복확인</button>
								    </div>
								</div>
                                <div class="col-sm-3">
								</div>
                                <div class="col-sm-8 justify-content-between align-items-center">
							        <span class="error" style="margin-right: 5px;">이메일 형식과 일치하지 않습니다.</span>
							        <span id="emailCheckResult"></span>
								</div>
                            </div>
                            <hr>
                            
                            <div class="form-group row">
                                <label for="a2" class="col-sm-3 text-sm-left">학과</label>
                                <div class="col-sm-8">
                                    <select class="selectpicker">
                                        <option>컴퓨터공학과</option>
                                        <option>국제통상학과</option>
                                        <option>국어국문과</option>
                                        <option>작곡과</option>
                                        <option>의예과</option>
                                        <option>치의예과</option>
                                    </select>
                                </div>
                            </div>
                            <hr>
                            
							<div class="form-group row">
							    <label for="major" class="col-sm-3 text-sm-left">학과</label>
							    <div class="col-sm-8">
							        <select class="selectpicker" id="major" name="fk_department_seq">
							            <c:forEach var="major" items="${requestScope.departmentList}" varStatus="status">    
							                <option value="${major.department_seq}" name="fk_department_seq">${major.department_name}</option>
							            </c:forEach>
							        </select>
							    </div>
							</div>
                            <hr>

                            <div class="form-group row">
                                <label for="detailAddress" class="col-sm-3 text-sm-left">주소</label>
                                <div class="col-sm-8">
                                    <input type="text" id="a2" class="form-control">
                                </div>
                            </div>
                            <hr>
                            
                            <div class="form-group row requiredInfo">
                                <label for="register_year" class="col-sm-3 text-sm-left">입학년도</label>
                                <div class="col-sm-8">
                                    <%-- 입학년도 --%>
			                       	<input type="text" name="register_year" id="register_year" maxlength="4" />
                                </div>
                            </div>
                            <hr>
                            
                            <div class="form-group row">
							    <label for="grade" class="col-sm-3 text-sm-left requiredInfo">학년</label>
							    <div class="col-sm-8">
							    <select id="grade" name="grade">
								    <option name="grade1" value="1">1</option>
								    <option name="grade2" value="2">2</option>
								    <option name="grade3" value="3">3</option>
								    <option name="grade4" value="4">4</option>
								</select>
							    </div>
							</div>
                            
                            <div class="form-group row product">
							    <label for="grade" class="col-sm-3 text-sm-left requiredInfo">증명사진</label>
							    <div class="col-sm-8">
							    	<input type="file" name="attach" class="img_file" />
							    	<img id="previewImg" width="300"/>
							    </div>
							</div>
							
							
                        </form>
                    <a href="#" class="btn btn-primary">개설신청하기</a>
                  </div>
                </div>
            </div>

        </div>
</body>
</html>

