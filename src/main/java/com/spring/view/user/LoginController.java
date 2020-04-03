package com.spring.view.user;

import java.net.URLDecoder;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.biz.common.MailUtil;
import com.spring.biz.user.UserService;
import com.spring.biz.user.UserVO;

@Controller
public class LoginController {

	@Autowired
	UserService userService;
	
//	암호화 클래스 Bean 선언 (spring-security.xml)
	@Autowired
	BCryptPasswordEncoder bcryptPwEncoder;

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String loginView(@ModelAttribute("user") UserVO vo) {
		return "member/login_user";
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(UserVO vo, HttpSession session) {
		UserVO dbUser = userService.getUserInform(vo);
		try {
			boolean passMatch = bcryptPwEncoder.matches(vo.getPassword(), dbUser.getPassword());
			
			if (passMatch) {
				session.setAttribute("userName", dbUser.getName());
				session.setAttribute("userId", dbUser.getId());
				session.setAttribute("userRole", dbUser.getRole());
				return "index";
			} else {
				return "member/login_user_failed";
			}
		} catch (Exception e) { return "member/login_user_failed"; }
	}

//	Admin 로그인 컨트롤
	@RequestMapping(value = "/indexAdmin.do", method = RequestMethod.GET)
	public String indexAdminView(@ModelAttribute("user") UserVO vo, HttpSession session) {
		session.setAttribute("userName", "관리자");
		session.setAttribute("userId", "admin");
		return "index";
	}

	@RequestMapping(value = "/addmember.do", method = RequestMethod.GET)
	public String addMemberView(@ModelAttribute("user") UserVO vo) {
		return "member/addmember";
	}

	@RequestMapping(value = "/addmember.do", method = RequestMethod.POST)
	public String addMemberproc(UserVO vo) {
		vo.setPassword(bcryptPwEncoder.encode(vo.getPassword()));
		userService.setUser(vo);
		return "member/login_user";
	}

	// 아이디 중복 검사
	@RequestMapping(value = "/getUserConfirm.do", method = RequestMethod.POST)
	@ResponseBody
	public boolean getUserConfirm(@RequestBody String userId, UserVO vo) {
		int result = userId.indexOf("=");
		String insertId = userId.substring(result + 1);
		vo.setId(insertId);
		if (userService.getUserInform(vo) != null || insertId.equals("admin") || insertId.equals(""))
			return false;
		else
			return true;
	}

	// 이메일 인증
	@RequestMapping(value = "/assignMail.do", method = RequestMethod.POST)
	@ResponseBody
	public String assignMail(@RequestBody String insertMail, UserVO vo, MailUtil mail) throws Exception{
		int result = insertMail.indexOf("=");
		String encodeMail = insertMail.substring(result + 1);
		String userMail = URLDecoder.decode(encodeMail,"UTF-8");
		vo.setMail(userMail);
		if(userService.getUserMail(vo) == null) {
			String code = mail.mailCodeSendNaver(userMail);
			return code;
		}else {
			return "fail";
		}
	}

	@RequestMapping(value = "/searchId.do", method = RequestMethod.GET)
	public String searchIdView(@ModelAttribute("user") UserVO vo, HttpSession session) {
		session.invalidate();
		return "member/search_userId";
	}

	@RequestMapping(value = "/searchId.do", method = RequestMethod.POST)
	public String searchIdProc(UserVO vo, HttpSession session) {
		UserVO user = userService.searchUserId(vo);
		if (user != null) {
			session.setAttribute("searchId", user.getId());
			return "member/search_userId";
		} else {
			session.setAttribute("searchId", "fail");
			return "member/search_userId";
		}
	}

	@RequestMapping(value = "/searchPw.do", method = RequestMethod.GET)
	public String searchPwView(@ModelAttribute("user") UserVO vo, HttpSession session) {
		session.invalidate();
		return "member/search_userPw";
	}

	@RequestMapping(value = "/searchPw.do", method = RequestMethod.POST)
	public String searchPwProc(UserVO vo, HttpSession session, MailUtil mail) throws Exception {
		UserVO user = userService.searchUserPw(vo);
		String tempPw = mail.setCode();
		
		if (user != null) {
			mail.sendTempPwNaver(tempPw, user.getMail());
			user.setPassword(bcryptPwEncoder.encode(tempPw));
			userService.updatePw(user);
			session.setAttribute("searchPw", tempPw);
			return "member/search_userPw";
		} else {
			session.setAttribute("searchPw", "fail");
			return "member/search_userPw";
		}
	}
}
