<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>


<script type="text/javascript">

$(document).ready(function(){
	

	const frm = document.searchFrm;
	frm.name.value = name;
	
	frm.method = "post";		
	frm.action = "<%=ctxPath%>/downloadExcelFile.action";
	frm.submit();
			
}); // end of $(document).ready

</script>



