<%@page import="dao.CustomerDao"%>
<%@page import="vo.Customer"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 파라미터값 조회
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	
	// Customer객체를 생성해서 요청파라미터로 제출받은 고객정보 저장
	Customer customer = new Customer();
	customer.setId(id);
	customer.setPassword(password);
	customer.setName(name);
	customer.setTel(tel);
	customer.setEmail(email);
	
	// 회원가입 업무로직 수행
	CustomerDao customerDao = new CustomerDao();
	
	// 아이디 중복체크
	if (customerDao.getCustomerById(id) != null) {	// 아이디 중복 발생
		response.sendRedirect("form.jsp?err=id");
		return;
	}
	// 이메일 중복체크
	if (customerDao.getCustomerByEmail(email) != null) {	// 이메일 중복 발생
		response.sendRedirect("form.jsp?err=email");		
		return;
	}
	
	// 회원정보 저장하기
	customerDao.insertCustomer(customer);
	
	// registered.jsp를 재요청 URL 응답
	response.sendRedirect("registered.jsp");
	
%>