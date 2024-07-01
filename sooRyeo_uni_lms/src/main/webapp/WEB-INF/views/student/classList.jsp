<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //     /sooRyeo
%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>SooRyeo Univ.</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gothic+A1&family=IBM+Plex+Sans+KR&family=Nanum+Gothic&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR:wght@200..900&display=swap" rel="stylesheet">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<body>

<br><br><br>
<div style="width: 60%; margin: 0 auto; font-size: 26pt; color: #175F30; font-weight: bold; background-color: #D7E8CD;">&nbsp;전공 수업</div>
<table class="table table-hover" style="width: 60%; margin: 0 auto;">
  <tbody>
    <tr>
      <th scope="col" style="font-size: 18pt;">자바 기초</th>
      <td scope="col" style="text-align: right;">서영학</td>
      <td class="col-3" scope="col" style="text-align: right;">화목3</td>
    </tr>
    <tr>
      <th scope="col" style="font-size: 18pt;">자바 기초</th>
      <td scope="col" style="text-align: right;">서영학</td>
      <td class="col-3" scope="col" style="text-align: right;">화목3</td>
    </tr>
    <tr>
      <th scope="col" style="font-size: 18pt;">자바 기초</th>
      <td scope="col" style="text-align: right;">서영학</td>
      <td class="col-3" scope="col" style="text-align: right;">화목3</td>
    </tr>
  </tbody>
</table>

<br><br><br>
<div style="width: 60%; margin: auto; font-size: 26pt; color: #175F30; font-weight: bold; background-color: #D7E8CD;">&nbsp;교양 수업</div>
<table class="table table-hover" style="width: 60%; margin: 0 auto;">
  <tbody>
    <tr>
      <th scope="col" style="font-size: 18pt;">자바 기초</th>
      <td scope="col" style="text-align: right;">서영학</td>
      <td class="col-3" scope="col" style="text-align: right;">화목3</td>
      <td><img src="<%= ctxPath%>/resources/images/greenarrow.png" style="width: 50%;"/></td>
    </tr>
    <tr>
      <th scope="col" style="font-size: 18pt;">자바 기초</th>
      <td scope="col" style="text-align: right;">서영학</td>
      <td class="col-3" scope="col" style="text-align: right;">화목3</td>
    </tr>
    <tr>
      <th scope="col" style="font-size: 18pt;">자바 기초</th>
      <td scope="col" style="text-align: right;">서영학</td>
      <td class="col-3" scope="col" style="text-align: right;">화목3</td>
    </tr>
  </tbody>
</table>



</body>

