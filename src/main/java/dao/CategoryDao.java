package dao;

import java.util.List;

import util.DaoHelper;
import vo.Category;

public class CategoryDao {

	public List<Category> getCategories() {
		return DaoHelper.selectList("categoryDao.getCategories", rs -> {
			Category cat = new Category();
			cat.setNo(rs.getInt("cat_no"));
			cat.setName(rs.getString("cat_name"));
			
			return cat;
		});
	}
}
