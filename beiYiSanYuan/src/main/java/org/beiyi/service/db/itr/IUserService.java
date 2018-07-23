package org.beiyi.service.db.itr;

import java.util.List;
import java.util.Map;

import org.beiyi.entity.db.Section;
import org.beiyi.entity.db.User;
import org.beiyi.entity.db.UserSection;

public interface IUserService {
	User findUser(String username, String password);
	int saveUser(User user);
	List<UserSection> getPagedList(Map<String, Object> params);
	User get(String id);
	void save(User user);
	void delete(String id);
}
