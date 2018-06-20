package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.List;

import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.HuanZhe;

public class CommonResourceForVerify {
	public static ChuFang getChuFang(){
		ChuFang chuFang = new ChuFang();
		HuanZhe huanZhe = new HuanZhe();
		huanZhe.setBornDate("1920-10-01");
		huanZhe.setJiuZhenDate("2018-10-01");
		huanZhe.setSex("女");
		chuFang.setHuanZhe(huanZhe);
		
		List<Drug> drugs = new ArrayList<Drug>();
		
		/*Drug drug00 = new Drug();
		drug00.setDrugCombinationName("芬必得(布洛芬缓释胶囊)");
		drug00.setDosage("0.3");
		drug00.setDosageUnit("g");
		drug00.setDosageUnit("常规剂量");
		drugs.add(drug00);*/
		
		/*Drug drug11 = new Drug();
		drug11.setDrugCombinationName("芬必得(布洛芬缓释胶囊)");
		drug11.setDosage("100");
		drug11.setDosageUnit("g");
		drug11.setDosageUnit("单次剂量上限");
		drugs.add(drug11);*/
		
		/*Drug drug22 = new Drug();
		drug22.setDrugCombinationName("芬必得(布洛芬缓释胶囊)");
		drug22.setDosage("2");
		drug22.setDosageUnit("粒");
		drug22.setDosingFrequency("BID");
		drug22.setStandard("0.3g x20粒/盒");
		drugs.add(drug22);*/
		
		List<String> diagnosises = new ArrayList<String>();
		chuFang.setDiagnosises(diagnosises);
		Drug drug33 = new Drug();
		drug33.setDrugCombinationName("络活喜(苯磺酸氨氯地平片)");
		drug33.setDosage("5");
		drug33.setDosageUnit("mg");
		drug33.setDosingFrequency("BID");
		drug33.setStandard("5mgx7片/盒");
		drug33.setDrugQuantity("3");
		drugs.add(drug33);
		
		Drug drug44 = new Drug();
		drug44.setDrugCombinationName("络活喜(苯磺酸氨氯地平片)");
		drug44.setDosage("5");
		drug44.setDosageUnit("mg");
		drug44.setDosingFrequency("每日一次，早4点");
		drug44.setStandard("5mgx7片/盒");
		drug44.setDrugQuantity("3");
		drugs.add(drug44);
		
		Drug drug55 = new Drug();
		drug55.setDrugCombinationName("芬必得(布洛芬缓释胶囊)");
		drug55.setDosage("5");
		drug55.setDosageUnit("粒");
		drug55.setDosingFrequency("BID");
		drug55.setStandard("0.3g x20粒/盒");
		drug55.setDrugQuantity("20");
		drugs.add(drug55);
		
		for (int i = 0; i < 10; i++) {
			Drug drug = new Drug();
			drug.setDrugCombinationName("测试药品"+i);
			drugs.add(drug);
		}
		chuFang.setDrugs(drugs);
		return chuFang;
	}
}
