<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<% String ctxPath = request.getContextPath(); %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University Certification Menu</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .certificate-option {
            transition: transform 0.3s ease-in-out;
        }
        .certificate-option:hover {
            transform: scale(1.05);
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
    </style>
    
<script type="text/javascript">

	function goGrade(){
	
		const frm = document.generateCertificate;
		frm.method = "post";
		frm.action = "<%= ctxPath %>/certificate/grade.lms";
		frm.submit(); 
		
	 
	}


</script>

</head>
<body>
<div class="container py-5">
    <h1 class="text-center mb-5" style="font-weight: bolder">증명서 출력</h1>
    <div class="row justify-content-center">
        <div class="col-md-4 mb-4 certificate-option">
            <div class="card h-100 shadow">
                <div class="card-body d-flex flex-column justify-content-between text-center">
                    <div>
                        <i class="fas fa-award card-icon text-primary"></i>
                        <h5 class="card-title">성적증명서</h5>
                    </div>
                    <form action="generateCertificate" method="post" class="mt-3">
                        <input type="hidden" name="certificateType" value="Achievement">
                        <button type="submit" class="btn btn-primary w-100" onclick="goGrade()">바로가기</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4 certificate-option">
            <div class="card h-100 shadow">
                <div class="card-body d-flex flex-column justify-content-between text-center">
                    <div>
                        <i class="fas fa-users card-icon text-success"></i>
                        <h5 class="card-title">재학 증명서</h5>
                    </div>
                    <form action="generateCertificate" method="post" class="mt-3">
                        <input type="hidden" name="certificateType" value="Participation">
                        <button type="submit" class="btn btn-success w-100">바로가기</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4 certificate-option">
            <div class="card h-100 shadow">
                <div class="card-body d-flex flex-column justify-content-between text-center">
                    <div>
                        <i class="fas fa-trophy card-icon text-danger"></i>
                        <h5 class="card-title">졸업 증명서</h5>
                    </div>
                    <form action="generateCertificate" method="post" class="mt-3">
                        <input type="hidden" name="certificateType" value="Excellence">
                        <button type="submit" class="btn btn-danger w-100">바로가기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (optional, for certain interactive components) -->
</body>
</html>