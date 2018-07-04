package org.beiyi.service.db.impl;

import org.beiyi.dao.UserMapper;
import org.beiyi.entity.db.User;
import org.beiyi.service.db.itr.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService{
	@Autowired
	UserMapper userMapper;

	@Override
	public User findUser(String username, String password) {
		return userMapper.findUser(username, password);
	}

	@Override
	public int saveUser(User user) {
		return userMapper.insert(user);
	}
	
}
