<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- DataPicker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script>



<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/4.3.1/gridstack.min.css" rel="stylesheet" />
<link href="<%=ctxPath%>/resources/node_modules/gridstack/dist/gridstack.min.css" rel="stylesheet" />


<style type="text/css">
</style>


<script type="text/javascript">
	
</script>


<div class="main-content w-100 h-100">
    <div class="grid-stack">
        <!-- Calendar Widget -->
        <div class="grid-stack-item" data-gs-width="4" data-gs-height="6" data-gs-x="0" data-gs-y="0">
            <div class="grid-stack-item-content card">
                <div class="card-body">
                    <h5 class="card-title" style="text-align: center;">캘린더</h5>
                    <div style="height: 355px; text-align: center;">
                        캘린더 넣을 예정입니다.
                    </div>
                </div>
            </div>
        </div>

        <!-- Academic Schedule Timeline Widget -->
        <div class="grid-stack-item" data-gs-width="8" data-gs-height="6" data-gs-x="4" data-gs-y="0">
            <div class="grid-stack-item-content card">
                <div class="card-body">
                    <h5 class="card-title" style="text-align: center">2024년도 08월 학사 일정</h5>
                    <hr>
                    <div class="row">
                        <div class="col-lg-7 mx-auto">
                            <!-- Timeline Content Here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Notices Tab Widget -->
        <div class="grid-stack-item" data-gs-width="12" data-gs-height="6" data-gs-x="0" data-gs-y="6">
            <div class="grid-stack-item-content">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <!-- Nav tabs content -->
                </ul>
                <div class="tab-content" id="myTabContent">
                    <!-- Tab panes content -->
                </div>
            </div>
        </div>
    </div>
</div>


<script src="<%=ctxPath%>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
<script type="text/javascript">
	var grid = GridStack.init();
</script>