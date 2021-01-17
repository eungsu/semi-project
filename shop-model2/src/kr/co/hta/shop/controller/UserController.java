package kr.co.hta.shop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import kr.co.hta.shop.dao.OrderDao;
import kr.co.hta.shop.dao.PointHistoryDao;
import kr.co.hta.shop.dao.UserDao;
import kr.co.hta.shop.util.StringUtils;
import kr.co.hta.shop.vo.User;
import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class UserController {

	private PointHistoryDao pointHistoryDao = PointHistoryDao.getInstance();
	private OrderDao orderDao = OrderDao.getInstance();
	private UserDao userDao = UserDao.getInstance();

	@RequestMapping("/form.hta")
	public ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("form.jsp");
	}

	@RequestMapping("/register.hta")
	public ModelAndView register(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("password2");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");

		if (!password.equals(confirmPassword)) {
			return new ModelAndView("return:form.hta?error=pwd");
		}

		User savedUser = userDao.getUserById(id);
		if (savedUser != null) {
			return new ModelAndView("redirect:form.hta?error=dup");
		}

		User user = new User();
		user.setName(name);
		user.setId(id);
		user.setPassword(DigestUtils.sha256Hex(password));
		user.setTel(tel);
		user.setEmail(email);

		userDao.insertUser(user);

		return new ModelAndView("redirect:completed.hta");
	}

	@RequestMapping("/completed.hta")
	public ModelAndView completed(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("completed.jsp");
	}

	@RequestMapping("/loginform.hta")
	public ModelAndView loginform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("loginform.jsp");
	}

	@RequestMapping("/login.hta")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		String userId = request.getParameter("id");
		String userPassword = request.getParameter("password");

		if (StringUtils.isEmpty(userId)) {
			return new ModelAndView("redirect:loginform.hta?error=empty");
		}
		if (StringUtils.isEmpty(userPassword)) {
			return new ModelAndView("redirect:loginform.hta?error=empty");
		}

		User savedUser = userDao.getUserById(userId);
		if (savedUser == null) {
			return new ModelAndView("redirect:loginform.hta?error=invalid");
		}

		String sha256HexPasssword = DigestUtils.sha256Hex(userPassword);
		if (!savedUser.getPassword().equals(sha256HexPasssword)) {
			return new ModelAndView("redirect:loginform.hta?error=invalid");
		}

		HttpSession session = request.getSession();
		session.setAttribute("LOGINED_USER_NO", savedUser.getNo());
		session.setAttribute("LOGINED_USER_ID", savedUser.getId());
		session.setAttribute("LOGINED_USER_NAME", savedUser.getName());

		mav.setViewName("redirect:main.hta");

		return mav;
	}

	@RequestMapping("/logout.hta")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return new ModelAndView("redirect:main.hta");
	}

	@RequestMapping("/my/pointHistory.hta")
	public ModelAndView pointHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		int userNo = (Integer) session.getAttribute("LOGINED_USER_NO");

		mav.addAttribute("user", userDao.getUserByNo(userNo));
		mav.addAttribute("pointHistories", pointHistoryDao.getPointHistoriesByUserNo(userNo));

		mav.setViewName("my/pointhistory.jsp");

		return mav;
	}

	@RequestMapping("/my/info.hta")
	public ModelAndView info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}

		mav.addAttribute("user", userDao.getUserByNo(userNo));
		mav.addAttribute("orders", orderDao.getOrdersByUserNo(userNo));

		mav.setViewName("my/info.jsp");

		return mav;
	}

	@RequestMapping("/my/changePassword.hta")
	public ModelAndView changePassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String prePassword = request.getParameter("prevPassword");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		HttpSession session = request.getSession();
		Integer userNo = (Integer) session.getAttribute("LOGINED_USER_NO");
		if (userNo == null) {
			mav.setViewName("redirect:/shop-model2/loginform.hta=error=deny");
			return mav;
		}
		User user = userDao.getUserByNo(userNo);

		if (!user.getPassword().equals(DigestUtils.sha256Hex(prePassword))) {
			mav.setViewName("redirect:complete.hta?error=mismatch");
			return mav;
		}
		if (!password.equals(confirmPassword)) {
			mav.setViewName("redirect:complete.hta?error=mismatch");
			return mav;
		}

		user.setPassword(DigestUtils.sha256Hex(password));
		userDao.updateUser(user);

		mav.setViewName("redirect:complete.hta");
		
		return mav;
	}
	
	@RequestMapping("/my/complete.hta")
	public ModelAndView complete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("my/complete.jsp");
	}
}
