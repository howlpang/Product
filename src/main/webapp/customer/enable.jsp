<%@page import="vo.Customer"%>
<%@page import="dao.CustomerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String id = request.getParameter("id");

	CustomerDao customerDao = new CustomerDao();
	
	Customer customer = customerDao.getCustomerById(id);
	customer.setDisabled("No");
	
	customerDao.updateCustomer(customer);
	
	response.sendRedirect("list.jsp");
%>