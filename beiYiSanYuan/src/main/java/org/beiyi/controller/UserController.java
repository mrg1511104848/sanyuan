package org.beiyi.controller;

import net.sf.json.JSONObject;

import org.beiyi.controller.base.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/user")
public class UserController {
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
	public JSONObject login() {
		ModelAndView modelAndView = new ModelAndView("html/login");
		return WebUtils.createSuccResult();
	}
}
