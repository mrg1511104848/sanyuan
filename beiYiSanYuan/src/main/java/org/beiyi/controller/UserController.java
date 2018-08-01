package org.beiyi.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.beiyi.controller.base.SessionData;
import org.beiyi.controller.base.WebUtils;
import org.beiyi.entity.db.User;
import org.beiyi.service.db.itr.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	IUserService userService;
	/**
	 * 去登陆
	 * 
	 * @return
	 */
	@RequestMapping("/toLogin.htm")
	public ModelAndView toLogin() {
		ModelAndView modelAndView = new ModelAndView("html/login");
		return modelAndView;
	}
	@ResponseBody
	@RequestMapping("/login.htm")
	public JSONObject login(String username,String password,HttpSession httpSession) {
		User user = userService.findUser(username, password);
		if(user !=null ){
			httpSession.setAttribute(SessionData.USER, user);
			return WebUtils.createSuccResult();
		}else{
			return WebUtils.createErrorResult();
		}
	}
	/**
	 * 去登陆
	 * 
	 * @return
	 */
	@RequestMapping("/loginOut.htm")
	public ModelAndView loginOut(HttpSession httpSession) {
		ModelAndView modelAndView = new ModelAndView("html/login");
		httpSession.removeAttribute(SessionData.USER);
		return modelAndView;
	}
	
	@RequestMapping(value = "/data-statistics.htm")
	public String dataStatistics(@RequestParam Map<String, Object> params) {
		return "html/ajax/data-statistics";
	}
}
