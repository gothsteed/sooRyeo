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
    <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
    
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
    
	<script type="text/javascript" src="<%= ctxPath%>/resources/js/admin/memberRegister.js"></script>

    <script type="text/javascript">

    $(document).ready(function(){ 

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
                        <form action="#" name="registerFrm" method="post">
                            <!-- text, form-control -->
                        
                            <div class="form-group row">
                                <label for="name" class="col-sm-3 text-sm-left">이름</label>
                                <div class="col-sm-8">
                                    <input type="text" name="name" id="name" class="form-control requiredInfo">
                                    <span class="error">이름을 입력하세요.</span>
                                </div>
                            </div>
                            <hr>
                            
                            <!-- password, form-control -->
                            <div class="form-group row">
                                <label for="pwd" class="col-sm-3 text-sm-left">비밀번호</label>
                                <div class="col-sm-8">
                                    <input type="password" name="pwd" id="pwd" class="form-control mb-1">
                                    <span class="error">영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
                                    <input type="password" id="pwdcheck" class="form-control requiredInfo">
                                    <span class="error">암호가 일치하지 않습니다.</span>
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
							    <label for="jubun" class="col-sm-3 text-sm-left">주민번호</label>
							    <div class="col-sm-8">
							        <input type="text" name="jubun" id="jubun" class="form-control requiredInfo">
							        <span class="error" style="margin-right: 5px;">주민번호 형식에 맞지 않습니다.</span>
							    </div>
							</div>
							<hr>
                            <div class="form-group row">
                                <label for="hp2" class="col-sm-3 text-sm-left">전화번호</label>
                                <div class="col-sm-8 d-flex">
                                    <input type="text" name="a2" id="a2" class="form-control" style="width:26%" value="010" readonly> &nbsp;&nbsp;-&nbsp;&nbsp; 
                                    <input type="text" name="hp2" id="hp2" class="form-control requiredInfo" style="width:26%">&nbsp;&nbsp;-&nbsp;&nbsp; 
                                    <input type="text" name="hp3" id="hp3" class="form-control requiredInfo" style="width:26%">
                                </div>
                                <div class="col-sm-3"></div>
                                <div class="col-sm-8 d-flex">
							        <span class="error" style="margin-right: 5px;">숫자 4자리만 기입 가능합니다.</span>
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
			                        <%-- 우편번호 찾기 --%>
			                        <input class="form-control requiredInfo" type="text" name="postcode" id="postcode" size="6" maxlength="5" />
			                        <img src="<%= ctxPath%>/resources/images/b_zipcode.gif" id="zipcodeSearch" />
			                        <span class="error">우편번호 형식에 맞지 않습니다.</span>
			                        <br>
			                        <input class="form-control  mb-1  mt-1 requiredInfo" type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" />
			                        <input class="form-control  mb-1 requiredInfo" type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" />
			                        <input class="form-control" type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />            
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
                        </form>
                    <button type="button" class="btn btn-primary" onclick="goRegister('<%=ctxPath%>')">등록하기</button>
                  </div>
                </div>
            </div>
        </div>
</body>
</html>

