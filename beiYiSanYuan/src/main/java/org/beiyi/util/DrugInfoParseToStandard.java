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
	 * 通用名统一格式化
	 */
	public static String tongYongNameParseToStandard(String tongYongMing){
		List<String> tongYongNameRegexList = RegexUtils.getByGroup("(左旋|小儿|复方|右旋|注射用){0,1}(.+?)(口服|片|分散片|混悬液|缓释胶囊|胶囊|缓释片|乳膏|凝胶|软胶囊|糖浆|搽剂|缓释混悬液|混悬液|颗粒|注射液|滴眼液|泡腾片|眼膏|肠溶片|栓){1,3}", tongYongMing, 2);
    	if(tongYongNameRegexList.size() == 0){
    		tongYongNameRegexList = RegexUtils.getByGroup("(左旋|小儿|复方|右旋|注射用){0,1}(.+)", tongYongMing, 2);
    	}
    	if(tongYongNameRegexList.size() > 0){
    		tongYongMing = tongYongNameRegexList.get(0);
    	}
    	return tongYongMing;
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
