<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/4.3.1/gridstack.min.css" rel="stylesheet"/>
<link href="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack.min.css" rel="stylesheet"/>


 <style data-styles="">ion-icon{visibility:hidden}.hydrated{visibility:inherit}</style>
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">


 <link rel="stylesheet" href="<%=ctxPath %>/resources/node_modules/gridstack/dist/demo.css">

<script type="module" src="<%=ctxPath %>/resources/node_modules/gridstack/dist/ionicons.esm.js"></script>
<script nomodule="" src="<%=ctxPath %>/resources/node_modules/gridstack/dist/ionicons.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<style type="text/css">

	.grid-stack { background: #E0E0E0; }
	.grid-stack-item-content { 
	  	background-color: white; 
	  	display: flex;
	  	flex-direction: column;
	  	border-radius: 10px;
	}
	
	.time_table td, .time_table th {
      	width: 150px;
      	height: 40px;
      	text-align: center; /* 셀 안의 텍스트를 중앙 정렬 */
      	vertical-align: middle; /* 셀 안의 텍스트를 수직으로 중앙 정렬 */
    }
    
    .smaller-font {
    	font-size: 11px;	
    }
    
</style>


<body style="gridstack">
  <h1>교수 대시보드</h1>
  <div class="row"> 
    <div class="col-sm-12 col-md-12">
      <div class="grid-stack gs-12 gs-id-0 ui-droppable ui-droppable-over grid-stack-animate" gs-current-row="7" style="height: 720px;">
        <!-- Widget 1: Weather -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="0" gs-w="4" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>
	            <h4>날씨</h4>
            </div>
            <p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
          </div>
        </div>
        <!-- Widget 2: Timetable -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="6" gs-y="0" gs-w="4" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>
            	<h4>시간표</h4>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered time_table smaller-font">
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
        <!-- Widget 3: University Schedule -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="4" gs-w="8" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>                       
            	<h4>수려대학교 일정</h4>
            </div>
            <p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
          </div>
        </div>
        <!-- Widget 4: University Announcements -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="8" gs-w="8" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>                        
            	<h4>수려대학교 공지사항</h4>
            </div>
            <div class="container">
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
			<!-- Nav tabs end -->
          	</div>
        </div>
        
      </div>
    </div>
  </div>
  
  <!-- support for IE -->
  <script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-poly.js"></script>
  <script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
  <script type="text/javascript">
  
  	<!-- gridstack 작동을 위한 js -->
    let grid = GridStack.init({
      cellHeight: 120,
      acceptWidgets: true,
    });

    GridStack.setupDragIn('.newWidget', { appendTo: 'body', helper: 'clone' });

    grid.on('added removed change', function(e, items) {
      let str = '';
      items.forEach(function(item) { str += ' (x,y)=' + item.x + ',' + item.y; });
      console.log(e.type + ' ' + items.length + ' items:' + str );
    });
    
    <!-- tabs 작동을 위한 js -->
    const triggerTabList = document.querySelectorAll('#myTab button')
    triggerTabList.forEach(triggerEl => {
      const tabTrigger = new bootstrap.Tab(triggerEl)

      triggerEl.addEventListener('click', event => {
        event.preventDefault()
        tabTrigger.show()
      })
    })
    

  </script>
</body>
