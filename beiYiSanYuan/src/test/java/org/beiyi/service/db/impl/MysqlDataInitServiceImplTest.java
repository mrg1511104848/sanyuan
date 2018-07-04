package org.beiyi.service.db.impl;

import org.beiyi.service.BaseJunit4Test;
import org.beiyi.service.db.itr.IMysqlDataInitService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class MysqlDataInitServiceImplTest extends BaseJunit4Test {
	@Autowired
	IMysqlDataInitService dataInitService;

	@Test
	public void init() {
//		dataInitService.initAtcCode();

		dataInitService.initIcd10();
	}
}
