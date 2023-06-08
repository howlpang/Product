package dao;

import java.util.List;

import util.DaoHelper;
import vo.Customer;
import vo.Product;
import vo.Review;

public class ReviewDao {

	public void insertReview(Review review) {
		DaoHelper.update("reviewDao.insertReview", review.getContent(), review.getProduct().getNo(), review.getCustomer().getId());
	}
	public List<Review> getReviewsByProductNo(int productNo){
		return DaoHelper.selectList("reviewDao.getReviewsByProductNo", rs -> {
			Review review = new Review();
			
			review.setNo(rs.getInt("review_no"));
			review.setContent(rs.getString("review_content"));
			review.setCreateDate(rs.getDate("review_create_date"));
			
			Customer customer = new Customer();
			customer.setId(rs.getString("cust_id"));
			customer.setName(rs.getString("cust_name"));
			review.setCustomer(customer);
			return review;
		}, productNo);
	}
	public Review getReviewByNo(int reviewNo) {
		return DaoHelper.selectOne("reviewDao.getReviewByNo", rs -> {
			 Review review = new Review();
			
			review.setNo(rs.getInt("review_no"));
			review.setContent(rs.getString("review_content"));
			review.setCreateDate(rs.getDate("review_create_date"));
			review.setProduct(new Product(rs.getInt("product_no")));
			review.setCustomer(new Customer(rs.getString("cust_id"))); 
			
			return review;
		}, reviewNo);
	}
	public void deleteReviewByNo(int reviewNo) {
		DaoHelper.update("reviewDao.deleteReviewByNo", reviewNo);
	}
}
