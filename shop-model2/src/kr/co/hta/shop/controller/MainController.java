package kr.co.hta.shop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hta.shop.dao.BookDao;
import kr.co.hta.shop.dao.CategoryDao;
import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class MainController {
	
	private BookDao bookDao = BookDao.getInstance();
	private CategoryDao categoryDao = CategoryDao.getInstance();
	
	@RequestMapping("/main.hta")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main.jsp");
		
		mav.addAttribute("recentBooks", bookDao.getNewBooks());
		mav.addAttribute("bestsellerBooks", bookDao.getBestsellerBooks());
		request.getSession().setAttribute("categories", categoryDao.getAllCategories());
		
		return mav;
	}
}
