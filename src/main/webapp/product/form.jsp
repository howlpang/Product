<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 모든 카테고리 목록정보 조회하기
	CategoryDao categoryDao = new CategoryDao();
	List<Category> categories = categoryDao.getCategories();
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
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name= "menu" value="상품"/>
</jsp:include>	
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">신규 상품 등록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>신규 상품 정보를 입력하세요.</p>
			
			<form class="border bg-light p-3" method="post" action="insert.jsp">
				<div class="form-group mb-2">
					<label class="form-label">카테고리</label>
					<select class="form-select" name="catNo">
<%
	for (Category cat : categories) {
%>
						<option value="<%=cat.getNo() %>"> <%=cat.getName() %></option>
<%
	}
%>
					</select>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">상품이름</label>
					<input type="text" class="form-control" name="name"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">제조회사</label>
					<input type="text" class="form-control" name="maker"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">입고수량</label>
					<input type="text" class="form-control" name="amount"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">상품가격</label>
					<input type="text" class="form-control" name="price"/>
				</div>
				<div class="form-group mb-2">
					<label class="form-label">상품 설명</label>
					<textarea class="form-control" rows="5" name="description"></textarea>
				</div>
				<div class="text-end">
					<button type="reset" class="btn btn-secondary btn-sm">취소</button>
					<button type="submit" class="btn btn-primary btn-sm">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>