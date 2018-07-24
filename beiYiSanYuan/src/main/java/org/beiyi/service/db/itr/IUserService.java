package org.beiyi.service.db.itr;

import java.util.List;
import java.util.Map;

import org.beiyi.entity.db.User;

public interface IUserService {
	User findUser(String username, String password);
	int saveUser(User user);
	List<org.beiyi.entity.db.pageBean.UserSection> getPagedList(Map<String, Object> params);
	User get(String id);
	void save(org.beiyi.entity.db.pageBean.UserSection userSection);
	void delete(String id);
	org.beiyi.entity.db.pageBean.UserSection getUserSection(String id);
	void deleteUserSection(String userSectionId);
}
