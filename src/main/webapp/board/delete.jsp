<%@page import="dao.BoardDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Board"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	BoardDao boardDao = new BoardDao();
	String loginId = (String) session.getAttribute("loginId");
 	//detail.jsp에서 전달한 요청파라미터값(no)를 조회한다.
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
 	//boardNo로 게시글 단순 정보를 조회한다
	Board board = boardDao.getBoardByNo(boardNo);
 	//게시글작성자의 아이디와 로그인 아이디가 일치하지 않으면 detail.jsp를 재요청 URL로 보낸다.
	if (!board.getCustomer().getId().equals(loginId)) {
		response.sendRedirect("detail.jsp?no=" + boardNo + "&err=id&job="+URLEncoder.encode("게시글삭제", "utf-8"));
	}
 	//게시글정보의 deleted값을 Y로 변경한다
	board.setDeleted("Y");
 	//deleted값이 변경된 게시글 정보를 데이터베이스에 반영시킨다.
	boardDao.updateBoard(board);
 	//list.jsp를 재요청 URL로 보낸다.
	response.sendRedirect("list.jsp");
%>	