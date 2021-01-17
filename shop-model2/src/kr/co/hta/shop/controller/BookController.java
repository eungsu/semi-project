package kr.co.hta.shop.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hta.shop.dao.BookDao;
import kr.co.hta.shop.dao.CategoryDao;
import kr.co.hta.shop.dao.ReviewDao;
import kr.co.hta.shop.dto.ReviewDto;
import kr.co.hta.shop.util.StringUtils;
import kr.co.hta.shop.vo.Book;
import kr.co.hta.shop.vo.Review;
import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class BookController {

	private BookDao bookDao = BookDao.getInstance();
	private CategoryDao categoryDao = CategoryDao.getInstance();
	private ReviewDao reviewDao = ReviewDao.getInstance(); 

	@RequestMapping("/book/list.hta")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("book/list.jsp");

		final int ROWS_PER_PAGE = 8;
		final int DEFAULT_PAGE_NO = 1;
		final int DEFAULT_CATEGORY_NO = 100;

		int categoryNo = StringUtils.stringToInt(request.getParameter("catno"), DEFAULT_CATEGORY_NO);
		int pageNo = StringUtils.stringToInt(request.getParameter("pageno"), DEFAULT_PAGE_NO);

		int totalCount = bookDao.getBooksCountByCategory(categoryNo);
		int totalPages = (int) (Math.ceil((double) totalCount/ROWS_PER_PAGE));
		if (pageNo <= 0 || pageNo > totalPages) {
			pageNo = DEFAULT_PAGE_NO;
		}
		int begin = (pageNo - 1)*ROWS_PER_PAGE + 1;
		int end = pageNo*ROWS_PER_PAGE;

		mav.addAttribute("books", bookDao.getBooksByCategory(categoryNo, begin, end));
		mav.addAttribute("category", categoryDao.getCategoryByNo(categoryNo));
		mav.addAttribute("pageNo", pageNo);
		mav.addAttribute("totalPages", totalPages);

		return mav;
	}

	@RequestMapping("/book/detail.hta")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("book/detail.jsp");

		// 책정보 조회
		int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
		int categoryNo = StringUtils.stringToInt(request.getParameter("catno"));
		int pageNo = StringUtils.stringToInt(request.getParameter("pageno"));

		// 리뷰정보 조회
		final int ROWS_PER_PAGE = 5;
		int reviewPageNo = StringUtils.stringToInt(request.getParameter("reviewpageno"), 1);
		int begin = (reviewPageNo - 1)*ROWS_PER_PAGE + 1;
		int end = reviewPageNo*ROWS_PER_PAGE;

		int totalCount = reviewDao.getReviewsCountByBookNo(bookNo);
		int totalPages = (int) (Math.ceil((double) totalCount/ROWS_PER_PAGE));

		HttpSession session = request.getSession();
		Integer loginedUserNo = (Integer) session.getAttribute("LOGINED_USER_NO");

		List<ReviewDto> reviewDtoList = new ArrayList<>();
		if (loginedUserNo == null) {
			reviewDtoList = reviewDao.getReviewDtosByRange(bookNo, begin, end);	
		} else {
			reviewDtoList = reviewDao.getReviewDtosByRange(bookNo, loginedUserNo, begin, end);
		}

		Book book = bookDao.getBookByNo(bookNo);
		mav.addAttribute("book", book);
		mav.addAttribute("category", categoryDao.getCategoryByNo(categoryNo));
		mav.addAttribute("pageNo", pageNo);

		mav.addAttribute("reviews", reviewDtoList);
		mav.addAttribute("reviewPageNo",  reviewPageNo);
		mav.addAttribute("totalPages", totalPages);

		return mav;
	}

	@RequestMapping("/book/insertReview.hta")
	public ModelAndView insertReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
		String title = request.getParameter("title");
		int bookPoint = StringUtils.stringToInt(request.getParameter("point"), 1);
		String content = request.getParameter("content");

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		int pageNo = StringUtils.stringToInt(request.getParameter("pageno"), 1);

		Review review = new Review();
		review.setUserNo(userNo);
		review.setBookNo(bookNo);
		review.setTitle(title);
		review.setBookPoint(bookPoint);
		review.setContent(content);

		reviewDao.insertReview(review);

		Book book = bookDao.getBookByNo(bookNo);
		double reviewPoint = Math.round((book.getReviewPoint()*book.getReviewCount()*10 + bookPoint*10)/(book.getReviewCount() + 1))/10.0;
		book.setReviewPoint(reviewPoint);
		book.setReviewCount(book.getReviewCount() + 1);
		bookDao.updateBook(book);

		mav.setViewName("redirect:detail.hta?bookno=" + book.getNo() + "&catno=" + book.getCategoryNo() + "&pageno=" + pageNo);

		return mav;
	}

	@RequestMapping("/book/likeReview.hta")
	public ModelAndView likeReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		int reviewNo = StringUtils.stringToInt(request.getParameter("reviewno"));
		
		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		reviewDao.insertReviewLikeUser(reviewNo, userNo);

		Review review = reviewDao.getReviewByNo(reviewNo);
		review.setLikeCount(review.getLikeCount() + 1);
		reviewDao.updateReview(review);

		int bookNo = StringUtils.stringToInt(request.getParameter("bookno"));
		int categoryNo = StringUtils.stringToInt(request.getParameter("cartno"));
		int pageNo = StringUtils.stringToInt(request.getParameter("pageno"), 1);
		int reviewPageNo = StringUtils.stringToInt(request.getParameter("reviewpageno")); 	

		mav.setViewName("redirect:detail.hta?bookno="+bookNo+"&cartno="+categoryNo+"&pageno="+pageNo+"&reviewno="+reviewNo+"&reviewpageno="+reviewPageNo);

		return mav;
	}
	
}
