package org.beiyi.changliang;

import java.util.ArrayList;
import java.util.List;

import org.beiyi.util.DrugInfoParseToStandard;
import org.skynet.frame.util.RegexUtils;

public class DrugInfoEnum {
	public static List<String> shiYingZhengRegex;
	public static final Integer SHANGPIN_NAME = 1;
	public static final Integer TONGYONG_NAME = 2;
	public static final String shangPinNameRegex = "(.+?)(片|颗|粒|缓释|缓释片|复合包装|干混悬剂|胶囊|®(.+®))+";
	public static final String shangPinTongYongRegex = "(.+?)[\\(（]{1}(.*)[\\)）]{1}";
	public static final String standardRegex = "(.+?)(g|mg)\\s*x([0-9]+)(.+?)/(.*)";//5mg x 10 片/ 盒
	public static final String standardRegexForCompoundDrug = "(\\d+|\\d+.\\d+)(g|mg)\\s*/\\s*(\\d+|\\d+.\\d+)(g|mg)x(\\d+)";//5mg x 10 片/ 盒
	public static final String dosageUnitRegex = "(.+?)(g|mg|克|毫克|ml)";//
	public static final String dosageRegex = "；|;";//每次用量的分隔
	
	static {
		shiYingZhengRegex = new ArrayList<String>();
		shiYingZhengRegex.add("(.+?)\\(.*\\)");
		shiYingZhengRegex.add("(.+?)病$");
	}
	
	public static void main(String[] args) {
//		System.out.println(RegexUtils.getByGroup(shangPinNameRegex, "一小片", 1).size());;
		
//		System.out.println(RegexUtils.getByGroup(standardRegex, "0.3g x20粒/盒", 4));
	}
}
