package org.beiyi.service.verify.impl;

import org.beiyi.entity.VerifyResult;
import org.junit.Test;

public class DDDSVerifyServiceTest {
	@Test
	public void testVerify(){
		DDDSVerifyService verifyService = new DDDSVerifyService();
		VerifyResult verifyResult = verifyService.verify(CommonResourceForVerify.getChuFang(), null);
		System.out.println(verifyResult);
	}
}
