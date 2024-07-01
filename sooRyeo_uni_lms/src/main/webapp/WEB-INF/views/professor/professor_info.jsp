<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>     

<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>


<style type="text/css">

div#info {
   border: solid 1px red;
   width: 50%;
   margin-left: 45%;
}
span.error {
   color: red;
   font-weight: bold;
   font-size: 9pt;
}

</style>

<script type="text/javascript">


$(document).ready(function() {
   
   $("span.error").hide();
   
   
});

</script>


<div class="container">
  <div class="card mb-3 shadow p-3 mb-5 bg-body-tertiary rounded" style="max-width: 1000px;">
     <div class="myInfo row g-0 ">
         <div class="card-body">
           
         <form class="profile-form">
            <div class="d-flex">
               <img src="<%=ctxPath%>/resources/images/koala.png" class="img-fluid rounded-start" style="width:15%; margin-left:5%;" />
               <div style="width:25%;" class="prodInputName" style="padding-bottom: 10px; margin-left:5%;">이미지파일 미리보기</div>
               <div><img id="previewImg" width="150" /></div>
               <input class="form-control" type="file" id="formFile" style="width:30%; margin-top: 10%;">
            </div>
               
            <div class="card-body">
               <div class="row" style="width:100%; padding-bottom: 5%;">
                  <div class="col-sm-6 m-b30 mb-3">
                     <label class="form-label">성명</label> 
                     <input type="text" id="profName" disabled name="name" class="form-control" value="${requestScope.professor.name}">
                  </div>
                  <div class="col-sm-6 m-b30"> 
                     <label class="form-label">비밀번호</label> 
                     <input type="text" id="profPwd" name="pwd" class="form-control" readonly value="${requestScope.professor.pwd}">
                  </div>
                  <div class="col-sm-6 m-b30 mb-3">
                     <label class="form-label">학과</label> 
                     <input type="text" id="profDepart" disabled name="department_name" class="form-control" value="${requestScope.professor.department.department_name}">
                  </div>
                  <div class="col-sm-6 m-b30">
                     <label class="form-label">연락처</label>
                     <span class="error">올바른 연락처 형식이 아닙니다.</span>
                     <input type="text" id="profTel" name="tel" class="form-control" value="${requestScope.professor.tel}">
                  </div>
                  <div class="col-sm-6 m-b30">
                     <label class="form-label">이메일</label> 
                     <span class="error">이메일 형식에 맞지 않습니다.</span>
                     <input type="text" id="profEmail" name="email" class="form-control" value="${requestScope.professor.email}">
                             <%-- 이메일중복체크 --%>
                             <span id="emailcheck"><button type="button" class="btn btn-outline-success btn-sm mt-3">이메일 중복확인 </button></span>
                             <span id="emailCheckResult"></span>
                  </div>
                  <div class="col-sm-6 m-b30">
                     <label class="form-label">연구실 주소</label> 
                     <span class="error">주소를 입력하세요.</span>
                     <input type="text" id="profAddress" name="office_address" class="form-control" value="${requestScope.professor.office_address}">
                  </div>
               </div>
            </div>
            <div class="card-footer" style="padding-left:800px;">
               <button class="btn btn-success" id="updateBtn" onclick="">수정하기</button>
            </div>
         </form>
      
         </div>
        </div>
   </div>
</div>


