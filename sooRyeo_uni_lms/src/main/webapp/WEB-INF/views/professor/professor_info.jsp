<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

</style>

<script type="text/javascript">

</script>


<span>이름</span><input id='prof_name' type='text' value='${requestScope.professor.name}' readonly/>
<br>
<span>비밀번호</span><input id='prof_pwd' type='text' value='${requestScope.professor.pwd}'/><button>비밀번호수정</button>
<br>
<span>전화번호</span><input id='prof_tel' type='text' value='${requestScope.professor.tel}'/><button>전화번호수정</button>
<br>
<span>이메일</span><input id='prof_email' type='text' value='${requestScope.professor.email}'/><button>이메일수정</button>
<br>
<span>연구실 주소</span><input id='prof_office' type='text' value='${requestScope.professor.office_address}'/><button>주소변경</button>

