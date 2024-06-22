<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>SooRyeo Univ.</title>

    
<style type="text/css">
body { padding: 0px; margin: 0px; }
.jb-box { width: 100%; height: 1000px; overflow: hidden; margin: 0px auto; position: relative; }
 video { width: 100%; opacity: 90%;}
.jb-text { position: absolute; top: 20%; width: 100%; }
.jb-text p { margin-top: -24px; text-align: center; font-size: 80px; color: #ffffff; }
</style>	


</head>

<body>
  <div class="jb-box">
    <video muted autoplay loop>
      <source src="resources/video/campus.mp4" type="video/mp4">
      <strong>Your browser does not support the video tag.</strong>
    </video>
    <div class="jb-text">
      <p>Welcome to SooRyeo Univ.</p>
    </div>
  </div>




</body>
</html>
