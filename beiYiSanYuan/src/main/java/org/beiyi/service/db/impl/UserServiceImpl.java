package org.beiyi.service.db.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.dao.UserMapper;
import org.beiyi.dao.UserSectionMapper;
import org.beiyi.entity.db.Section;
import org.beiyi.entity.db.User;
import org.beiyi.entity.db.UserSection;
import org.beiyi.service.db.itr.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService{
	@Autowired
	UserMapper userMapper;
	@Autowired
	UserSectionMapper userSectionMapper;
	@Override
	public User findUser(String username, String password) {
		return userMapper.findUser(username, password);
	}

	@Override
	public int saveUser(User user) {
		return userMapper.insert(user);
	}

	@Override
	public List<UserSection> getPagedList(Map<String, Object> params) {
		UserSection userSection = null;
		return userSectionMapper.getPagedList(userSection);
	}

	@Override
	public User get(String id) {
		return userMapper.selectByPrimaryKey(id);
	}

	@Override
	public void save(User user) {
		if(StringUtils.isBlank(user.getId())){
			userMapper.insert(user);
		}else{
			userMapper.updateByPrimaryKeySelective(user);
		}
	}

	@Override
	public void delete(String id) {
		userMapper.deleteByPrimaryKey(id);
	}
	
}
