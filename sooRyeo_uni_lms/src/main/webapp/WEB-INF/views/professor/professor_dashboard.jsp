<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

.timetable th, .timetable td {
    /*border: 1px solid black;*/
    border-collapse: collapse;
    text-align: center;
    width: 100px;
    padding: 5px;
    height: 20px;
    text-align: center;
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

<!-- highcharts -->
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>



<!-- support for IE -->
<script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-poly.js"></script>
<script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
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
        
        <!-- gridstack 작동을 위한 js -->
       let grid = GridStack.init({
         cellHeight: 120,
         acceptWidgets: true,
       });
   
       GridStack.setupDragIn('.newWidget', { appendTo: 'body', helper: 'clone' });
   
       grid.on('added removed change', function(e, items) {
         let str = '';
         items.forEach(function(item) { str += ' (x,y)=' + item.x + ',' + item.y; });
         // console.log(e.type + ' ' + items.length + ' items:' + str );
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
    
       /////////////////////////////////////////////////////////////////
       
       showWeather();
        fetchProfTimeTable(${requestScope.prof_id})
       
     });// end of $(document).ready(function()
           
           
           
           
    ////////////////////////////////////////////////////////////////////////////
    // 날씨 가져오기
    // ------ 기상청 날씨정보 공공API XML 데이터 호출하기 ------ //
   
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
					
			    //	console.log( $(local).text() + " stn_id:" + $(local).attr("stn_id") + " icon:" + $(local).attr("icon") + " desc:" + $(local).attr("desc") + " ta:" + $(local).attr("ta") ); 
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
					var jsonObj = {"locationName":$(local).text(), "ta":$(local).attr("ta")};
					   
					jsonObjArr.push(jsonObj);
					// ====== XML 을 JSON 으로 변경하기  끝 ====== //
					
			    }// end of for------------------------ 
			    
			    html += "</table>";
			    
			    $("div#displayWeather").html(html);
			    
			    var str_jsonObjArr = JSON.stringify(jsonObjArr); 
		        // JSON객체인 jsonObjArr를 String(문자열) 타입으로 변경해주는 것 
			    
			    $.ajax({
					url:"<%= request.getContextPath()%>/weatherXMLtoJSON.lms",
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
		         
			    
			},// end of success: function(xml){ }------------------	
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		
	}// end of function showWeather()------------------
    	
	
	function goView(announcement_seq){
		const goBackURL = "${requestScope.goBackURL}";
		
		const frm = document.goViewFrm;
		frm.seq.value = announcement_seq;
		frm.goBackURL.value = goBackURL;
		
		frm.method = "post";
		frm.action = "<%= ctxPath %>/board/announcementView.lms";
		frm.submit();
	}



     function fetchProfTimeTable(prof_id) {

         const url = '<%=ctxPath%>' + '/admin/profTimetableJSON.lms?prof_id=' + prof_id;

         console.log(url);

         fetch(url)
             .then(response => response.json())
             .then(data => {

                 console.log(data);
                 clearTimetable();
                 recreateTimetableStructure();

                 fillTimetable(data);

             })
             .catch(error => console.error("Error fetching data:", error));
     }
     function fillTimetable(data) {

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

     function clearTimetable() {
         const timetable = document.querySelector('.timetable tbody');
         timetable.innerHTML = '';
     }

     function recreateTimetableStructure() {
         const timetable = document.querySelector('.timetable tbody');
         const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'];

         for (let i = 1; i <= 8; i++) {
             const row = document.createElement('tr');
             row.innerHTML = `<td>\${i}</td>`;

             days.forEach(day => {
                 row.innerHTML += `<td id="\${day}-\${i}" class="time-slot"></td>`;
             });

             timetable.appendChild(row);
         }
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


<div style="gridstack">
  <div class="row"> 
    <div class="col-sm-12 col-md-12">
      <div class="grid-stack gs-12 gs-id-0 ui-droppable ui-droppable-over grid-stack-animate" gs-current-row="7" style="height: 720px;">
        <!-- Widget 1: Weather -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="8" gs-y="4" gs-w="4" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
               <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
               <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
               </svg>
               <h4>날씨</h4>           
            </div>
            <div id="displayWeather" style="min-width: 90%; max-height: 500px; overflow-y: scroll; margin-top: 40px; margin-bottom: 70px; padding-left: 10px; padding-right: 10px;"></div>
          </div>
        </div>
        <!-- Widget 2: Timetable -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="8" gs-y="0" gs-w="4" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
                 <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
               <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
               </svg>
               <h4>시간표</h4>
            </div>
            <div class="table-responsive">
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
            </div>
          </div>
        </div>
        <!-- Widget 3: University Schedule -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="0" gs-y="4" gs-w="8" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>                       
            	<h4>오늘의 기온</h4>
            </div>
            <figure class="highcharts-figure">
		    	<div id="weather_chart_container"></div>
			</figure>
          </div>
        </div>
        <!-- Widget 4: University Announcements -->
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="0" gs-y="0" gs-w="8" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
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
         
         <!-- Nav tabs end -->
             </div>
        </div>
        
      </div>
    </div>
  </div>
  </div>

</div>