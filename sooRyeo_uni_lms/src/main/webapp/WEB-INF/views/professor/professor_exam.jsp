<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
   String ctxPath = request.getContextPath(); 
   //    /board
%>    


<div class="content-body">

	<div class="container-fluid" style="padding-top: 10px;">
		<div class="card" id="card-title-1">
			<div class="card-header border-0 pb-0 ">
				<h1 class="card-title" style="color:#6e6e6e;  font-weight: 900; font-size: 23px;">시험</h1>
			</div>
			<hr>
			<div class="card-body" style="padding-top: 0px; color: black; font-size: 18px;	padding: 0.75rem; ">
				<form method="post" action="/hku/test-insert?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
					<div class="noti-wrap">
						<span style="padding-bottom: 8px;">[출제자 유의사항]</span>
						<span>▶ 시험지 업로드는 PDF파일만 가능합니다.</span>
						<span>▶ 문제 추가 시 꼭 답안을 작성한 후 출제하시기 바랍니다.</span>
					</div>
					<hr>
					<div>
						<div style="margin-bottom: 6px;"> 
							<span style="margin-left: 69px;">> 시험구분</span>
							<span style="margin-left: 92px;">> 시험일자</span>
							<span style="margin-left: 120px;">> 제한시간</span>
							<span style="margin-left: 291px;">> 시험지 등록</span>
						</div>
						<div class="con-wrap">
							<input type="hidden" name="lecapNo">
						
							<c:otherwise>
								<select class="form-control" id="pTest" name="testSe">
									<option value="">----선택----</option>
									<option value="middle">중간고사</option>
									<option value="final">기말고사</option>
								</select>
							</c:otherwise>
							
							<input type="text" class="datepicker  form-control" id="test-date" name="testBgngYmd" value="${test.testBgngYmd }" readonly placeholder="날짜 선택">
							<input type="hidden" id="timeLimt" name="testTimeLimit">
							<select class="form-control" id="hours">	
								<option value="">--시--</option>
								<option value="0" <c:if test="${test.hours eq 0 }">selected</c:if>>00 시간</option>
								<option value="3600" <c:if test="${test.hours eq 1 }">selected</c:if>>01 시간</option>
								<option value="7200" <c:if test="${test.hours eq 2 }">selected</c:if>>02 시간</option>
								<option value="10800" <c:if test="${test.hours eq 3 }">selected</c:if>>03 시간</option>
								<option value="14400" <c:if test="${test.hours eq 4 }">selected</c:if>>04 시간</option>
							</select>:
							<select class="form-control" id="minute">
								<option value="">--분--</option>
								<option value="0" <c:if test="${test.minutes eq 0 }">selected</c:if>>00 분</option>
								<option value="600" <c:if test="${test.minutes eq 10 }">selected</c:if>>10 분</option>
								<option value="1200" <c:if test="${test.minutes eq 20 }">selected</c:if>>20 분</option>
								<option value="1800" <c:if test="${test.minutes eq 30 }">selected</c:if>>30 분</option>
								<option value="2400" <c:if test="${test.minutes eq 40 }">selected</c:if>>40 분</option>
								<option value="3000" <c:if test="${test.minutes eq 50 }">selected</c:if>>50 분</option>
							</select>:
							<select class="form-control" id="second">
								<option value="">--초--</option>
								<option value="0" <c:if test="${test.seconds eq 0 }">selected</c:if>>00 초</option>
								<option value="10" <c:if test="${test.seconds eq 10 }">selected</c:if>>10 초</option>
								<option value="20" <c:if test="${test.seconds eq 20 }">selected</c:if>>20 초</option>
								<option value="30" <c:if test="${test.seconds eq 30 }">selected</c:if>>30 초</option>
								<option value="40" <c:if test="${test.seconds eq 40 }">selected</c:if>>40 초</option>
								<option value="50" <c:if test="${test.seconds eq 50 }">selected</c:if>>50 초</option>
							</select>
							
							<input type="file" class="form-control" id="test-file" name="pdfFile">
							
							<button type="button" class="btn btn-danger" id="regBtn" style=" margin-bottom: 12px; 
							margin-left: 29px; padding: 8px 15px; background: #0070c0; border-color: #0070c0;">
							${status }
							</button>
							<a href="/hku/professor/classroomMain/${sessionScope.lecapNo }" class="btn btn-danger" id="regBtn" style=" margin-bottom: 12px; 
							margin-left: 16px; padding: 8px 15px; background: #ff4343; border-color: #ff4343;">
							뒤로가기
							</a>
							
						</div>
					</div>
					<hr>
					<div class="answer-wrap">
						<div id="myPdf" style="width:800px;height:900px;">
							<div class="preview">시험지 미리보기 <br>(파일을 먼저 등록해주세요.)</div>
						</div>
						<div class="hidden"></div>
						<div style="padding-left: 20px; width: 50%;"> 
							<button type="button" class="btn btn-primary" id="addBtn" style="margin-bottom: 12px; margin-top: 12px; padding: 8px 15px;">답안추가</button>
							<button type="button" class="btn btn-danger light" id="delBtn" style="margin-bottom: 12px; margin-top: 12px; padding: 8px 15px; margin-left: 30px;">답안삭제</button>
							<select class="form-control totalAw" style="width: 9%; position: absolute; top: 12px; right: 375px; height: 38px;">
								<option value="">--선지선택(일괄)--</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
							</select>
							<div id="answer-container">
								<c:choose>
									<c:when test="${msg == 'exist' || msg == 'failed' || msg == 'notFile' || type == 'update'}">
										<c:forEach items="${test.answerList }" var="answer" varStatus="status">
											<div style="display: flex; align-items: center; margin-top: 20px;" class="aw-wrap">
												<input type="hidden" class="form-control aw">
												<span style="width: 73px; text-align:center;">${status.index+1}번 답 :</span> <input type="text" class="form-control aw" >
												<span style="width: 73px; text-align:center;">배점 :</span> <input type="text" class="form-control aw ts-scr"  placeholder="숫자만 입력">
												<span style="width: 73px; text-align:center;">선지수 :</span> 	
												<select class="form-control aw awSel" >
													<option value="">--선지 선택--</option>
													<option value="2" <c:if test="${answer.answerCh eq 2}">selected</c:if>>2</option>
													<option value="3" <c:if test="${answer.answerCh eq 3}">selected</c:if>>3</option>
													<option value="4" <c:if test="${answer.answerCh eq 4}">selected</c:if>>4</option>
													<option value="5" <c:if test="${answer.answerCh eq 5}">selected</c:if>>5</option>
												</select>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<div style="display: flex; align-items: center; margin-top: 20px;" class="aw-wrap">
											<input type="hidden" class="form-control aw"  value="1">
											<span style="width: 73px; text-align:center;">1번 답 :</span> <input type="text" class="form-control aw" name="answerList[0].taAns">
											<span style="width: 73px; text-align:center;">배점 :</span> <input type="text" class="form-control aw ts-scr" name="answerList[0].taScr" placeholder="숫자만 입력">
											<span style="width: 73px; text-align:center;">선지수 :</span>
											<select class="form-control aw awSel" >
												<option value="">--선지 선택--</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
											</select>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

