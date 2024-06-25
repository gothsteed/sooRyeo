<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/4.3.1/gridstack.min.css" rel="stylesheet"/>
<link href="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack.min.css" rel="stylesheet"/>


    <div class="grid-stack">
        <div class="grid-stack-item" data-gs-width="4" data-gs-height="2">
            <div class="grid-stack-item-content">담당 수업</div> 
        </div>
        <div class="grid-stack-item" data-gs-width="4" data-gs-height="2">
            <div class="grid-stack-item-content">과제제출현황</div>
        </div>
        <div class="grid-stack-item" data-gs-width="4" data-gs-height="2">
            <div class="grid-stack-item-content">공지사항</div>
        </div>
        <div class="grid-stack-item" data-gs-width="4" data-gs-height="2">
            <div class="grid-stack-item-content">학사일정</div>
        </div>
    </div>


<script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
<script type="text/javascript">
    var grid = GridStack.init();
</script>

