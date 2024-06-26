<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


<style type="text/css">

</style>

<script type="text/javascript">

</script>



<div class="container">
  <div class="card mb-3 shadow p-3 mb-5 bg-body-tertiary rounded" style="max-width: 1000px;">
	  <div class="myInfo row g-0 ">
	      <div class="card-body">
	        
			<form name="myInfo">
		
				<div class="col-md-4 d-flex" style="text-align: center;">
		      		<img src="<%=ctxPath%>/resources/images/koala.png" class="img-fluid rounded-start" style="width:40%;" />
		      		<input class="form-control" type="file" id="formFile">
	    		</div>
	    	
			
					<div class="col-3 mb-4">
						<label for="name" class="form-label">성명</label>
					  	<input type="text" class="form-control" id="name" placeholder="코알라" readonly>
					</div>
					<div class="col-md-3 mb-4">
						<label for="department" class="form-label">학과</label>
					  	<input type="text" class="form-control" id="department" placeholder="컴퓨터공학과" readonly>
					</div>
					<div class="col-2 mb-4">
						<label for="grade" class="form-label">학년</label>
				  		<input type="text" class="form-control" id="grade" placeholder="3학년" readonly>
					</div>
		
				
				
				
					<div class="col-md-5 mb-4">
					  	<label for="address" class="form-label">주소</label>
					  	<input type="text" class="form-control" id="address" placeholder="서울시 마포구 집으로 82길 7" readonly>
					</div>
					<div class="col-md-5 mb-4">
					  	<label for="email" class="form-label">이메일</label>
					  	<input type="text" class="form-control" id="email" placeholder="ComeBackHome@naver.com" readonly>
					</div>
			
					
			
					<div class="col-md-2">
					  	<label for="birthday" class="form-label">생년월일</label>
					  	<input type="text" class="form-control" id="birthday" placeholder="97-02-13" readonly>
					</div>
					<div class="col-md-3">
					  	<label for="phone" class="form-label">전화번호</label>
					  	<input type="text" class="form-control" id="phone" placeholder="010-1234-5678" readonly>
					</div>
					<div class="col-md-2">
					  	<label for="graduate" class="form-label">학적상태</label>
					  	<input type="text" class="form-control" id="graduate" placeholder="재학" readonly>
					</div>
					<div class="">
					  	<button type="submit" class="btn btn-success">정보 수정</button>
					</div>
			
					
					
				
				</form>
			</div>
	  	</div>
	</div>
</div>


