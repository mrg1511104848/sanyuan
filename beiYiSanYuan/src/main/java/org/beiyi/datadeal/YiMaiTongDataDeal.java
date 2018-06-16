package org.beiyi.datadeal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.DrugCombinationName;
import org.bson.Document;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.mongo.MongoUtil;

/**
 * 医脉通的数据处理
 * @author 2bu
 *
 */
public class YiMaiTongDataDeal {
	private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(YiMaiTongDataDeal.class);
	private static final String UNIVERSAL_NAME_REGEX = "[【\\[]通用名称[】\\]]\\s*(.+?)[\\[【]{1}";
	private static final String SP_NAME_REGEX = "[【\\[]商品名称[】\\]]\\s*(.+?)[\\[【]{1}";
	private static final String EN_NAME_REGEX = "[【\\[]英文名称[】\\]]\\s*(.+?)[\\[【]{1}";
	public static void main(String[] args) {
		dealData();
	}
	/**
	 * 处理医脉通集合 yiMaiTongFinal 中的 “药品名称：”字段，并提取出 商品名、通用名、英文名、所属分类 字段
	 * 并提取对应的 “所属类别：”字段 ，最终存储到 yiMaiTongFinalStandard 集合中
	 */
	private static void dealData(){
		String targetColName = "yiMaiTongFinalStandard";
		List<Document> yiMaiTongFinal = MongoUtil.findDocList("yiMaiTongFinal");
		for (Document document : yiMaiTongFinal) {
			String url = document.getString("url");
			String medicineName = document.getString("药品名称：");
			String category = document.getString("所属类别：");
			if(StringUtils.isBlank(medicineName)){
				logger.error(String.format("--The medicineName of document[url=%s] is blank ",url));
				continue;
			}
			if(StringUtils.isBlank(category)){
				logger.error(String.format("--The category of document[url=%s] is blank ",url));
				continue;
			}
			String tongYongMing = RegexUtils.getByGroupSimple(UNIVERSAL_NAME_REGEX, medicineName);
			String shangPinMing = RegexUtils.getByGroupSimple(SP_NAME_REGEX, medicineName);
			String englishName = RegexUtils.getByGroupSimple(EN_NAME_REGEX, medicineName);
			if(StringUtils.isNotBlank(tongYongMing)){
				tongYongMing = tongYongMing.trim();
			}else{
				logger.error(String.format("--The tongYongMing of medicineName “%s” is blank ", medicineName));
				continue;
			}
			if(StringUtils.isNotBlank(shangPinMing)){
				shangPinMing = shangPinMing.trim();
			}else{
				logger.error(String.format("--The shangPinMing of medicineName “%s” is blank ", medicineName));
				continue;
			}
			if(StringUtils.isNotBlank(englishName)){
				englishName = englishName.trim();
			}else{
				logger.error(String.format("--The englishName of medicineName “%s” is blank ", medicineName));
//				continue;
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("tongYongMing", tongYongMing);
			map.put("shangPinMing", shangPinMing);
			map.put("englishName", englishName);
			
			DrugCombinationName drugCombinationName = new DrugCombinationName(shangPinMing,tongYongMing);
			map.put("combinationStandardName", drugCombinationName.getCombinationStandardName());
			if(MongoUtil.has(targetColName, map)){
				continue;
			}
			map.put("category", category);
			map.put("dealFromCollection", "yiMaiTongFinal");
			MongoUtil.saveDoc("yiMaiTongFinalStandard", map);
//			if(medicineName)
		}
	}
}
