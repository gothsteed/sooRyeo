<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>      
    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Styled Sidebar</title>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- DataPicker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />



<script type="text/javascript">

$(document).ready(function(){
	
	
});

</script>
    
</head>   



<div class="container">
  <div class="card mb-3" style="max-width: 700px;">
	  <div class="row g-0">
	    <div class="col-md-4">
	      <img src="<%=ctxPath%>/resources/images/koala.png" class="img-fluid rounded-start" style="margin-left: 7%; margin-top: 25%;" />
	    </div>
	    
	    <div class="col-md-8">
	    
	      <div class="card-body">
	        
	        <form class="row g-3">
			  <div class="col-md-6">
			    <input type="email" class="form-control" id="inputEmail4" placeholder="성">
			  </div>
			  <div class="col-md-6">
			    <input type="password" class="form-control" id="inputPassword4" placeholder="이름">
			  </div>
			  <div class="col-12">
			    <label for="inputAddress" class="form-label">Address</label>
			    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
			  </div>
			  <div class="col-12">
			    <label for="inputAddress2" class="form-label">Address 2</label>
			    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
			  </div>
			  <div class="col-md-6">
			    <label for="inputCity" class="form-label">City</label>
			    <input type="text" class="form-control" id="inputCity">
			  </div>
			  <div class="col-md-4">
			    <label for="inputState" class="form-label">State</label>
			    <select id="inputState" class="form-select">
			      <option selected>Choose...</option>
			      <option>...</option>
			    </select>
			  </div>
			  <div class="col-md-2">
			    <label for="inputZip" class="form-label">Zip</label>
			    <input type="text" class="form-control" id="inputZip">
			  </div>
			  <div class="col-12">
			    <div class="form-check">
			      <input class="form-check-input" type="checkbox" id="gridCheck">
			      <label class="form-check-label" for="gridCheck">
			        Check me out
			      </label>
			    </div>
			  </div>
			  <div class="col-12">
			    <button type="submit" class="btn btn-primary">Sign in</button>
			  </div>
			</form>
	        
	        
	        
	      	</div>
	    	</div>
	  	</div>
	</div>
</div>
	
       
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
