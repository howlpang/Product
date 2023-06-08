<%@page import="vo.Customer"%>
<%@page import="vo.Board"%>
<%@page import="vo.Comment"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dao.CommentDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
//요청 파라미터값 조회
	String loginId = (String) session.getAttribute("loginId");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String content = request.getParameter("content");

	
	// 세션에 속성으로 저장된 로그인한 고객의 아이디 조회하기
	if(loginId == null){
		response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("리뷰작성", "utf-8"));
		return;
	}
	Comment comment = new Comment();
	comment.setContent(content);
	comment.setBoard(new Board(boardNo));
	comment.setCustomer(new Customer(loginId));
	
	//Review객체에 저장된 리뷰정보를 테이블에 저장시킨다.
	CommentDao commentDao = new CommentDao();
	commentDao.insertComment(comment);
	// detail.jsp를 재요청하는 URL 응답
	response.sendRedirect("detail.jsp?no=" + boardNo);
%>