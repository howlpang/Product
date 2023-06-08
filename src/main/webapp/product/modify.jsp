<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Category"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청파라미터값 조회
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	String maker = request.getParameter("maker");
	int price = Integer.parseInt(request.getParameter("price"));
	int discountPrice = Integer.parseInt(request.getParameter("discountPrice"));
	String description = request.getParameter("description");
	int catNo = Integer.parseInt(request.getParameter("catNo"));
	Category category = new Category(catNo);
	
	// 요청파라미터로 전달받은 상품번호로 데이터베이스에서 상품정보 조회
	ProductDao productDao = new ProductDao();
	Product product = productDao.getProductByNo(no);
	
	// 요청파라미터로 전달받은 수정된 상품정보를 Product객체에 저장해서 값을 덮어쓰기
	product.setName(name);
	product.setMaker(maker);
	product.setPrice(price);
	product.setDiscountPrice(discountPrice);
	product.setDescription(description);
	product.setCategory(category);
	
	// 수정된 정보가 포함된 Product객체를 전달해서 데이터베이스에 반영시키기
	productDao.updateProduct(product);
	
	// 재요청URL 응답
	response.sendRedirect("detail.jsp?no=" + no);
	
%>