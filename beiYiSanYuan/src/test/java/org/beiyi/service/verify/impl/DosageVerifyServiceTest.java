package org.beiyi.service.verify.impl;

import org.beiyi.entity.VerifyResult;
import org.junit.Test;

public class DosageVerifyServiceTest {
	@Test
	public void testVerify(){
		DosageVerifyService dosageVerifyService = new DosageVerifyService();
		VerifyResult verifyResult = dosageVerifyService.verify(CommonResourceForVerify.getChuFang(), null);
		System.out.println(verifyResult);
	}
}
