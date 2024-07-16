<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>

<%-- Bootstrap CSS --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<%-- jQueryUI CSS 및 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<title>SooRyeo Univ.</title>


<style>


  

li.list-group-item {
	height: 100px;
}

video {
  margin-top: 20px;
  margin-left: 20px;
  z-index: 150
}

</style>


<script type="text/javascript">

</script>

<div>

	
		
      <div style="display: flex; width: 90%; height: 525pt; margin: 2% auto;">
         <div class="shadow p-3 mb-5 bg-body rounded" style="width : 80%; height: 520pt; background-color: white;">
         
            <div style="height: 50px; margin-left: 7%; margin-top: 3%; font-size: 20pt;">${classOne.lecture_title}</div>
            
            <video src="${pageContext.request.contextPath}/resources/lectures/${classOne.video_file_name}" controls width="1060" height="530"></video>
			
         </div>
         <div class="shadow ml-5 mb-5 bg-body rounded" style="width : 20%; height: 520pt; padding: 2%; background-color: white;">
            ${classOne.lecture_content}
         </div>
         
      </div>
		
	
</div>