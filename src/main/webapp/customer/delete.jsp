<%@page import="vo.Customer"%>
<%@page import="dao.CustomerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL - http://localhost/app3/customer/delete.jsp?id=xxx
	
	// 요청 파라미터 조회
	String id = request.getParameter("id");

	// 요청 파라미터로 전달받은 고객아이디에 해당하는 고객정보를 삭제한다.
	CustomerDao customerDao = new CustomerDao();
	
	Customer customer = customerDao.getCustomerById(id);
	if ("No".equals(customer.getDisabled())) {	// 사용중인 고객인지 체크
		response.sendRedirect("detail.jsp?id="+id+"&err=fail");
		return;
	}
	
	customerDao.deleteCustomerById(id);
	
	response.sendRedirect("list.jsp");	
%>