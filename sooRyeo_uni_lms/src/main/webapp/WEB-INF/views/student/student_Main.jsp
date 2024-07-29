<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap CSS -->

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Bootstrap JS and dependencies -->

<script type="text/javascript" src="<%=ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script>

<script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/highcharts-more.js"></script>
<script src="<%=ctxPath %>/resources/Highcharts-10.3.1/code/modules/solid-gauge.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/series-label.js"></script>


<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=ctxPath%>/resources/node_modules/gridstack/dist/gridstack.min.css" rel="stylesheet" />

<style type="text/css">


	.timetable th, .timetable td {
		/*border: 1px solid black;*/
		border-collapse: collapse;
		text-align: center;
		width: 100px;
		padding: 5px;
		height: 20px;
		text-align: center;
	}

.grid-stack-item-content {
	background-color: #f9f9f9;
	color: #333;
	border: 1px solid #ddd; border-radius : 12px; box-shadow : 0 4px 8px
	rgba( 0, 0, 0, 0.1); display : flex; flex-direction : column;
	transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
	border: 1px solid #ddd;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);

	padding: 20px;
}

.grid-stack-item-content:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.grid-stack-item-content {
    transition: height 0.3s ease-in-out;
}

.grid-stack-item-content .content {
	margin-top:5px;
}

.a_title:hover {
    color: #d1e0e0;
    cursor: pointer; /* 마우스를 올렸을 때 포인터 모양으로 변경 */
}


.highcharts-figure,
.highcharts-data-table table {
   min-width: 320px;
   max-width: 500px;
   margin: 1em auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #ebebeb;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}

.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}

.highcharts-data-table th {
    font-weight: 600;
    padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
    padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}

.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
</style>



<script type="text/javascript">
	const colors = [
		"#d1e7dd", // light green
		"#f8d7da", // light red
		"#fff3cd", // light yellow
		"#d1ecf1", // light cyan
		"#f5c6cb", // light pink
		"#d6d8d9", // light gray
		"#c3e6cb", // light green
		"#bee5eb"  // light blue
	];



	let colorIndex = 0;


$(document).ready(function(){
	
	showWeather();
	
    
    // 문서가 로드 되어지면 통계가 보이도록 한다.
    $("select#searchType").val("Curriculum_nameList").trigger("change");

    
    $("select[name='name']").change(function() {
        func_choice("myAttendance_byCategory");
    });
    
    fetchTimeTable();
    
    
}); // end of $(document).ready



// function declaration
function func_choice(searchTypeVal) {
	
     switch (searchTypeVal) {
     
        case "myAttendance_byCategory": // 과목을 선택한 경우
            
            $.ajax({
                url: "<%=ctxPath%>/student/myAttendance_byCategoryJSON.lms",
                dataType: "json",
                data: {"name" : $("select[name='name']").val()},
                success: function(json) {

                    // console.log( $("select[name='name']").val() );
                    // 국어학개론
                    
                    // console.log(JSON.stringify(json));
                    // {"name":"국어학개론","attendance_rate":"14"}
                 
                	$("div#lecture_container").empty();
                	$("div.highcharts-data-table").empty();
                	
                	
                	let resultArr = [];

                	if(json.attendance_rate) {	// attendance_rate가 존재하는지 확인
                		
                	}
                		let attendanceRate = parseFloat(json.attendance_rate); // 문자열을 숫자로 변환
                		
                		resultArr.push({
                            name: json.name,
                            y: attendanceRate
                		});
                		
                		// 미출석률 추가
                        resultArr.push({
                            name: json.name + ' 미출석',
                            y: 100 - attendanceRate // 미출석률 계산
                        });
                            
                   	//////////////////////////////////////////////
                    // 하이차트 생성
                    Highcharts.chart('lecture_container', {
                        chart: {
                            type: 'pie'
                        },
                        title: {
                            text: '출석률'
                        },
                        plotOptions: {
                            pie: {
                                shadow: false,
                                center: ["50%", "50%"],
                                dataLabels: {
                                    enabled: true,
                                    format: '{point.name}: <b>{point.percentage:.2f}%</b>'
                                },
                                states: {
                                    hover: {
                                        enabled: true
                                    }
                                },
                                size: "70%",
                                innerSize: "40%",
                                borderColor: null,
                                borderWidth: 5
                            }
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
                        },
                        series: [{
                            name: '출석률',
                            innerSize: '60%',
                            data: resultArr // 출석률과 미출석률 데이터 사용
                        }],
                    });
					//////////////////////////////////////////////
					
					
                    // HTML 테이블 생성
                    /* let v_html = "<table>";
                    v_html += "<tr><th>수업명</th><th>퍼센티지</th></tr>";

                    v_html += "<tr>" +
                            "<td>" + json.name + "</td>" +
                            "<td>" + json.attendance_rate + "%" + "</td>" +
                            "</tr>";
              
                    
                    
                    v_html += "</table>";
                    $("div#table_container").html(v_html); */
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
     } // end of switch
     
     
} // end of function func_choice(searchTypeVal)



function goView(announcement_seq){
	const goBackURL = "${requestScope.goBackURL}";
	
	const frm = document.goViewFrm;
	frm.seq.value = announcement_seq;
	frm.goBackURL.value = goBackURL;
	
	frm.method = "post";
	frm.action = "<%= ctxPath %>/board/announcementView.lms";
	frm.submit();
}

function showWeather(){
	
	$.ajax({
		url:"<%= ctxPath%>/weatherXML.lms",
		type:"get",
		dataType:"xml",
		success:function(xml){
			const rootElement = $(xml).find(":root"); 
			// console.log("확인용 : " + $(rootElement).prop("tagName") );
			// 확인용 : current
			
			const weather = rootElement.find("weather"); 
			const updateTime = $(weather).attr("year")+"년 "+$(weather).attr("month")+"월 "+$(weather).attr("day")+"일 "+$(weather).attr("hour")+"시"; 
			// console.log(updateTime);
			// 2023년 12월 19일 10시
			
			const localArr = rootElement.find("local");
			// console.log("지역개수 : " + localArr.length);
			// 지역개수 : 97
			
			let html = "날씨정보 발표시각 : <span style='font-weight:bold;'>"+updateTime+"</span>&nbsp;";
	            html += "<span style='color:blue; cursor:pointer; font-size:9pt;' onclick='javascript:showWeather();'>업데이트</span><br/><br/>";
	            html += "<table class='table table-hover' align='center'>";
		        html += "<tr>";
		        html += "<th>지역</th>";
		        html += "<th>날씨</th>";
		        html += "<th>기온</th>";
		        html += "</tr>";
		    
		     // ====== XML 을 JSON 으로 변경하기  시작 ====== //
				var jsonObjArr = [];
			 // ====== XML 을 JSON 으로 변경하기  끝 ====== //    
		        
		    for(let i=0; i<localArr.length; i++){
		    	
		    	let local = $(localArr).eq(i);
				/* .eq(index) 는 선택된 요소들을 인덱스 번호로 찾을 수 있는 선택자이다. 
				      마치 배열의 인덱스(index)로 값(value)를 찾는 것과 같은 효과를 낸다.
				*/
				
		    	// console.log( $(local).text() + " stn_id:" + $(local).attr("stn_id") + " icon:" + $(local).attr("icon") + " desc:" + $(local).attr("desc") + " ta:" + $(local).attr("ta") ); 
		      //	속초 stn_id:90 icon:03 desc:구름많음 ta:-2.5
		      //	북춘천 stn_id:93 icon:03 desc:구름많음 ta:-7.0
		    	
		        let icon = $(local).attr("icon");  
		        if(icon == "") {
		        	icon = "없음";
		        }
		      
		        html += "<tr>";
				html += "<td>"+$(local).text()+"</td><td><img src='<%= ctxPath%>/resources/images/weather/"+icon+".png' />"+$(local).attr("desc")+"</td><td>"+$(local).attr("ta")+"</td>";
				html += "</tr>";
		        

				
		    }// end of for------------------------ 
		    
		    html += "</table>";
		    
		    $("div#displayWeather").html(html);


		},// end of success: function(xml){ }------------------	
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	
}// end of success: function(xml){ }------------------


function fetchTimeTable() {

	const url = '<%=ctxPath%>' + '/student/timetableJSON.lms'

	console.log(url);

	fetch(url)
			.then(response => response.json())
			.then(data => {

				console.log(data);

				fillTimetable(data);

			})
			.catch(error => console.error("Error fetching data:", error));
}



function fillTimetable(data) {
	const courseListContainer = document.getElementById('course-list-container');


	data.courseList.forEach((course, index) => {
		const color = colors[index % colors.length];

		course.timeList.forEach(time => {

			// Fill the timetable
			const day = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'][time.day_of_week - 1];
			if (isTimeslotAvailable(day, time.start_period, time.end_period)) {
				const slotId = day + "-" + time.start_period;
				const slot = document.getElementById(slotId);
				if (slot) {
					slot.textContent = course.curriculum.name;
					slot.style.backgroundColor = color;
					slot.style.verticalAlign = 'middle';
					slot.rowSpan = time.end_period - time.start_period + 1;
					for (let period = time.start_period + 1; period <= time.end_period; period++) {
						const nextSlotId = day + "-" + period;
						const nextSlot = document.getElementById(nextSlotId);
						if (nextSlot) {
							nextSlot.remove();
						}
					}
				}
			} else {
				console.warn("이미 선택된 시간입니다");
			}
		});
	});



}

	function isTimeslotAvailable(day, start_period, end_period) {
		for (let period = start_period; period <= end_period; period++) {
			const slotId = day + "-" + period;
			const slot = document.getElementById(slotId);
			if (slot && slot.textContent.trim() !== "") {
				return false;
			}
		}
		return true;
	}

</script>

<body style="">
	<div class="row">
		<div class="col-sm-12 col-md-12">
			<div class="grid-stack gs-12 gs-id-0 ui-droppable ui-droppable-over grid-stack-animate" gs-current-row="7" style="height: 600px;">
				
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="4" gs-y="0" gs-w="4" gs-h="5" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<img src="<%=ctxPath%>/resources/images/attendance.png" style="width: 30px; height: 30px; margin-right:3%; margin-bottom:3%;"/>
							<h4 style="font-weight: bold;">출석률</h4>
						</div>
						
						<div style="display: flex;">   
							<div style="width: 80%; margin:auto; max-height:50px;">
								
								<form name="searchFrm" style="margin: 20px 0 50px 0;">
								<span style="font-weight: bold;">수업 선택 :</span>
								    <select name="name" id="searchType" style="height: 30px;" onchange="func_choice(this.value)">
									        <c:forEach var="nameList" items="${requestScope.Curriculum_nameList}">
									            <option value="${nameList.name}">${nameList.name}</option>
									        </c:forEach>
								    </select>
								</form>
								
							   	<div id="lecture_container"></div>
								<div id="table_container" style="margin: 40px 0 0 0;"></div>
							</div>
						</div>
					</div>
				</div>
				

				
		<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="0" gs-y="0" gs-w="4" gs-h="5" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	            <img src="<%= ctxPath%>/resources/images/sun.png" style="width: 30px; height: 40px; margin-right:3%; margin-bottom:3%;"/>
	            <h4 style="font-weight: bold;">날씨</h4>           
            </div>
            <div id="displayWeather" style="min-width: 90%; max-height: 500px; overflow-y: scroll; margin-top: 40px; margin-bottom: 70px; padding-left: 10px; padding-right: 10px;"></div>
          </div>
        </div>
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="0" gs-y="2" gs-w="4" gs-h="4" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<img src="<%= ctxPath%>/resources/images/class2.png" style="width: 30px; height: 40px; margin-right:3%; margin-bottom:3%;"/>
							<h4 style="font-weight: bold;">오늘의 수업</h4>
						</div>
						
						<c:if test="${requestScope.today_lec != '[]'}">
							<table class="table">
							  <thead style="background-color: #d1e0e0;">
							    <tr>
							      <th scope="col"></th>
							      <th scope="col">수업명</th>
							      <th scope="col">학점</th>
							      <th scope="col">교수명</th>
							      <th scope="col">교시</th>
							    </tr>
							  </thead>
							  <tbody class="table-group-divider">
							<c:forEach var="lec" items="${requestScope.today_lec}" varStatus="status" > 
							    <tr>
							      <th scope="row"></th>
							      <td>${lec.lec_name}</td>
							      <td>${lec.credit}학점</td>
							      <td>${lec.prof_name}</td>
							      <td>${lec.start_period} - ${lec.end_period}</td>
							    </tr>
							</c:forEach>
							  </tbody>
							</table>
						</c:if>
						
						<c:if test="${requestScope.today_lec == '[]'}">
							금일 수업이 없습니다.
						</c:if>
					</div>
				</div>
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="8" gs-y="4" gs-w="4" gs-h="5" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<img src="<%= ctxPath%>/resources/images/schedule.png" style="width: 30px; height: 30px; margin-right:3%; margin-bottom:3%;"/>
							<h4 style="font-weight: bold;">시간표</h4>
						</div>
						<p class="card-text" style="margin-bottom: 10%;">
						<table class="timetable table table-bordered">
							<thead>
							<tr>
								<th>교시</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>1</td>
								<td id="monday-1" class="time-slot"></td>
								<td id="tuesday-1" class="time-slot"></td>
								<td id="wednesday-1" class="time-slot"></td>
								<td id="thursday-1" class="time-slot"></td>
								<td id="friday-1" class="time-slot"></td>
							</tr>
							<tr>
								<td>2</td>
								<td id="monday-2" class="time-slot"></td>
								<td id="tuesday-2" class="time-slot"></td>
								<td id="wednesday-2" class="time-slot"></td>
								<td id="thursday-2" class="time-slot"></td>
								<td id="friday-2" class="time-slot"></td>
							</tr>
							<tr>
								<td>3</td>
								<td id="monday-3" class="time-slot"></td>
								<td id="tuesday-3" class="time-slot"></td>
								<td id="wednesday-3" class="time-slot"></td>
								<td id="thursday-3" class="time-slot"></td>
								<td id="friday-3" class="time-slot"></td>
							</tr>
							<tr>
								<td>4</td>
								<td id="monday-4" class="time-slot"></td>
								<td id="tuesday-4" class="time-slot"></td>
								<td id="wednesday-4" class="time-slot"></td>
								<td id="thursday-4" class="time-slot"></td>
								<td id="friday-4" class="time-slot"></td>
							</tr>
							<tr>
								<td>5</td>
								<td id="monday-5" class="time-slot"></td>
								<td id="tuesday-5" class="time-slot"></td>
								<td id="wednesday-5" class="time-slot"></td>
								<td id="thursday-5" class="time-slot"></td>
								<td id="friday-5" class="time-slot"></td>
							</tr>
							<tr>
								<td>6</td>
								<td id="monday-6" class="time-slot"></td>
								<td id="tuesday-6" class="time-slot"></td>
								<td id="wednesday-6" class="time-slot"></td>
								<td id="thursday-6" class="time-slot"></td>
								<td id="friday-6" class="time-slot"></td>
							</tr>
							<tr>
								<td>7</td>
								<td id="monday-7" class="time-slot"></td>
								<td id="tuesday-7" class="time-slot"></td>
								<td id="wednesday-7" class="time-slot"></td>
								<td id="thursday-7" class="time-slot"></td>
								<td id="friday-7" class="time-slot"></td>
							</tr>
							<tr>
								<td>8</td>
								<td id="monday-8" class="time-slot"></td>
								<td id="tuesday-8" class="time-slot"></td>
								<td id="wednesday-8" class="time-slot"></td>
								<td id="thursday-8" class="time-slot"></td>
								<td id="friday-8" class="time-slot"></td>
							</tr>
							</tbody>
						</table>
						</p>
					</div>
				</div>
				
				
				
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" id="announcement" gs-x="8" gs-y="0" gs-w="8" gs-h="4" gs-no-resize="true" >
					<div class="grid-stack-item-content" >
						
					         <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
					            <img src="<%= ctxPath%>/resources/images/notificaiton.png" style="width: 40px; height: 40px; margin-right:2%; margin-bottom:3%;"/>
				            	<h4 style="font-weight: bold;">공지사항</h4>
				            </div>
							

							<div class="container">
								
		
								<ul class="nav nav-tabs" id="myTab" role="tablist">
									<li class="nav-item" role="presentation"><a class="nav-link active" data-toggle="tab" data-target="#school_info" style="font-weight: bold; font-size: 14pt; color: #175F30;">학사공지</a></li>
								</ul>
								
								<div class="tab-content" id="myTabContent">
									<div class="tab-pane fade show active" id="school_info" role="tabpanel" aria-labelledby="home-tab">
										<table style="width: 100%;">
											<tr style="border: solid 1px #175F30; background-color: #175F30;">
												<th style="color: #FFFFFF; width: 10%; text-align: center; font-size: 18pt;">NO</th>
												<th style="color: #FFFFFF; width: 90%; text-align: center; font-size: 18pt;">제목</th>
											</tr>
											
											<c:forEach var="list" items="${requestScope.announcementList}" varStatus="status">    
												<tr style="border: dotted 4px gray; border-width: 0 0 2px; height: 50px; margin-top: 10%;">
													<td style="width: 10%; text-align: left; font-size: 15pt;">&nbsp;&nbsp;${((requestScope.currentPage- 1) * requestScope.perPageSize) + status.count}</td>
													<td style="width: 90%; text-align: center; font-size: 15pt;"><span class="a_title" style="cursor:pointer;" onclick="goView('${list.announcement_seq}')">${list.a_title}</span></td>
												</tr>
								            </c:forEach>
										</table>
										
										<form name="goViewFrm">
											<input type="hidden" name="seq" />
											<input type="hidden" name="goBackURL" />
										</form>
										
									</div>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- support for IE -->
	<script src="<%=ctxPath%>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
	<script type="text/javascript">
/* 		let grid = GridStack.init({
			cellHeight : 120,
			acceptWidgets : true,
		});

		GridStack.setupDragIn('.newWidget', {
			appendTo : 'body',
			helper : 'clone'
		});

		grid.on('added removed change', function(e, items) {
			let str = '';
			items.forEach(function(item) {
				str += ' (x,y)=' + item.x + ',' + item.y;
			});
			console.log(e.type + ' ' + items.length + ' items:' + str);
		}); */
		
		
		document.addEventListener('DOMContentLoaded', function () {
			let grid = GridStack.init({
				cellHeight : 120,
				acceptWidgets : true,
			});

			GridStack.setupDragIn('.newWidget', {
				appendTo : 'body',
				helper : 'clone'
			});

			grid.on('added removed change', function(e, items) {
				let str = '';
				items.forEach(function(item) {
					str += ' (x,y)=' + item.x + ',' + item.y;
				});
				console.log(e.type + ' ' + items.length + ' items:' + str);
			});
		    // Optional: Call resizeItemToContent when content changes, for example in response to a user action

		
		});
		
		
		$(document).ready(function() {
			let chart = Highcharts.chart('graph', {
				  chart: {
				    type: 'solidgauge',
				    height: '100%'  // Adjust based on the aspect ratio you prefer
				  },
				  title: {
				    text: '프로그래밍 기초',
				    style: {
				      fontSize: '18px'
				    }
				  },
				  tooltip: {
				    enabled: false
				  },
			        exporting: {
			            enabled: false  // This line disables the exporting menu
			        },
				  pane: {
				    startAngle: 0,
				    endAngle: 360,
				    background: [{ // Track for Move
				      outerRadius: '112%',
				      innerRadius: '88%',
				      backgroundColor: Highcharts.color(Highcharts.getOptions().colors[0]).setOpacity(0.3).get(),
				      borderWidth: 0
				    }]
				  },
				  yAxis: {
				    min: 0,
				    max: 100,
				    lineWidth: 0,
				    tickPositions: []
				  },
				  plotOptions: {
				    solidgauge: {
				      dataLabels: {
				        enabled: true,
				        borderWidth: 0,
				        color: 'black',
				        style: {
				          fontSize: '16px'
				        },
				        y: -20,
				        format: '<div style="text-align:center"><span style="font-size:13px; text-align:center;">{y}%</span><br/>' +
				                '<span style="font-size:13px;opacity:0.4">수강률</span></div>'
				      },
				      linecap: 'round',
				      stickyTracking: false,
				      rounded: true
				    }
				  },
				  credits: {
				    enabled: false
				  },
				  series: [{
				    name: 'Grades Completed',
				    data: [{
				      color: Highcharts.getOptions().colors[0],
				      radius: '112%',
				      innerRadius: '88%',
				      y: 75
				    }]
				  }],
				  
				    responsive: {
				        rules: [{
				            condition: {
				                maxWidth: 500
				            },
				            chartOptions: {
				                legend: {
				                    layout: 'horizontal',
				                    align: 'center',
				                    verticalAlign: 'bottom'
				                }
				            }
				        }]
				    }
				});
			
			
			chart.setSize(271, 200, true); // false to skip animation
			
		})

		// Ensure you have a mechanism to call resizeItemToContent whenever necessary, e.g., after content updates.


	</script>
</body>