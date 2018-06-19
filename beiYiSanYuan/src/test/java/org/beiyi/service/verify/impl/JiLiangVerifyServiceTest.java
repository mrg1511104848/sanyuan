package org.beiyi.service.verify.impl;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import org.beiyi.changliang.DrugInfoEnum;
import org.skynet.frame.util.DoubleUtil;
import org.skynet.frame.util.RegexUtils;

public class JiLiangVerifyServiceTest {
	public static void main(String[] args) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		List<String> mqRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, "0.3g x20粒/盒", 1);
		List<String> muRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, "0.3g x20粒/盒", 2);
		List<String> fqRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, "0.3g x20粒/盒", 3);
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
		
		System.out.println(containsCfEach + mu);
		
		
		
		
		//每次用量
		String cfEachTimeUse = "3";
		String cfEachTimeUseUnit = "g";
		
		
		String[] cfStandardDosageArr = parseDosageUnitToStandard(cfEachTimeUse, cfEachTimeUseUnit);
		if(cfStandardDosageArr == null){
			System.out.println("cfStandardDosageArr == null");
			return;
		}
		double parseAfter = DoubleUtil.parseStr2Double(cfStandardDosageArr[0],3);
		
		//包装总剂量/每次剂量 = 一盒可以吃几次 
		//一盒的次数 * 总盒数 = 一共可以吃几次
		//一共可以吃的次数/频率(一天几次 / 2天一次 ) 算出一共可以吃几天。
		
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
