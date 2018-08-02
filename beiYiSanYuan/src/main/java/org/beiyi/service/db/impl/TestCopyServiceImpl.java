package org.beiyi.service.db.impl;

import org.beiyi.dao.TestCopyMapper;
import org.beiyi.entity.db.TestCopy;
import org.beiyi.service.db.itr.ITestCopyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class TestCopyServiceImpl implements ITestCopyService{
	@Autowired
	private TestCopyMapper testMapper;
	@Override
	public int insertSelective(TestCopy record) throws RuntimeException{
		int r = testMapper.insertSelective(record);
		throw new RuntimeException("xxx");
	}

}
