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

<div style="display: flex;">	
<div style="width: 80%; min-height: 1100px; margin:auto; ">

	<h2 style="margin: 50px 0;">학생 통계정보(차트)</h2>
	
	<form name="searchFrm" style="margin: 20px 0 50px 0; ">
		<select name="searchType" id="searchType" style="height: 30px;">
			<option value="">통계선택하세요</option>
			<option value="credit">학생 학점 통계</option>
		</select>
	</form>
	
	<div id="chart_container"></div>
	<div id="table_container" style="margin: 40px 0 0 0;"></div>

</div>
</div>

<script type="text/javascript">
   $(document).ready(function(){
	   
	   $("select#searchType").change(function(e){
		   func_choice($(this).val());
		   // $(this).val() 은  "" 또는 "deptname" 또는 "gender" 또는 "genderHireYear" 또는 "deptnameGender" 이다. 
	   });
	   
	   // 문서가 로드 되어지면 "부서별 인원통계" 페이지가 보이도록 한다.
	   $("select#searchType").val("deptname").trigger("change"); 
	   
   });// end of $(document).ready(funciton(){})-------------
   
   
   // Function Declaration
   function func_choice(searchTypeVal) {
	   
	   	switch (searchTypeVal) {
			case "":  // 통계선택하세요 를 선택한 경우 
			    $("div#chart_container").empty();
			    $("div#table_container").empty();
			    $("div.highcharts-data-table").empty();
			    
				break;
					
			case "credit": // 학생 학점 통계 를 선택한 경우 
				
				$.ajax({
			    	url:"<%= ctxPath%>/student/chart/credit.lms",
			    	dataType:"json",
			    	success:function(json){
			    	 	console.log(JSON.stringify(json)); 
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
			    		
			    		let deptnameArr = []; // 부서명별 인원수 퍼센티지 객체 배열 
			    		
			    		$.each(json, function(index, item){
			    			deptnameArr.push({name: item.department_name,
	    	                                  y: Number(item.percentage),
	    	                                  drilldown: item.department_name});
			    			
			    		});// end of $.each(json, function(index, item){})-------
			    		
			    		
			    		let genderArr = []; // 특정 부서명에 근무하는 직원들의 성별 인원수 퍼센티지 객체 배열 
			    		
			    		$.each(json, function(index, item){
			    			$.ajax({
				    			url:"<%= ctxPath%>/emp/chart/genderCntSpecialDeptname.action",
				    			data:{"deptname":item.department_name},
				    			dataType:"json",
				    			success:function(json2){
				    				console.log(JSON.stringify(json2)); 
				    				/*
				    				  [
				    				   {"gender":"남","cnt":"19","percentage":"17.12"}
				    				  ,{"gender":"여","cnt":"15","percentage":"13.51"}
				    				  ]
				    				*/
				    				
				    				let subArr = [];
				    				
				    				$.each(json2, function(index2, item2){
				    					
				    					subArr.push([item2.gender,
				    						         Number(item2.percentage)]);
				    					
				    				});// end of $.each(json2, function(index, item){})-----------
				    				
				    				genderArr.push({
				    	                             name: item.department_name,
				    	                             id: item.department_name,
								    	             data: subArr
				    	            });
				    				
				    			},
				    			error: function(request, status, error){
								   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
								}
				    		});	
			    		});// end of $.each(json, function(index, item){})----------
			    		
			    		
						///////////////////////////////////////////////
				    	Highcharts.chart('chart_container', {
				    	    chart: {
				    	        type: 'column'
				    	    },
				    	    title: {
				    	        align: 'left',
				    	        text: '부서별 남녀비율'
				    	    },
				    	    subtitle: {
				    	        align: 'left',
				    	        text: 'Click the columns to view versions. Source: <a href="http://localhost:9090/board/emp/empList.action" target="_blank">HR.employees</a>' 
				    	    },
				    	    accessibility: {
				    	        announceNewData: {
				    	            enabled: true
				    	        }
				    	    },
				    	    xAxis: {
				    	        type: 'category'
				    	    },
				    	    yAxis: {
				    	        title: {
				    	            text: '구성비율(%)'
				    	        }
	
				    	    },
				    	    legend: {
				    	        enabled: false
				    	    },
				    	    plotOptions: {
				    	        series: {
				    	            borderWidth: 0,
				    	            dataLabels: {
				    	                enabled: true,
				    	                format: '{point.y:.2f}%'
				    	            }
				    	        }
				    	    },
	
				    	    tooltip: {
				    	        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				    	        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
				    	    },
	
				    	    series: [
				    	        {
				    	            name: "부서명",
				    	            colorByPoint: true,
				    	            data: deptnameArr // *** 위에서 구한 값을 대입시킴. 부서명별 인원수 퍼센티지 객체 배열 *** //   
				    	        }
				    	    ],
				    	    drilldown: {
				    	        breadcrumbs: {
				    	            position: {
				    	                align: 'right'
				    	            }
				    	        },
				    	        series: genderArr  // *** 위에서 구한 값을 대입시킴. 특정 부서명에 근무하는 직원들의 성별 인원수 퍼센티지 객체 배열 *** // 
				    	    }
				    	});			
			    		///////////////////////////////////////////////
			    		
				
			    	  },
			    	  
			        error: function(request, status, error){
						   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
				});
				
				break;
					
				
		}// end of switch (searchTypeVal)----------------
	   
   }// end of function func_choice(searchTypeVal){}----------------
   
</script>










 
    