<%@page import="vo.Customer"%>
<%@page import="dao.CustomerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL - http://localhost/app3/customer/detail.jsp?id=xxx
	// 요청 URL - http://localhost/app3/customer/detail.jsp?id=xxx&err=fail
	// 요청파라미터 값 조회
	String id = request.getParameter("id");
	String err = request.getParameter("err");

	// 요청파라미터로 전달받은 고객아이디로 고객 상세정보 조회하기
	CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.getCustomerById(id);
%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name= "menu" value="고객"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">고객 상세 정보</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>고객의 상세정보를 확인하세요.</p>

<%
	if ("fail".equals(err)) {
%>
			<div class="alert alert-danger">
				<strong>삭제 실패</strong> 사용중인 고객은 삭제할 수 없습니다.
			</div>
<%
	}
%>			
			
			
			<table class="table table-bordered">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th class="table-dark">아이디</th>
						<td><%=customer.getId() %></td>
						<th class="table-dark">이름</th>
						<td><%=customer.getName() %></td>
					</tr>
					<tr>
						<th class="table-dark">전화번호</th>
						<td><%=customer.getTel() %></td>
						<th class="table-dark">이메일</th>
						<td><%=customer.getEmail() %></td>
					</tr>
					<tr>
						<th class="table-dark">적립포인트</th>
						<td><%=customer.getPoint() %></td>
						<th class="table-dark">탈퇴여부</th>
						<td>
<% 
	if ("No".equals(customer.getDisabled())) {
%>
							<span class="badge text-bg-primary">사용중</span>
<%	
	} else if ("Yes".equals(customer.getDisabled())) {
%>
							<span class="badge text-bg-secondary">탈퇴</span>
<%	
	}
%>
						</td>
					</tr>
					<tr>
						<th class="table-dark">가입일자</th>
						<td><%=customer.getCreateDate() %></td>
						<th class="table-dark">수정일자</th>
						<td><%=customer.getUpdateDate() %></td>
					</tr>
				</tbody>
			</table>
			<div class="text-end">
<%
	if ("Yes".equals(customer.getDisabled())) {
%>
				<a href="delete.jsp?id=<%=customer.getId() %>" class="btn btn-danger btn-sm">삭제</a>
<%
	}
%>
				<a href="modifyform.jsp?id=<%=customer.getId() %>" class="btn btn-warning btn-sm">수정</a>
				<a href="list.jsp" class="btn btn-primary btn-sm">목록</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>