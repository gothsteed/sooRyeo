<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/4.3.1/gridstack.min.css" rel="stylesheet"/>
<link href="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack.min.css" rel="stylesheet"/>

 <style data-styles="">ion-icon{visibility:hidden}.hydrated{visibility:inherit}</style>
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">


 <link rel="stylesheet" href="<%=ctxPath %>/resources/node_modules/gridstack/dist/demo.css">

<script type="module" src="<%=ctxPath %>/resources/node_modules/gridstack/dist/ionicons.esm.js"></script>
<script nomodule="" src="<%=ctxPath %>/resources/node_modules/gridstack/dist/ionicons.js"></script>


<style type="text/css">
  .grid-stack { background: #E0E0E0; }
  .grid-stack-item-content { 
    background-color: white; 
    display: flex;
    flex-direction: column;
    border-radius: 10px;
  }
  
  
</style>


<body style="gridstack">
  <h1>교수 대시보드</h1>
  <div class="row"> 
    <div class="col-sm-12 col-md-12">
      <div class="grid-stack gs-12 gs-id-0 ui-droppable ui-droppable-over grid-stack-animate" gs-current-row="7" style="height: 720px;">
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="0" gs-w="4" gs-h="3" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>
	            <h4>날씨</h4>
            </div>
            <p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
          </div>
        </div>
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="6" gs-y="0" gs-w="4" gs-h="3" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>
            	<h4>시간표</h4>
            </div>
            <p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
          </div>
        </div>
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="4" gs-w="8" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>                       
            	<h4>수려대학교 일정</h4>
            </div>
            <p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
          </div>
        </div>
        <div class="grid-stack-item ui-draggable-disabled ui-resizable-disabled" gs-x="2" gs-y="8" gs-w="8" gs-h="4" gs-no-resize="true">
          <div class="grid-stack-item-content">
            <div class="card-text d-flex justify-content-start" style="margin-top: 10px; margin-bottom: 0;">
	           	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="mr-1 ml-1 mt-2" style="width: 25px; height: 15px;">
	            <path d="M337.8 5.4C327-1.8 313-1.8 302.2 5.4L166.3 96H48C21.5 96 0 117.5 0 144V464c0 26.5 21.5 48 48 48H256V416c0-35.3 28.7-64 64-64s64 28.7 64 64v96H592c26.5 0 48-21.5 48-48V144c0-26.5-21.5-48-48-48H473.7L337.8 5.4zM96 192h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V208c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V208zM96 320h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H96c-8.8 0-16-7.2-16-16V336c0-8.8 7.2-16 16-16zm400 16c0-8.8 7.2-16 16-16h32c8.8 0 16 7.2 16 16v64c0 8.8-7.2 16-16 16H512c-8.8 0-16-7.2-16-16V336zM232 176a88 88 0 1 1 176 0 88 88 0 1 1 -176 0zm88-48c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H336V144c0-8.8-7.2-16-16-16z"/>
	            </svg>                        
            	<h4>수려대학교 공지사항</h4>
            </div>
            <p class="card-text" style="margin-bottom: 0">...but don't resize me!</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- support for IE -->
  <script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-poly.js"></script>
  <script src="<%=ctxPath %>/resources/node_modules/gridstack/dist/gridstack-all.js"></script>
  <script type="text/javascript">
    let grid = GridStack.init({
      cellHeight: 120,
      acceptWidgets: true,
    });

    GridStack.setupDragIn('.newWidget', { appendTo: 'body', helper: 'clone' });

    grid.on('added removed change', function(e, items) {
      let str = '';
      items.forEach(function(item) { str += ' (x,y)=' + item.x + ',' + item.y; });
      console.log(e.type + ' ' + items.length + ' items:' + str );
    });
  </script>
</body>
