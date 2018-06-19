package org.beiyi.service.verify.impl;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import org.beiyi.changliang.DrugInfoEnum;
import org.beiyi.util.DosingFrequencyUtil;
import org.beiyi.util.VerifyUtil;
import org.skynet.frame.util.DoubleUtil;
import org.skynet.frame.util.RegexUtils;

public class JiLiangVerifyServiceTest {
	public static void main(String[] args) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		String chuFangStandard = "0.3g x20粒/盒";
		List<String> mqRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, chuFangStandard, 1);
		List<String> muRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, chuFangStandard, 2);
		List<String> fqRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, chuFangStandard, 3);
		//计算每盒的有效成分量
		if(mqRegex.size() == 0 || fqRegex.size() == 0 || muRegex.size() == 0){
			System.out.println("mqRegex.size() == 0 || fqRegex.size() == 0 || muRegex.size() == 0");
			return;
		}
		String mq = mqRegex.get(0);
		String mu = muRegex.get(0);
		String fq = fqRegex.get(0);
		double doubleMq = DoubleUtil.parseStr2Double(mq, 3);
		Integer intFq = Integer.parseInt(fq);
		double containsCfEach = doubleMq*intFq;//计算每盒药有效成分量
		
		//每次用量
		String cfEachTimeUse = "1";
		String cfEachTimeUseUnit = "粒";
		int totalPack = 10;
		String dosingFrequency = "BID";
		// 进行包装单位转换
		String[] standardDosageParse = VerifyUtil.parseDosagePackUnit(chuFangStandard, containsCfEach+"", mu);
		String[] eachTimeUseDosageParse = VerifyUtil.parseDosagePackUnit(chuFangStandard, cfEachTimeUse, cfEachTimeUseUnit);
		if(eachTimeUseDosageParse == null || standardDosageParse == null){
			return;
		}
		
		// 进行剂量单位转换
		String[] standardDosageStandard = parseDosageUnitToStandard(
				standardDosageParse[0], standardDosageParse[1]);
		String[] eachTimeUseDosageStandard = parseDosageUnitToStandard(eachTimeUseDosageParse[0],
				eachTimeUseDosageParse[1]);
		if(standardDosageStandard == null || eachTimeUseDosageStandard == null){
			return;
		}		
		
		double doubleStandardDosageStandard = DoubleUtil.parseStr2Double(standardDosageStandard[0], 3);//包装总剂量
		double doubleEachTimeUse = DoubleUtil.parseStr2Double(eachTimeUseDosageStandard[0], 3);//每次剂量
		//一盒的次数 * 总盒数 = 一共可以吃几次
		int allCanUseTimeEachPack = (int)(doubleStandardDosageStandard/doubleEachTimeUse);
		//包装总剂量/每次剂量 = 一盒可以吃几次 
		int allCanUseTimeAllPack = allCanUseTimeEachPack*totalPack;
		String[] dayTimeArr = DosingFrequencyUtil.getDosingFrequency(dosingFrequency);
		
		int day = Integer.parseInt(dayTimeArr[0]);
		int time = Integer.parseInt(dayTimeArr[1]);
		
		//一共可以吃的次数/频率(一天几次 / 2天一次 ) 算出一共可以吃几天。
		int totalCanUseDay = (int)Math.ceil((double)(allCanUseTimeAllPack/time*day));
		System.out.println("处方规格:"+chuFangStandard+",一共"+totalPack+"盒,"+day+"天/"+time+"次,"+"每次用量"+cfEachTimeUse+cfEachTimeUseUnit);
		System.out.println("一盒共可以吃"+allCanUseTimeEachPack+"次");
		System.out.println("所有盒共可以吃"+allCanUseTimeAllPack+"次");
		System.out.println("一共可吃"+totalCanUseDay+"天");
		//先算日剂量上限
	}
	
	private static String[] parseDosageUnitToStandard(String dosage, String dosageUnit) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		JiLiangVerifyService test = new JiLiangVerifyService();  
		Class<JiLiangVerifyService> clazz = JiLiangVerifyService.class;  
		Method declaredMethod = clazz.getDeclaredMethod("parseDosageUnitToStandard", String.class,String.class);  
		declaredMethod.setAccessible(true);  
		Object invokeResult = declaredMethod.invoke(test, dosage,dosageUnit);
		String[] results=  (String[])invokeResult;
		return results;
	}
}
