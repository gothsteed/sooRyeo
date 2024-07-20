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
</style>


<script type="text/javascript">

function goView(announcement_seq){
	const goBackURL = "${requestScope.goBackURL}";
	
	const frm = document.goViewFrm;
	frm.seq.value = announcement_seq;
	frm.goBackURL.value = goBackURL;
	
	frm.method = "post";
	frm.action = "<%= ctxPath %>/board/announcementView.lms";
	frm.submit();
}

</script>

<body style="">
	<div class="row">
		<div class="col-sm-12 col-md-12">
			<div class="grid-stack gs-12 gs-id-0 ui-droppable ui-droppable-over grid-stack-animate" gs-current-row="7" style="height: 720px;">
				

				
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="0" gs-w="3" gs-h="3" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div id="graph">
						
						</div>
					</div>
				</div>
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="5" gs-y="0" gs-w="3" gs-h="3" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div id="graph">
						
						</div>
					</div>
				</div>
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="8" gs-y="0" gs-w="3" gs-h="3" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div id="graph">
						
						</div>
					</div>
				</div>
				

				
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="0" gs-w="4" gs-h="3" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z" />
	            </svg>
							<h4>날씨</h4>
						</div>
						<p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
					</div>
				</div>
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="6" gs-y="0" gs-w="4" gs-h="3" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
				            	<path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z" />
				            </svg>
							<h4>오늘 수업</h4>
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
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="4" gs-w="8" gs-h="4" gs-no-resize="true">
					<div class="grid-stack-item-content">
						<div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z" />
	            </svg>
							<h4>시간표</h4>
						</div>
						<p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
					</div>
				</div>
				
				
				
				<div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" id="announcement" gs-x="2" gs-y="8" gs-w="8" gs-h="4" gs-no-resize="true" >
					<div class="grid-stack-item-content" >
						
					         <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
					           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
					            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
					            </svg>                       
				            	<h4>수려대학교 공지사항</h4>
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