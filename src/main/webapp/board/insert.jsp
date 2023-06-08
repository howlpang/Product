<%@page import="dao.BoardDao"%>
<%@page import="vo.Customer"%>
<%@page import="vo.Board"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
   //요청 파라미터값 조회
   String title = request.getParameter("title");
   String content = request.getParameter("content");
   //세션에 속성으로 저장된 로그인한 고객의 아이디 조회하기
   String loginId = (String) session.getAttribute("loginId");
   
   Board board = new Board();
   board.setTitle(title);
   board.setContent(content);
   board.setCustomer(new Customer(loginId));
   if(loginId == null){
      response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("게시글작성", "utf-8"));
      return;
   }
   
   BoardDao boardDao = new BoardDao();
   boardDao.insertBoard(board);
   
   response.sendRedirect("list.jsp");
%>