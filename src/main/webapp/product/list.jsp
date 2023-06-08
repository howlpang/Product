<%@page import="dto.Pagination"%>
<%@page import="util.StringUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL-http://localhost/app4/product/list.jsp
	// 요청 URL-http://localhost/app4/product/list.jsp?page=3
	int pageNo = StringUtils.stringToInt(request.getParameter("page"), 1);
	
	ProductDao productDao = new ProductDao();
	// 전체 데이터 갯수 조회하기
	int totalRows = productDao.getTotalRows();
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	//데이터 조회하기
	List<Product> productList = productDao.getProducts(pagination.getBegin(), pagination.getEnd());
	
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
			<h1 class="border bg-light fs-4 p-2">전체 상품 리스트</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>전체 상품 목록을 확인하세요.</p>
			<table class="table table-sm">
				<colgroup>
					<col width="10%">
					<col width="30%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>상품명</th>
						<th>제조사</th>
						<th>가격</th>
						<th>할인가격</th>
					</tr>
				</thead>
				<tbody>
<%
	for (Product product : productList) {
%>
					<tr>
						<td><%=product.getNo() %></td>
						<td><a href="detail.jsp?no=<%=product.getNo() %>" class="text-black text-decoration-none"><%=product.getName() %></a></td>
						<td><%=product.getMaker() %></td>
						<td><%=product.getPrice() %> 원</td>
						<td><%=product.getDiscountPrice() %> 원</td>
					</tr>
<%
	}
%>
				</tbody>
			</table>
			
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item <%=pageNo <= 1 ? "disabled" : ""%>">
						<a href="list.jsp?page=<%=pageNo - 1 %>" class="page-link">이전</a>
					</li>
<%
	for(int num = pagination.getBeginPage(); num<=pagination.getEndPage(); num++){
%>					
					
					<li class="page-item <%=pageNo == num ? "active" : ""%>">
						<a href="list.jsp?page=<%=num %>"class="page-link"><%=num %></a>
					</li>
<%
	}
%>					
				
					
					<li class="page-item <%=pageNo >= pagination.getTotalPages() ? "disabled" : "" %>">
						<a href="list.jsp?page=<%=pageNo + 1 %>"class="page-link">다음</a>
					</li>
				</ul>
			</nav>
			
			<div class="text-end">
				<a href="form.jsp" class="btn btn-primary btn-sm">새 상품 등록</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>