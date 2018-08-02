package org.beiyi.service.db.impl;

import org.beiyi.dao.TestMapper;
import org.beiyi.entity.db.Test;
import org.beiyi.entity.db.TestCopy;
import org.beiyi.service.db.itr.ITestCopyService;
import org.beiyi.service.db.itr.ITestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class TestServiceImpl implements ITestService{
	@Autowired
	private TestMapper testMapper;
	@Autowired
	private ITestCopyService testCopyService;
	@Override
	public int insertSelective(Test record) throws Exception {
		TestCopy tc = new TestCopy();
		tc.setAge(111111);
		try {
			testCopyService.insertSelective(tc);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int r = testMapper.insertSelective(record);
		return r;
	}

}
