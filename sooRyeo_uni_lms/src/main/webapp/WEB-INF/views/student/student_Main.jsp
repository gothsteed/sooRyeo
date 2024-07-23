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

$(document).ready(function(){
	
	showWeather();

	<%--
	$.ajax({
		url:"<%=ctxPath%>/student/myAttendance_byCategoryJSON.lms",
		data:{"userid" : "${sessionScope.loginuser.userid}"},
		dataType:"json",
		success:function(json){
			
			console.log(JSON.stringify(json));
			
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
		
	}); // end of $.ajax
	--%>
	
	
	//////////////////////////////////////////////
	// 전체 출석률 하이차트
	Highcharts.chart('lecture_container', {
	    chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
	        type: 'pie'
	    },
	    title: {
	        text: '전체강의 출석[%]'
	    },
	    tooltip: {
	        valueSuffix: '%'
	    },
	    plotOptions: {
	        series: {
	            allowPointSelect: true,
	            cursor: 'pointer',
	            dataLabels: [{
	                enabled: true,
	                distance: 20
	            }, {
	                enabled: true,
	                distance: -40,
	                format: '{point.percentage:.1f}%',
	                style: {
	                    fontSize: '1.2em',
	                    textOutline: 'none',
	                    opacity: 0.7
	                },
	                filter: {
	                    operator: '>',
	                    property: 'percentage',
	                    value: 10
	                }
	            }]
	        }
	    },
	    series: [
	        {
	            name: 'Percentage',
	            colorByPoint: true,
	            data: [
	                {
	                    name: 'Water',
	                    y: 55.02
	                },
	                {
	                    name: 'Fat',
	                    sliced: true,
	                    selected: true,
	                    y: 26.71
	                },
	                {
	                    name: 'Carbohydrates',
	                    y: 1.09
	                },
	                {
	                    name: 'Protein',
	                    y: 15.5
	                },
	                {
	                    name: 'Ash',
	                    y: 1.68
	                }
	            ]
	        }
	    ]
	});
	//////////////////////////////////////////////
	
	
	
	//////////////////////////////////////////////
	// 과제달성률 하이차트
	Highcharts.chart('assignment_container', {
	    chart: {
	        type: 'pie'
	    },
	    title: {
	        text: '과제달성률[%]'
	    },
	    tooltip: {
	        valueSuffix: '%'
	    },
	    plotOptions: {
	        series: {
	            allowPointSelect: true,
	            cursor: 'pointer',
	            dataLabels: [{
	                enabled: true,
	                distance: 20
	            }, {
	                enabled: true,
	                distance: -40,
	                format: '{point.percentage:.1f}%',
	                style: {
	                    fontSize: '1.2em',
	                    textOutline: 'none',
	                    opacity: 0.7
	                },
	                filter: {
	                    operator: '>',
	                    property: 'percentage',
	                    value: 10
	                }
	            }]
	        }
	    },
	    series: [
	        {
	            name: 'Percentage',
	            colorByPoint: true,
	            data: [
	                {
	                    name: 'Water',
	                    y: 55.02
	                },
	                {
	                    name: 'Fat',
	                    sliced: true,
	                    selected: true,
	                    y: 26.71
	                },
	                {
	                    name: 'Carbohydrates',
	                    y: 1.09
	                },
	                {
	                    name: 'Protein',
	                    y: 15.5
	                },
	                {
	                    name: 'Ash',
	                    y: 1.68
	                }
	            ]
	        }
	    ]
	});
	//////////////////////////////////////////////
	
});

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
				
		    	console.log( $(local).text() + " stn_id:" + $(local).attr("stn_id") + " icon:" + $(local).attr("icon") + " desc:" + $(local).attr("desc") + " ta:" + $(local).attr("ta") ); 
		      //	속초 stn_id:90 icon:03 desc:구름많음 ta:-2.5
		      //	북춘천 stn_id:93 icon:03 desc:구름많음 ta:-7.0
		    	
		        let icon = $(local).attr("icon");  
		        if(icon == "") {
		        	icon = "없음";
		        }
		      
		        html += "<tr>";
				html += "<td>"+$(local).text()+"</td><td><img src='<%= ctxPath%>/resources/images/weather/"+icon+".png' />"+$(local).attr("desc")+"</td><td>"+$(local).attr("ta")+"</td>";
				html += "</tr>";
		        
				
				// ====== XML 을 JSON 으로 변경하기  시작 ====== //
				   //var jsonObj = {"locationName":$(local).text(), "ta":$(local).attr("ta")};
				   
				   //jsonObjArr.push(jsonObj);
				// ====== XML 을 JSON 으로 변경하기  끝 ====== //
				
		    }// end of for------------------------ 
		    
		    html += "</table>";
		    
		    $("div#displayWeather").html(html);
		    
		    
		 // ====== XML 을 JSON 으로 변경된 데이터를 가지고 차트그리기 시작  ====== //
		<%-- 	
		 
		 	var str_jsonObjArr = JSON.stringify(jsonObjArr); 
			                  // JSON객체인 jsonObjArr를 String(문자열) 타입으로 변경해주는 것 
			                  
			$.ajax({
				url:"<%= request.getContextPath()%>/opendata/weatherXMLtoJSON.action",
				type:"POST",
				data:{"str_jsonObjArr":str_jsonObjArr},
				dataType:"JSON",
				success:function(json){
					
				//	alert(json.length);
					
					// ======== chart 그리기 ========= // 
					var dataArr = [];
					$.each(json, function(index, item){
						dataArr.push([item.locationName, 
							          Number(item.ta)]);
					});// end of $.each(json, function(index, item){})------------
					
					
					Highcharts.chart('weather_chart_container', {
					    chart: {
					        type: 'column'
					    },
					    title: {
					        text: '오늘의 전국 기온(℃)'   // 'ㄹ' 을 누르면 ℃ 가 나옴.
					    },
					    subtitle: {
					    //    text: 'Source: <a href="http://en.wikipedia.org/wiki/List_of_cities_proper_by_population">Wikipedia</a>'
					    },
					    xAxis: {
					        type: 'category',
					        labels: {
					            rotation: -45,
					            style: {
					                fontSize: '10px',
					                fontFamily: 'Verdana, sans-serif'
					            }
					        }
					    },
					    yAxis: {
					        min: -10,
					        title: {
					            text: '온도 (℃)'
					        }
					    },
					    legend: {
					        enabled: false
					    },
					    tooltip: {
					        pointFormat: '현재기온: <b>{point.y:.1f} ℃</b>'
					    },
					    series: [{
					        name: '지역',
					        data: dataArr, // **** 위에서 만든것을 대입시킨다. **** 
					        dataLabels: {
					            enabled: true,
					            rotation: -90,
					            color: '#FFFFFF',
					            align: 'right',
					            format: '{point.y:.1f}', // one decimal
					            y: 10, // 10 pixels down from the top
					            style: {
					                fontSize: '10px',
					                fontFamily: 'Verdana, sans-serif'
					            }
					        }
					    }]
					});
					// ====== XML 을 JSON 으로 변경된 데이터를 가지고 차트그리기 끝  ====== //
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});                  
			///////////////////////////////////////////////////
			--%>
		},// end of success: function(xml){ }------------------	
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	
}// end of success: function(xml){ }------------------

</script>

<body style="">
	<div class="row">
		<div class="col-sm-12 col-md-12">
			<div class="grid-stack gs-12 gs-id-0 ui-droppable ui-droppable-over grid-stack-animate" gs-current-row="7" style="height: 600px;">
				
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="4" gs-y="0" gs-w="4" gs-h="4" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<img src="<%= ctxPath%>/resources/images/attendance.png" style="width: 30px; height: 30px; margin-right:3%; margin-bottom:3%;"/>
							<h4 style="font-weight: bold;">출석률</h4>
						</div>
						
						<div style="display: flex;">   
							<div style="width: 80%; margin:auto; max-height:50px;">
							
							   <div id="lecture_container"></div>
							   <div id="table_container" style="margin: 40px 0 0 0;"></div>
							
							</div>
						</div>
					</div>
				</div>
				
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="8" gs-y="0" gs-w="4" gs-h="4" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<img src="<%= ctxPath%>/resources/images/tasks.png" style="width: 30px; height: 30px; margin-right:3%; margin-bottom:3%;"/>
							<h4 style="font-weight: bold;">과제달성률</h4>
						</div>
						<div style="display: flex;">   
							<div style="width: 80%; margin:auto; height:0px;">
							
							   <div id="assignment_container"></div>
							   <div id="table_container" style="margin: 40px 0 0 0;"></div>
							
							</div>
						</div>
					</div>
				</div>
	

				
			        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="0" gs-y="0" gs-w="4" gs-h="4" gs-no-resize="true">
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
							    </tr>
							  </thead>
							  <tbody class="table-group-divider">
							<c:forEach var="lec" items="${requestScope.today_lec}" varStatus="status" > 
							    <tr>
							      <th scope="row"></th>
							      <td>${lec.lec_name}</td>
							      <td>${lec.credit}학점</td>
							      <td>${lec.prof_name}</td>
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
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="0" gs-y="12" gs-w="8" gs-h="4" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							
							<h4 style="font-weight: bold;">시간표</h4>
						</div>
						<p class="card-text" style="margin-bottom: 0">
						
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