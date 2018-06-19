package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.List;

import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.HuanZhe;
import org.junit.Test;

public class SexVerifyServiceTest {
	@Test
	public void testVerify(){
		SexVerifyService sexVerifyService = new SexVerifyService();
		ChuFang chuFang = CommonResourceForVerify.getChuFang();
		VerifyResult verifyResult = sexVerifyService.verify(chuFang, null);
		System.out.println(verifyResult);
	}
}
