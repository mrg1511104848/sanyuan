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
		ChuFang chuFang = new ChuFang();
		HuanZhe huanZhe = new HuanZhe();
		huanZhe.setBornDate("1920-10-01");
		huanZhe.setJiuZhenDate("2018-10-01");
		huanZhe.setSex("女");
		chuFang.setHuanZhe(huanZhe);
		
		List<Drug> drugs = new ArrayList<Drug>();
		
		Drug drug00 = new Drug();
		drug00.setDrugCombinationName("芬必得(布洛芬缓释胶囊)");
		drugs.add(drug00);
		
		for (int i = 0; i < 10; i++) {
			Drug drug = new Drug();
			drug.setDrugCombinationName("测试药品"+i);
			drugs.add(drug);
		}
		chuFang.setDrugs(drugs);
		VerifyResult verifyResult = sexVerifyService.verify(chuFang, null);
		System.out.println(verifyResult);
	}
}
