package org.beiyi.service.verify.impl;

import org.beiyi.entity.VerifyResult;
import org.junit.Test;

public class DosageMaxLimitVerifyServiceTest {
	@Test
	public void testVerify(){
		DosageMaxLimitVerifyService verifyService = new DosageMaxLimitVerifyService();
		VerifyResult verifyResult = verifyService.verify(CommonResourceForVerify.getChuFang(), null);
		System.out.println(verifyResult);
	}
}
