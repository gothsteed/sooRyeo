<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String ctxPath = request.getContextPath();
%>     

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- DataPicker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script>


<style type="text/css">


</style>


<script type="text/javascript">



</script>


 <div class="main-content w-100 h-100" style="border: solid 1px red;">

      <!-- 캘린더, 일정 -->
      <div class="schedule" style="display: flex;">

          <div class="w-25" style="height: 20rem;">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title" style="text-align: center;">캘린더</h5>
                <div style="height: 355px; text-align: center;">
                  <br><br>
                 		 캘린더 넣을 예정입니다.
                </div>
              </div>
            </div>
          </div>

          <!-- 학시 일정 타임라인 -->
          <div class="w-75">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title" style="text-align: center">2024년도 08월 학사 일정</h5>
                <hr>

                <div class="row">
                  <div class="col-lg-7 mx-auto">
                      
                      <!-- Timeline -->
                      <ul class="timeline">
                          <li class="timeline-item-1 rounded ml-3 mb-3 p-4 shadow" style="background-color: #D6F1EA; ">
                              <div class="timeline-arrow-1"></div>
                              <h5 class="mb-0" style="text-align: center; color: gray;">수강신청 3학년</h5>
                              <h5 class="mb-0" style="text-align: center;">2024-08-14 ~ 2024-08-19</h5>
                          </li>
                          <li class="timeline-item-2 rounded ml-3 mb-3 p-4 shadow" style="background-color: #C9E9F8; ">
                              <div class="timeline-arrow-2"></div>
                              <h5 class="mb-0" style="text-align: center; color: gray;">수강신청 2학년</h5>
                              <h5 class="mb-0" style="text-align: center;">2024-08-21 ~ 2024-08-26</h5>
                          </li>
                          <li class="timeline-item-3 rounded ml-3 mb-3 p-4 shadow" style="background-color: #FCDFD4; ">
                              <div class="timeline-arrow-3"></div>
                              <h5 class="mb-0" style="text-align: center; color: gray;">수강신청 1학년</h5>
                              <h5 class="mb-0" style="text-align: center;">2024-08-21 ~ 2024-08-26</h5>
                          </li>
                      </ul><!-- End -->
      
                  </div>
                </div>
               
              </div>
            </div>
          </div><!-- 학시 일정 타임라인 끝-->
      </div><!-- 캘린더, 일정 끝-->

      <!-- Nav tabs -->
      <ul class="nav nav-tabs" id="myTab" role="tablist">
          <li class="nav-item" role="presentation">
              <a class="nav-link active" data-toggle="tab" data-target="#school_info" style="font-weight: bold; font-size: 14pt; color: #175F30;">학사공지</a>
          </li>
          <li class="nav-item" role="presentation">
              <a class="nav-link" data-toggle="tab" data-target="#Recruit_info" style="font-weight: bold; font-size: 14pt; color: #175F30;">채용공지</a>
          </li>
          <li class="nav-item" role="presentation">
              <a class="nav-link" data-toggle="tab" data-target="#department_info" style="font-weight: bold; font-size: 14pt; color: #175F30;">학과공지</a>
          </li>
      </ul>
      <div class="tab-content" id="myTabContent">
          <div class="tab-pane fade show active" id="school_info" role="tabpanel" aria-labelledby="home-tab">
              <table style="width: 100%;">
                  <tr style="border : solid 1px #175F30; background-color: #175F30;">
                      <th style="color: #FFFFFF; width: 70%; text-align: center; font-size: 18pt;">제목</th>
                      <th style="color: #FFFFFF; width: 30%; text-align: center; font-size: 18pt;">등록일자</th>
                  </tr>
                  <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px; margin-top: 10%;">
                      <td style="width: 70%; text-align: left; font-size: 15pt; ">
                          2024학년도 2학기 등록금 납부안내 
                      </td>
                      <td style="width: 70%; text-align: center; font-size: 15pt;">
                          24.06.23 
                      </td>
                  </tr>
                  <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                      <td style="width: 70%; text-align: left; font-size: 15pt; ">
                         [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                      </td>
                      <td style="width: 70%; text-align: center; font-size: 15pt;">
                          24.06.28 
                      </td>
                  </tr>
                  <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                      <td style="width: 70%; text-align: left; font-size: 15pt; ">
                         [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                      </td>
                      <td style="width: 70%; text-align: center; font-size: 15pt;">
                          24.06.28 
                      </td>
                  </tr>
                  <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                      <td style="width: 70%; text-align: left; font-size: 15pt; ">
                         [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                      </td>
                      <td style="width: 70%; text-align: center; font-size: 15pt;">
                          24.06.28 
                      </td>
                  </tr>
                  <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                      <td style="width: 70%; text-align: left; font-size: 15pt; ">
                         [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                      </td>
                      <td style="width: 70%; text-align: center; font-size: 15pt;">
                          24.06.28 
                      </td>
                  </tr>
              </table>
          </div>
          <div class="tab-pane fade" id="Recruit_info" role="tabpanel" aria-labelledby="profile-tab">
              <div class="tab-pane fade show active" id="school_info" role="tabpanel" aria-labelledby="home-tab">
                  <table style="width: 100%;">
                      <tr style="border : solid 1px #175F30; background-color: #175F30;">
                          <th style="color: #FFFFFF; width: 70%; text-align: center; font-size: 18pt;">제목</th>
                          <th style="color: #FFFFFF; width: 30%; text-align: center; font-size: 18pt;">등록일자</th>
                      </tr>
                      <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px; margin-top: 10%;">
                          <td style="width: 70%; text-align: left; font-size: 15pt; ">
                              2024학년도 2학기 등록금 납부안내 
                          </td>
                          <td style="width: 70%; text-align: center; font-size: 15pt;">
                              24.06.23 
                          </td>
                      </tr>
                      <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                          <td style="width: 70%; text-align: left; font-size: 15pt; ">
                             [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                          </td>
                          <td style="width: 70%; text-align: center; font-size: 15pt;">
                              24.06.28 
                          </td>
                      </tr>
                  </table>
              </div>
          </div>
          <div class="tab-pane fade" id="department_info" role="tabpanel" aria-labelledby="contact-tab">
              <div class="tab-pane fade show active" id="school_info" role="tabpanel" aria-labelledby="home-tab">
                  <table style="width: 100%;">
                      <tr style="border : solid 1px #175F30; background-color: #175F30;">
                          <th style="color: #FFFFFF; width: 70%; text-align: center; font-size: 18pt;">제목</th>
                          <th style="color: #FFFFFF; width: 30%; text-align: center; font-size: 18pt;">등록일자</th>
                      </tr>
                      <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px; margin-top: 10%;">
                          <td style="width: 70%; text-align: left; font-size: 15pt; ">
                              2024학년도 2학기 등록금 납부안내 
                          </td>
                          <td style="width: 70%; text-align: center; font-size: 15pt;">
                              24.06.23 
                          </td>
                      </tr>
                      <tr style="border: dotted 4px gray; border-width : 0 0 2px; height: 50px;">
                          <td style="width: 70%; text-align: left; font-size: 15pt; ">
                             [성적] 재학생 학점포기 기간 안내[2024.8.7(월)-8.9(수)]
                          </td>
                          <td style="width: 70%; text-align: center; font-size: 15pt;">
                              24.06.28 
                          </td>
                      </tr>
                  </table>
              </div>
          </div>
      </div>
  </div>