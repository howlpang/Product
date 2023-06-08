<%@page import="dao.BoardDao"%>
<%@page import="vo.Board"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Comment"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	BoardDao boardDao = new BoardDao();
	// 로그인 정보 조회
	String loginId = (String) session.getAttribute("loginId");

	//요청파라미터 조회
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	// 댓글정보 조회
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.getCommentByNo(commentNo);
	//댓글작성자의 아이디와 로그인 아이디가 일치하지 않으면 detail.jsp를 재요청 URL로 보낸다.
	if (!comment.getCustomer().getId().equals(loginId)) {
		response.sendRedirect("detail.jsp?no=" + boardNo + "&err=id&job=" + URLEncoder.encode("댓글삭제","utf-8"));
	}
	//CommentDao의 deleteCommentByNo(commentNo)를 호출해서 댓글을 삭제한다.
	commentDao.deleteCommentByNo(commentNo);
	//요청파라미터로 전달받은 게시글번호로 게시글 단순정보를 조회한다.
	Board board = boardDao.getBoardByNo(boardNo);
	// 게시글 단순정보의 댓글 갯수를 1감소시킨다.
	board.setCommentCnt(board.getCommentCnt() - 1);
	//댓글 갯수가 변경된 게시글 정보를 데이터베이스에 반영시킨다.
	boardDao.updateBoard(board);
	 //detail.jsp를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("detail.jsp?no="+boardNo);


%>