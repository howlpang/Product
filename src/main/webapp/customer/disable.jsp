<%@page import="vo.Customer"%>
<%@page import="dao.CustomerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL - http://localhost/app3/customer/disabled.jsp?id=xxx
	
	// 요청파라미터값 조회
	String id = request.getParameter("id");

	// 요청파라미터로 전달받은 아이디에 해당하는 고객정보를 조회한다.
	CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.getCustomerById(id);
	// 고객정보의 disabled를 "Yes"로 변경한다.
	customer.setDisabled("Yes");
	
	// 변경된 고객정보를 테이블에 반영시킨다.
	customerDao.updateCustomer(customer);
	
	// list.jsp를 재요청하는 응답을 보낸다.
	response.sendRedirect("list.jsp");
%>