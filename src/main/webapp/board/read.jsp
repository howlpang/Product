<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("no"));
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(boardNo);
	board.setReadCnt(board.getReadCnt()+1);
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no=" +boardNo);
%>