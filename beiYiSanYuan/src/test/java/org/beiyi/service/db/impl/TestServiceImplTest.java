package org.beiyi.service.db.impl;

import java.util.Date;

import org.beiyi.service.BaseJunit4Test;
import org.beiyi.entity.db.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class TestServiceImplTest extends BaseJunit4Test{
	@Autowired
	TestServiceImpl testServiceImpl;
	@org.junit.Test
	public void testInsert(){
		Test record = new Test();
		record.setAge(22);
		record.setCreatetime(new Date());
		record.setName("name");
		testServiceImpl.insertSelective(record);
	}
}
