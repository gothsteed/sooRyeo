<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 320px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	div#chart_container {
	    height: 400px;
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
	
	input[type="number"] {
	    min-width: 50px;
	}
	
	div#table_container table {width: 100%}
	div#table_container th, div#table_container td {border: solid 1px gray; text-align: center;} 
	div#table_container th {background-color: #595959; color: white;} 
</style> 

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/series-label.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/drilldown.js"></script>

 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">
   $(document).ready(function(){
	   
	    $.ajax({
	    	url:"<%= ctxPath%>/admin/studentCntByDeptname.lms",
	    	dataType:"json",
	    	success:function(json){
	    	 	//console.log(JSON.stringify(json)); 
	    		/*
	    		  [{"department_name":"Shipping","cnt":"45","percentage":"40.5"}
	    		  ,{"department_name":"Sales","cnt":"34","percentage":"30.6"}
	    		  ,{"department_name":"IT","cnt":"9","percentage":"8.1"}
	    		  ,{"department_name":"Finance","cnt":"6","percentage":"5.4"}
	    		  ,{"department_name":"Purchasing","cnt":"6","percentage":"5.4"}
	    		  ,{"department_name":"Executive","cnt":"3","percentage":"2.7"}
	    		  ,{"department_name":"Accounting","cnt":"2","percentage":"1.8"}
	    		  ,{"department_name":"Marketing","cnt":"2","percentage":"1.8"}
	    		  ,{"department_name":"Administration","cnt":"1","percentage":"0.9"}
	    		  ,{"department_name":"Human Resources","cnt":"1","percentage":"0.9"}
	    		  ,{"department_name":"Public Relations","cnt":"1","percentage":"0.9"}
	    		  ,{"department_name":"부서없음","cnt":"1","percentage":"0.9"}
	    		  ] 
	    		*/
	    		
	    		$("div#chart_container").empty();
	    		$("div#table_container").empty();
	    		$("div.highcharts-data-table").empty();
			    
	    		let resultArr = [];
	    		
	    		for(let i=0; i<json.length; i++){
	    			
	    			let obj;
	    			
	    			if(i==0) {
	    				obj = {
					            name: json[i].department_name,
					            y: Number(json[i].percentage),
					            sliced: true,
					            selected: true
					          };
	    			}
	    			else {
	    				obj = {
					            name: json[i].department_name,
					            y: Number(json[i].percentage)
					          };
	    			}
	    			
	    			resultArr.push(obj); // 배열속에 객체를 넣기
	    		}// end of for------------------
	    		
			    ///////////////////////////////////   
				Highcharts.chart('chart_container', {
				    chart: {
				        plotBackgroundColor: null,
				        plotBorderWidth: null,
				        plotShadow: false,
				        type: 'pie'
				    },
				    title: {
				        text: '수려대학교 학과별 인원통계'
				    },
				    tooltip: {
				        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
				    },
				    accessibility: {
				        point: {
				            valueSuffix: '%'
				        }
				    },
				    plotOptions: {
				        pie: {
				            allowPointSelect: true,
				            cursor: 'pointer',
				            dataLabels: {
				                enabled: true,
				                format: '<b>{point.name}</b>: {point.percentage:.2f} %'
				            }
				        }
				    },
				    series: [{
				        name: '인원비율',
				        colorByPoint: true,
				        data: resultArr
				    }]
				});			    
			    ///////////////////////////////////
			    
			    let v_html = "<table>";
			    
			        v_html += "<tr>" +
			                     "<th>부서명</th>" + 
			                     "<th>인원수</th>" +
			                     "<th>퍼센티지</th>" + 
			                  "</tr>";
			                  
			    $.each(json, function(index, item){
			    	v_html += "<tr>" +
			    	            "<td>"+ item.department_name +"</td>" +
			    	            "<td>"+ item.cnt +"</td>" +
			    	            "<td>"+ item.percentage +"</td>" +
			    	          "</tr>";  
			    });              
			    
			    v_html += "</table>";
			    
			    $("div#table_container").html(v_html);
	    		
	    	},
	    	error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	    });
	
	    ///////////////////////////////////////////////////////
		showCount();
	    
	    
		
   });// end of $(document).ready(funciton(){})-------------
   
   function showCount(){
	   
	   
	   $.ajax({
	    	url:"<%= ctxPath%>/chart/showCount.lms",
	    	type:"post",
	    	dataType:"json",
	    	success: function(json) {
	    		// 서버에서 받은 JSON 데이터 처리
	            console.log(json);
	         
	        },
	    	error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	   });// end of $.ajax 
	   
   }// end of function showCount() 
   
   
   
</script>
    <div class="content">
        <div class="main-content">
            <div class="justify-content-center">

                <div class="card" style="width:50%;">
                  <h5 class="card-header">
                    	학과별 인원 차트
                  </h5>
                  <div class="card-body">
                    <h5 class="card-title">학과 별 인원 통계</h5>
                    <p class="card-text" id="columStackedBar">
                    <div style="display:flex;">
                   		<div id="chart_container"></div>
						<div id="table_container" style="margin: 40px 0 0 0;"></div>
                    </div>
                  </div>
                </div>
                
                <div class="card" style="width:50%;">
                  <h5 class="card-header">
                    	방문자 차트
                  </h5>
                  <div class="card-body">
                    <h5 class="card-title">교수 학생 방문 통계</h5>
                    <p class="card-text" id="columStackedBar">
                    <div style="display:flex;">
                   		<div id="count_container"></div>
                   		<div id="table_count_container" style="margin: 40px 0 0 0;"></div>
                    </div>
                  </div>
                </div>
                
            </div>
          </div>
    </div>
    <!-- Bootstrap JS and dependencies -->
