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
      <th scope="row" class="col-2">&nbsp;&nbsp;&nbsp;1</th>
      <td class="col-4">시 한편 써보기</td>
      <td class="col-2" style="text-align: center">국어학개론</td>
      <td class="col-2" style="text-align: center">홍길동</td>
      <td class="col-2" style="text-align: center">07-05 ~ 07-15</td>
    </tr>
    <tr class="row">
      <th scope="row" class="col-2">&nbsp;&nbsp;&nbsp;2</th>
      <td class="col-4">시 한편 써보기</td>
      <td class="col-2" style="text-align: center">국어학개론</td>
      <td class="col-2" style="text-align: center">홍길동</td>
      <td class="col-2" style="text-align: center">07-05 ~ 07-15</td>
    </tr>


  </tbody>
</table>