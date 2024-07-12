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
</style>


<script type="text/javascript">
</script>


<div style="display: flex; width: 90%; margin: 0 auto;">
	<div style="width : 80%; height: 800pt; border: solid 1px red;">
		<div style="width : 90%; height: 500pt; margin: 5% auto; border: solid 1px green;">
			동영상	
		</div>
		<div style="width : 90%; border: solid 1px black; margin: 0 auto; justify-content: space-between; display: flex;">
		<button>이전버튼</button>
		<button>다음버튼</button>
		</div>
	
	</div>
	<div style="width : 20%; height: 800pt; border: solid 1px blue;">
	
	</div>
</div>
