package org.beiyi.service.db.itr;

import org.beiyi.entity.db.User;

public interface IUserService {
	User findUser(String username, String password);
	int saveUser(User user);
}
