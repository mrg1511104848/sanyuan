package org.beiyi.service.db.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.dao.SectionMapper;
import org.beiyi.dao.UserMapper;
import org.beiyi.dao.UserSectionMapper;
import org.beiyi.entity.db.Section;
import org.beiyi.entity.db.User;
import org.beiyi.entity.db.UserSection;
import org.beiyi.service.db.itr.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService {
	@Autowired
	UserMapper userMapper;
	@Autowired
	UserSectionMapper userSectionMapper;
	@Autowired
	SectionMapper sectionMapper;

	@Override
	public User findUser(String username, String password) {
		return userMapper.findUser(username, password);
	}

	@Override
	public int saveUser(User user) {
		return userMapper.insert(user);
	}

	@Override
	public List<org.beiyi.entity.db.pageBean.UserSection> getPagedList(
			Map<String, Object> params) {
		org.beiyi.entity.db.pageBean.UserSection userSection = new org.beiyi.entity.db.pageBean.UserSection();
		if (params != null) {
			if (params.containsKey("sectionName")) {
				userSection
						.setSectionName(params.get("sectionName").toString());
			}
			if (params.containsKey("username")) {
				userSection.setUsername(params.get("username").toString());
			}
		}
		return userSectionMapper.getPagedList(userSection);
	}

	@Override
	public User get(String id) {
		return userMapper.selectByPrimaryKey(id);
	}

	@Override
	public void delete(String id) {
		userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void save(org.beiyi.entity.db.pageBean.UserSection userSection) {
		String userRealName = userSection.getUserRealName();
		String userName = userSection.getUsername();
		String password = userSection.getPassword();
		User userRecord = new User();
		userRecord.setUserRealName(userRealName);
		userRecord.setUsername(userName);
		userRecord.setPassword(password);
		if (StringUtils.isBlank(userSection.getUserId())) {
			userMapper.insert(userRecord);
			userSection.setUserId(userRecord.getId());
		} else {
			userRecord.setId(userSection.getUserId());
			userMapper.updateByPrimaryKeySelective(userRecord);
		}
		UserSection record = new UserSection();
		record.setSectionId(userSection.getSectionId());
		record.setUserId(userSection.getUserId());
		record.setId(userSection.getUserSectionId());
		if (StringUtils.isBlank(userSection.getUserSectionId())) {
			userSectionMapper.insert(record);
		} else {
			userSectionMapper.updateByPrimaryKeySelective(record);
		}
	}

	@Override
	public org.beiyi.entity.db.pageBean.UserSection getUserSection(String id) {
		return userSectionMapper.get(id);
	}

	@Override
	public void deleteUserSection(String userSectionId) {
		UserSection userSection = userSectionMapper
				.selectByPrimaryKey(userSectionId);
		if (userSection != null) {
			userSectionMapper.deleteByPrimaryKey(userSectionId);
			userMapper.deleteByPrimaryKey(userSection.getUserId());
		}
	}

}
