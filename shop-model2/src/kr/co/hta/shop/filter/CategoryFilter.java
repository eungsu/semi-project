package kr.co.hta.shop.filter;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import kr.co.hta.shop.dao.CategoryDao;

@WebFilter(urlPatterns = "/*")
public class CategoryFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		try {
			request.setAttribute("categories", CategoryDao.getInstance().getAllCategories());
			chain.doFilter(request, response);
		} catch (SQLException e) {
			throw new ServletException(e);
		}
	}
}
