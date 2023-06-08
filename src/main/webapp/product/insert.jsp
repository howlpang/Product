<%@page import="vo.Category"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청파라미터값 조회
	int catNo = Integer.parseInt(request.getParameter("catNo"));
	String name = request.getParameter("name");
	String maker = request.getParameter("maker");
	int amount = Integer.parseInt(request.getParameter("amount"));
	int price = Integer.parseInt(request.getParameter("price"));
	String description = request.getParameter("description");
	
	Product product = new Product();
	product.setName(name);
	product.setMaker(maker);
	product.setStock(amount);
	product.setPrice(price);
	product.setDiscountPrice((int) (price*0.9));
	product.setDescription(description);
	product.setCategory(new Category(catNo));
	
	
	// 업무로직 수행 - 새 상품정보를 저장시킨다.
	ProductDao dao = new ProductDao();
	dao.insertProduct(product);
	
	// 재요청URL 응답
	// 현재요청URL - http://localhost/app4/product/insert.jsp
	// 재요청 URL  - http://localhost/app4/product/list.jsp
	response.sendRedirect("list.jsp");
%>