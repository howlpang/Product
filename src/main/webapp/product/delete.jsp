<%@page import="dao.ProductDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL - localhost/app3/product/delete.jsp?no=xxx
	
	// 요청파라미터값 조회
	int no = Integer.parseInt(request.getParameter("no"));

	// 업무로직 수행 - 요청파라미터로 전달받은 상품번호에 해당하는 상품정보를 삭제하기
	ProductDao dao = new ProductDao();
	dao.deleteProductByNo(no);
	
	// 재요청 URL 응답보내기
	response.sendRedirect("list.jsp");
%>