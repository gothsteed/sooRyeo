<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<script type="text/javascript">
$(document).ready(function(){
	
	$("div#mycontent").css({"background-color":"#d1e0e0"});
    // div#mycontent 는  /board/src/main/webapp/WEB-INF/tiles/layout/layout-tiles1.jsp 파일의 내용에 들어 있는 <div id="mycontent"> 이다.
	
	const url = window.location.host; // 웹브라우저의 주소창의 포트까지 가져옴
	// alert("url : " + url);
	// url : 192.168.0.189:9099
	
	const pathname = window.location.pathname; // 최초 '/' 부터 오른쪽에 있는 모든 경로
	// alert("pathname : " + pathname);
	// pathname : /board/chatting/multichat.action
	
	const appCtx = pathname.substring(0, pathname.lastIndexOf("/")); // "전체 문자열".lastIndexOf("검사할 문자");
	// alert("appCtx : " + appCtx);
	// appCtx : /board/chatting
	
	const root = url + appCtx;
	// alert("root : " + root);
	// 192.168.0.189:9099/board/chatting
	// root : 192.168.0.189:9099/board/chatting
	
	const wsUrl = "ws://"+root+"/multichatstart.action";
	// 웹소켓통신을 하기위해서는 http:// 을 사용하는 것이 아니라 ws:// 을 사용해야 한다. 
    // "/multichatstart.action" 에 대한 것은 /WEB-INF/spring/config/websocketContext.xml 파일에 있는 내용이다.
    
    const websocket = new WebSocket(wsUrl);
	// 즉, const websocket =  new WebSocket("ws://192.168.0.189:9099/board/chatting/multichatstart.action");
    
	
 	// >> ====== !!중요!! Javascript WebSocket 이벤트 정리 ====== << //
    /*   -------------------------------------
                      이벤트 종류             설명
         -------------------------------------
             onopen         WebSocket 연결
             onmessage      메시지 수신
             onerror        전송 에러 발생
             onclose        WebSocket 연결 해제
    */
    
    
    let messageObj = {}; // 자바스크립트 객체 생성함
    // === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 정의하기 === //
    websocket.onopen = function(){
 		// alert("웹소켓연결됨");
		$("div#chatStatus").text("정보: 웹소켓에 연결이 성공됨!!");
		
		{};
		
		/*   
        messageObj.message = "채팅방에 <span style='color: red;'>입장</span> 했습니다.";
        messageObj.type = "all"; // messageObj.type = "all"; 은 "1 대 다" 채팅을 뜻하는 것이고, messageObj.type = "one"; 은 "1 대 1" 채팅을 뜻하는 것으로 하겠다.  
        messageObj.to = "all";   // messageObj.to = "all"; 은 수신자는 모두를 뜻하는 것이고, messageObj.to = "eomjh"; 이라면  eomjh 인 사람과 1대1 채팅(귓속말)을 뜻하는 것으로 하겠다. 
        */
     // 또는 
	   messageObj = {message : "채팅방에 <span style='color: red;'>입장</span> 했습니다."
                       ,type : "all"
                       ,to : "all"}; // 자바스크립트에서 객체의 데이터값 초기화 
                       
       websocket.send(JSON.stringify(messageObj));
                      // JSON.stringify(자바스크립트객체) 는 자바스크립트객체를 JSON 표기법의 문자열(string)로 변환한다
                      // JSON.parse(JSON 표기법의 문자열) 는 JSON 표기법의 문자열(string)을 자바스크립트객체(object)로 변환해준다.
		/*
		  JSON.stringify({});                  // '{}'
		  JSON.stringify(true);                // 'true'
		  JSON.stringify('foo');               // '"foo"'
		  JSON.stringify([1, 'false', false]); // '[1,"false",false]'
		  JSON.stringify({ x: 5 });            // '{"x":5}'
		*/               
 	};
 	
 	// === 메시지 수신시 콜백함수 정의하기 === //
 	websocket.onmessage = function(event){
 		
 		// event.data 는 수신되어진 메시지다. 즉, 지금은 「손영관 엄정화 」 이다.
 		if(event.data.substr(0,1)=="「" && event.data.substr(event.data.length-1)=="」") {
           $("div#connectingUserList").html(event.data);
        }
        else {
           // event.data 는 수신받은 채팅 문자이다.
           $("div#chatMessage").append(event.data);
           $("div#chatMessage").append("<br>");
           $("div#chatMessage").scrollTop(99999999);
        }
 	};
 	
 	// === 웹소켓 연결 해제시 콜백함수 정의하기 === //
    websocket.onclose = function(){
    
 	}
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	
	// === 메시지 입력후 엔터하기 === //
    $("input#message").keyup(function(key){
       if(key.keyCode == 13) {
          $("input#btnSendMessage").click(); 
       }
    });
	
 // === 메시지 보내기 === //
    $("input#btnSendMessage").click(function(){
    
       if( $("input#message").val().trim() != "" ) {
          
       // ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
         // 자바스크립트에서 replaceAll 은 없다.
         // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
         // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다. 
         
            let messageVal = $("input#message").val();
            messageVal = messageVal.replace(/<script/gi, "&lt;script"); 
            // 스크립트 공격을 막으려고 한 것임.
            
            <%-- 
             messageObj = {message : messageVal
                        ,type : "all"
                        ,to : "all"}; 
            --%>
            // 또는
            messageObj = {}; // 자바스크립트 객체 생성함. 
            messageObj.message = messageVal;
            messageObj.type = "all";
            messageObj.to = "all";
          
            const to = $("input#to").val();
            if( to != "" ){
               messageObj.type = "one";
                messageObj.to = to;
            }
            
            websocket.send(JSON.stringify(messageObj));
            // JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열로 변환한다
         
            // 위에서 자신이 보낸 메시지를 웹소켓으로 보낸 다음에 자신이 보낸 메시지 내용을 웹페이지에 보여지도록 한다. 
            
            const now = new Date();
            let ampm = "오전 ";
            let hours = now.getHours();
            
            if(hours > 12) {
                 hours = hours - 12;
                 ampm = "오후 ";
            }
            
            if(hours == 0) {
                 hours = 12;
            }
            
            if(hours == 12) {
              ampm = "오후 ";
            }
            
            let minutes = now.getMinutes();
             if(minutes < 10) {
               minutes = "0"+minutes;
             }
          
            const currentTime = ampm + hours + ":" + minutes; 
            
            $("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>"); 
            
            $("div#chatMessage").scrollTop(99999999);
            
            $("input#message").val("");
            $("input#message").focus();
       }
       
    });
    
}) // end of $(document).ready(function(){})------------------------------------
</script>

<body>
<div class="container-fluid" id="mycontent" style="width:85%; border-radius: 20px;">
	<div class="row">
		<div class="col-md-10 offset-md-1">
		   <div id="chatStatus"></div>
		   <div id="connectingUserList" style=" max-height: 100px; overFlow: auto;"></div>
		   
		   <div id="chatMessage" style=" height:500px; max-height: 500px; overFlow: auto; margin: 20px 0;"></div>
		
		   <input type="text"   id="message" class="form-control" placeholder="메시지 내용"/>
		   <input type="button" id="btnSendMessage" class="btn btn-success btn-sm my-3" value="메시지보내기" />
		   <input type="button" class="btn btn-danger btn-sm my-3 mx-3" onclick="javascript:location.href='<%=request.getContextPath() %>/student/dashboard.lms'" value="채팅방나가기" />
		</div>
	</div>
</div>
</body>
</html>