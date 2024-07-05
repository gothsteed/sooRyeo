<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /sooRyeo
%>

<link href='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />

<style type="text/css">

div#wrapper1{
	float: left; display: inline-block; width: 20%; margin-top:250px; font-size: 13pt;
}

div#wrapper2{
	display: inline-block; width: 80%; padding-left: 20px;
}

/* ========== full calendar css 시작 ========== */
.fc-header-toolbar {
	height: 30px;
}

a, a:hover, .fc-daygrid {
    color: #000;
    text-decoration: none;
    background-color: transparent;
    cursor: pointer;
} 

.fc-sat { color: #0000FF; }    /* 토요일 */
.fc-sun { color: #FF0000; }    /* 일요일 */
/* ========== full calendar css 끝 ========== */

ul{
	list-style: none;
}

button.btn_normal{
	background-color: #990000;
	border: none;
	color: white;
	width: 50px;
	height: 30px;
	font-size: 12pt;
	padding: 3px 0px;
	border-radius: 10%;
}

button.btn_edit{
	border: none;
	background-color: #fff;
}
</style>


<!-- full calendar에 관련된 script -->
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script type="text/javascript">

// ~~~~~~~ Function Declartion ~~~~~~~
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: function(fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: '<%= ctxPath%>/api/schedules',
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    var events = data.map(function(event) {
                    
                        return {
                            id: event.schedule_seq,
                            title: event.title,
                            start: event.start_date,
                            end: event.end_date
                        };
                    });
                    successCallback(events);
                },
                error: function() {
                    failureCallback();
                }
            });
        }
    });
    calendar.render();
});

</script>



<div style="margin-left: 80px; width: 88%;">
	
	<h3>일정 관리</h3>
	
	<div id="wrapper1">
		<input type="hidden" value="${sessionScope.loginuser.userid}" id="fk_userid"/>
		
		<input type="checkbox" id="allComCal" class="calendar_checkbox" checked/>&nbsp;&nbsp;<label for="allComCal">사내 캘린더</label>
	
	<%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.  	
	     <c:if test="${sessionScope.loginuser.fk_pcode =='3' && sessionScope.loginuser.fk_dcode == '4' }"> --%>
	     <c:if test="${sessionScope.loginuser.gradelevel =='10'}"> 
		 	<button class="btn_edit" style="float: right;" onclick="addComCalendar()"><i class='fas'>&#xf055;</i></button>
		 </c:if> 
	<%-- </c:if>	--%> 
	    
	    <%-- 사내 캘린더를 보여주는 곳 --%>
		<div id="companyCal" style="margin-left: 50px; margin-bottom: 10px;"></div>
		
		
		<input type="checkbox" id="allMyCal" class="calendar_checkbox" checked/>&nbsp;&nbsp;<label for="allMyCal">내 캘린더</label>
		<button class="btn_edit" style="float: right;" ><i class='fas'>&#xf055;</i></button>
		
		<%-- 내 캘린더를 보여주는 곳 --%>
		<div id="myCal" style="margin-left: 50px; margin-bottom: 10px;"></div>

		<input type="checkbox" id="sharedCal" class="calendar_checkbox" value="0" checked/>&nbsp;&nbsp;<label for="sharedCal">공유받은 캘린더</label> 
	</div>
	
	<div id="wrapper2">
		<div id="searchPart" style="float: right;">
			<form name="searchScheduleFrm">
				<div>
					<input type="text" id="fromDate" name="startdate" style="width: 90px;" readonly="readonly">&nbsp;&nbsp; 
	            -&nbsp;&nbsp; <input type="text" id="toDate" name="enddate" style="width: 90px;" readonly="readonly">&nbsp;&nbsp;
					<select id="searchType" name="searchType" style="height: 30px;">
						<option value="">검색대상선택</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="joinuser">공유자</option>
					</select>&nbsp;&nbsp;	
					<input type="text" id="searchWord" value="" style="height: 30px; width:150px;" name="searchWord"/>
					&nbsp;&nbsp;
					<select id="sizePerPage" name="sizePerPage" style="height: 30px;">
						<option value="">보여줄개수</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>&nbsp;&nbsp;
					<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}"/>
					<button type="button" class="btn_normal" style="display: inline-block;" onclick="goSearch()">검색</button>
				</div>
			</form>
		</div>
				
	    <%-- 풀캘린더가 보여지는 엘리먼트  --%>
		<div id="calendar" style="margin: 100px 0 50px 0;" ></div>
	</div>
		
</div> 

<%-- === 사내 캘린더 추가 Modal === --%>
<div class="modal fade" id="modal_addComCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">사내 캘린더 추가</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
       	<form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="add_com_smcatgoname"/></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
     			</tr>
     		</table>
       	</form>	
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goAddComCal()">추가</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 사내 캘린더 수정 Modal === --%>
<div class="modal fade" id="modal_editComCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">사내 캘린더 수정</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
       	<form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="edit_com_smcatgoname"/><input type="hidden" value="" class="edit_com_smcatgono"></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
     			</tr>
     		</table>
       	</form>	
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goEditComCal()">수정</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 내 캘린더 추가 Modal === --%>
<div class="modal fade" id="modal_addMyCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">내 캘린더 추가</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
          <form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="add_my_smcatgoname" /></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td> 
     			</tr>
     		</table>
     		</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addMy" class="btn btn-success btn-sm" onclick="goAddMyCal()">추가</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 내 캘린더 수정 Modal === --%>
<div class="modal fade" id="modal_editMyCal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">내 캘린더 수정</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<form name="modal_frm">
       	<table style="width: 100%;" class="table table-bordered">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="edit_my_smcatgoname"/><input type="hidden" value="" class="edit_my_smcatgono"></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
     			</tr>
     		</table>
       	</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goEditMyCal()">수정</button>
          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 === --%>     
<form name="dateFrm">
	<input type="hidden" name="chooseDate" />	
</form>	

