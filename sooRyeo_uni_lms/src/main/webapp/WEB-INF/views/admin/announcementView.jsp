<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <div class="card">
        <div class="card-header" style="text-align: center; background-color: #d1e0e0">
            <h2>학사 공지사항</h2>
        </div>
        <div class="card-body">
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" style="width:10%;">제목</th>
			      <th scope="col">${requestScope.an.a_title}</th>
			    </tr>
			  </thead>
			  <tbody class="table-group-divider">
			    <tr>
			      <th scope="row">날짜</th>
			      <td>${requestScope.an.writeday}</td>
			    </tr>
			    <tr>
			      <th scope="row" >내용</th>
			      <td>${requestScope.an.a_content}</td>
			    </tr>
			    <tr>
			      <th scope="row">첨부파일</th>
			      <c:if test="${requestScope.an.attatched_file != null}">
				      <td colspan="2">${requestScope.an.attatched_file}</td>
			      </c:if>
			      <c:if test="${requestScope.an.attatched_file == null}">
				      <td colspan="2">첨부파일이 없습니다.</td>
			      </c:if>
			    </tr>
			  </tbody>
			</table>
			<div style="display: flex; justify-content: space-between; width: 100%;">
                <button type="button" class="btn btn-secondary">이전글</button>
                <div>
	                <button type="button" class="btn btn-secondary">전체목록보기</button>
	                <button type="button" class="btn btn-secondary">검색목록보기</button>
                </div>
                <button type="button" class="btn btn-secondary">다음글</button>
            </div>
		</div>
	</div>
</div>