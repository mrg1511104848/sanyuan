package org.beiyi.service.db.itr;

import org.beiyi.entity.db.Test;
import org.beiyi.entity.db.TestCopy;

public interface ITestCopyService {
	int insertSelective(TestCopy record) throws RuntimeException;
}
