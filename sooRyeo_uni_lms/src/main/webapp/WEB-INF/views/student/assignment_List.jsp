<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<script type="text/javascript">

</script>  




<table class="table" style="width: 80%; margin: 3% auto;">
  <thead>
    <tr class="row table-success">
      <th scope="col" class="col-2">글번호</th>
      <th scope="col" class="col-4">과제 제목</th>
      <th scope="col" class="col-2" style="text-align: center">수업명</th>
      <th scope="col" class="col-2" style="text-align: center">교수명</th>
      <th scope="col" class="col-2" style="text-align: center">과제제출시간</th>
    </tr>
  </thead>
  <tbody>
    <tr class="row">
    
    <c:forEach var="mapList" items="${requestScope.mapList}" varStatus="status">
	    <c:if test="${mapList.assignment_submit_seq == null}">
		      <th scope="row" class="col-2">&nbsp;&nbsp;&nbsp;${status.count}</th>
		      <td class="col-4">${mapList.title}</td>
		      <td class="col-2" style="text-align: center">${mapList.className}</td>
		      <td class="col-2" style="text-align: center">${mapList.professorName}</td>
		      <td class="col-2" style="text-align: center">${mapList.end_datetime}</td>
		</c:if>
    </c:forEach>
        
    </tr>
  </tbody>
</table>







