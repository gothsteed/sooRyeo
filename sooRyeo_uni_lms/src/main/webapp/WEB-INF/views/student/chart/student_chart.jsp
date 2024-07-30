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

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/series-label.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/drilldown.js"></script>

<script type="text/javascript">
   $(document).ready(function(){
	   
	   $("select#searchType").change(function(e){
		   func_choice($(this).val());
		   // $(this).val() 은  "" 또는 "deptname" 또는 "gender" 또는 "genderHireYear" 또는 "deptnameGender" 이다. 
	   });
	   
	   // 문서가 로드 되어지면 "부서별 인원통계" 페이지가 보이도록 한다.
	   $("select#searchType").val("credit").trigger("change"); 
	   
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
				        var data = json[0];

				        var totalCredit = parseInt(data.total_Liberal_credit) + 
				                          parseInt(data.total_Required_credit) + 
				                          parseInt(data.total_Unrequired_credit);

				        Highcharts.chart('chart_container', {
				            chart: {
				                type: 'column'
				            },
				            title: {
				                text: '학생 학점 통계',
				                align: 'left'
				            },
				            xAxis: {
				                categories: ['교양', '전공필수', '전공선택', '총학점']
				            },
				            yAxis: {
				                min: 0,
				                title: {
				                    text: '학점'
				                },
				                stackLabels: {
				                    enabled: true,
				                    style: {
				                        fontWeight: 'bold',
				                        color: 'gray',
				                        textOutline: 'none'
				                    }
				                }
				            },
				            legend: {
				                align: 'left',
				                x: 70,
				                verticalAlign: 'top',
				                y: 70,
				                floating: true,
				                backgroundColor: 'white',
				                borderColor: '#CCC',
				                borderWidth: 1,
				                shadow: false
				            },
				            tooltip: {
				                headerFormat: '<b>{point.x}</b><br/>',
				                pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
				            },
				            plotOptions: {
				                column: {
				                    stacking: 'normal',
				                    dataLabels: {
				                        enabled: true
				                    }
				                }
				            },
				            series: [{
				                name: '교양',
				                data: [parseInt(data.total_Liberal_credit), 0, 0, parseInt(data.total_Liberal_credit)]
				            }, {
				                name: '전공필수',
				                data: [0, parseInt(data.total_Required_credit), 0, parseInt(data.total_Required_credit)]
				            }, {
				                name: '전공선택',
				                data: [0, 0, parseInt(data.total_Unrequired_credit), parseInt(data.total_Unrequired_credit)]
				            }]
				        });
				    },
				    error: function(request, status, error){
				        console.log("Error: " + error);
				    }   
				});
					
				
		}// end of switch (searchTypeVal)----------------
	   
   }// end of function func_choice(searchTypeVal){}----------------
   
</script>










 
    