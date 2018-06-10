package org.beiyi.util;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.changliang.DrugInfoEnum;
import org.skynet.frame.util.RegexUtils;

public class DrugInfoParseToStandard {
	/**
	 * 商品名统一格式化
	 */
	public static String shangPinNameParseToStandard(String shangPinName){
		if(StringUtils.isBlank(shangPinName)) return null;
		shangPinName = shangPinName.replace(" ", "");
		List<String> groupShangPinName = RegexUtils.getByGroup(DrugInfoEnum.shangPinNameRegex, shangPinName, 1);
		String standardShangPinName = groupShangPinName.size()>0 ? groupShangPinName.get(0) : shangPinName;
		return standardShangPinName;
	}
	/**
	 * 获取药品名称(1 商品  、 2 通用)
	 * @param combinationName
	 * @param type
	 * @return
	 */
	public static String getDrugName(String combinationName,int type){
		if(type <= 0 || type > 2){
			throw new RuntimeException("Type range should between 1 and 2");
		}
		List<String> r = RegexUtils.getByGroup(DrugInfoEnum.shangPinTongYongRegex, combinationName, type);
		String result = r == null || r.size()==0 ? combinationName:r.get(0);
		return result;
	}
	public static void main(String[] args) {
//		System.out.println(shangPinNameParseToStandard("啊啊啊片"));;
		for (int i = 1; i < 3; i++) {
			System.out.println(getDrugName("澳能(卤米松乳膏)", i));
		}
	}
}
