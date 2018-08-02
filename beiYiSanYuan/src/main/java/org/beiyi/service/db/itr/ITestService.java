package org.beiyi.service.db.itr;

import org.beiyi.entity.db.Test;

public interface ITestService {
	int insertSelective(Test record) throws Exception ;
}
