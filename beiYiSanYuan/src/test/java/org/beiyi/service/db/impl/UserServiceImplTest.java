package org.beiyi.service.db.impl;

import org.beiyi.controller.base.WebUtils;
import org.beiyi.entity.db.User;
import org.beiyi.service.BaseJunit4Test;
import org.beiyi.service.db.itr.IUserService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class UserServiceImplTest extends BaseJunit4Test{
	@Autowired
	IUserService userService;
	@Test
	public void saveUser(){
		String username = "admin";
		String password = "admin";
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		userService.saveUser(user);
	}
	@Test
	public void findUser(){
		String username = "admin";
		String password = "admin";
		User user = userService.findUser(username, password);
		
		System.out.println(user);
	}
}	
