package dao;

import java.util.List;

import util.DaoHelper;
import vo.Board;
import vo.Comment;
import vo.Customer;

public class CommentDao {
	
	public void deleteCommentByNo(int commentNo) {
		DaoHelper.update("boardDao.deleteCommentByNo", commentNo);
	}
	public Comment getCommentByNo(int commentNo) {
		return DaoHelper.selectOne("boardDao.getCommentByNo", rs ->{
			Comment comment = new Comment();
			comment.setNo(rs.getInt("comment_no"));
			comment.setContent(rs.getString("comment_content"));
			comment.setCreateDate(rs.getDate("comment_create_date"));
			Customer customer = new Customer();
			customer.setId(rs.getString("cust_id"));
			comment.setCustomer(customer);
			Board board = new Board();
			board.setNo(rs.getInt("board_no"));
			comment.setBoard(board);
			
			return comment;
		}, commentNo);
	}
	
	public List<Comment> getCommentsByBoardNo(int boardNo){
		return DaoHelper.selectList("boardDao.getCommentsByBoardNo", rs -> {
			Comment comment = new Comment();
			
			comment.setNo(rs.getInt("comment_no"));
			comment.setContent(rs.getString("comment_content"));
			comment.setCreateDate(rs.getDate("comment_create_date"));
			
			Customer customer = new Customer();
			customer.setId(rs.getString("cust_id"));
			customer.setName(rs.getString("cust_name"));
			comment.setCustomer(customer);
			
			return comment;
			
		}, boardNo); 
	}

	public void insertComment(Comment comment){
		DaoHelper.update("boardDao.insertComment",comment.getContent(),comment.getCustomer().getId(),comment.getBoard().getNo());
	}
}
