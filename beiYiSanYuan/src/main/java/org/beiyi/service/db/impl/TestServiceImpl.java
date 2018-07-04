package org.beiyi.service.db.impl;

import org.beiyi.dao.TestMapper;
import org.beiyi.entity.db.Test;
import org.beiyi.service.db.itr.ITestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class TestServiceImpl implements ITestService{
	@Autowired
	private TestMapper testMapper;
	@Override
	public int insertSelective(Test record) {
		return testMapper.insertSelective(record);
	}

}
