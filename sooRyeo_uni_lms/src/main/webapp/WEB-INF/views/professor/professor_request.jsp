<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	#top_container {
		border: solid 1px black;
	}
	
	#left_top, #right_top {
		border: solid 0px orange;
	}


</style>

<div class="container">
	<div class="row" id="top_container">
		<div class="card col-sm-5">
	  		<div class="card-header">
		  		<div class="col-sm-2">교과목 조회</div>
				<div class="col-sm-4">
					<select class="form-select" aria-label="Default select example">
			  			<option selected>단과선택</option>
			  			<option value="1">인문대학</option>
			  			<option value="2">공학대학</option>
			  			<option value="3">스마트융합대학</option>
					</select>
				</div>
				<div class="col-sm-4" id="right_top">
					<select class="form-select" aria-label="Default select example">
			  			<option selected>학과선택</option>
			  			<option value="1">국어국문학과</option>
			  			<option value="2">영어영문학과</option>
			  			<option value="3">중국어중문학과</option>
					</select>
				</div>
	  		</div>
	  		<div class="card-body">
	    		<h5 class="card-title">Special title treatment</h5>
	    		<p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
	    		<a href="#" class="btn btn-primary">Go somewhere</a>
	  		</div>
		</div>
		
		<div class="card">
	  		<h5 class="card-header">Featured</h5>
	  		<div class="card-body">
	    		<h5 class="card-title">Special title treatment</h5>
	    		<p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
	    		<a href="#" class="btn btn-primary">Go somewhere</a>
	  		</div>
		</div>	
	
	</div>
	
	<div class="card">
  		<h5 class="card-header">Featured</h5>
  		<div class="card-body">
    		<h5 class="card-title">Special title treatment</h5>
    		<p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
    		<a href="#" class="btn btn-primary">Go somewhere</a>
  		</div>
	</div>

</div>    
    