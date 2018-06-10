package org.beiyi.datadeal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.ansj.domain.Term;
import org.apache.commons.collections4.ListUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.reource.Resources;
import org.bson.Document;
import org.jsoup.Jsoup;
import org.skynet.frame.util.AnalysisUtil;
import org.skynet.frame.util.ListUtil;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.map.MapUtil;
import org.skynet.frame.util.mongo.MongoUtil;

import com.github.crab2died.ExcelUtils;
import com.mongodb.client.MongoCursor;

/**
 * 丁香园说明书用量处理
 * 
 * @author 2bu
 *天
 */
public class DxyShuoMingShuDosageDeal {
	private static final String NO_DATA_DISCRIPTER = "NONE";
	private static Map<String, String> iCD10VersionMap = null ;
	static String dosageFrequencyRegex = ".*[日曰天周月小时].*[mg片粒颗袋毫克次].*|.*/.*/天|.*每.*周.*次|.*每.*给药一次.*|.*天\\s*.+?\\s*次.*|.*日\\s*.+?\\s*次.*|.*小时\\s*.+?\\s*次.*|.+?\\s*次\\s*/\\s*日.*|.+?\\s*次\\s*/\\s*小时.*|.+?\\s*次\\s*/\\s*天.*";
//	static String dosageFrequencyRegexGroup = "(间隔.*[日|曰|天|周|月|(小时)]).*次@@.*(日剂量).*@@.*([每|0-9|一|—|二|三|四|五|六|七|八|九].*[晚|日|曰|天|周|月|(小时)].*次).*@@.*([每|—|一|二|三|四|五|六|七|八|九].*[晚|日|曰|天|周|月|小时]).*[mg|g|片|粒|颗|袋|mg|g|毫克|克|次].*";
//	static String dosageFrequencyRegexGroup = ".*([每|一|—|二|三|四|五|六|七|八|九]\\s*[日|曰|天|周|月|小时].*次).*@@[至少]*(间隔.*[[0-9]+|一|—|二|三|四|五|六|七|八|九|十]{1,}[日|曰|天|周|月|小时])@@.*[mg|g|片|粒|颗|袋|mg|g|毫克|克|次][/]{0,1}.*/([日|曰|天|周|月|(小时)])@@.*[mg|g|片|粒|颗|袋|mg|g|毫克|克|次].*/.*(([每]|[0-9]+)[日|曰|天|周|月|(小时)]).*@@(间隔.*[日|曰|天|周|月|(小时)]).*次@@.*(日剂量).*@@.*([每|一|—|二|三|四|五|六|七|八|九]{1}.+?[晚|日|曰|天|周|月|(小时)]{0,1}).*[mg|g|片|粒|颗|袋|mg|g|毫克|克|次].*@@.*([每|一|—|二|三|四|五|六|七|八|九].*[晚|日|曰|天|周|月|(小时)]).*[mg|g|片|粒|颗|袋|mg|g|毫克|克|次].*";
	static String dosageFrequencyRegexGroup = ""
			+ "(.+?/.+?\\s*/\\s*天)"
			+ "@@([一—二两三四五六七八九0-9]+\\s*([-~]\\s*[一—二两三四五六七八九0-9]+)?\\s*([\\(（].+?[）\\)])?\\s*[mg片粒颗袋毫克次]\\s*/\\s*日)"
			+ "@@([每一—二三四五六七八九]{1}\\s*(日|曰|天|周|月|小时){1}\\s*[次]?\\s*[一—二两三四五六七八九0-9]+\\s*([-~]\\s*[一—二两三四五六七八九0-9]+)?\\s*次)"
			+ "@@(([一—二三四五六七八九0-9]+\\s*[或~-～])?\\s*[一—二三四五六七八九0-9]+\\s*(日|曰|天|周|月|小时))"
			+ "@@(间隔.*[一—二三四五六七八九0-9]+(日|曰|天|周|月|小时))"
			+ "@@([每一—二三四五六七八九0-9]+(日|曰|天|周|月|小时))"
			+ "@@(分\\s*[一—二三四五六七八九0-9]+\\s*次)"
			+ "@@(初始剂量|隔日|日最大剂量|日剂量|更大剂量|起始剂量|负荷剂量|维持剂量|最大剂量|剂量调整|单次剂量上限|单次剂量下限|单日最大剂量|最大日剂量|最大研究剂量)"
			+ "@@([一—二三四五六七八九0-9分]+次\\s*(或[一—二三四五六七八九0-9分]+\\s*次)?.+?(口服|服用|注射))"
			+ "@@([每一—二三四五六七八九]{1}\\s*(日|曰|天|周|月|小时|晚){1}\\s*(用药)?\\s*[一—二两三四五六七八九0-9]+\\s*([-~]\\s*[一—二两三四五六七八九0-9]+)?\\s*次)"
			+ "@@((临睡)?时\\s*服).+?[mg片粒颗袋毫克次]";
	static String dosageRegex = ".*mg.*|.*g.*|.*毫克.*|.*克.*|.*次.*|.*片.*[片|粒|颗|袋|mg|g|毫克|克]?";
	public static String dosageFilterRegex = ""
    		+ "("
    		+ "[0-9.]+\\s*[mg至或~\\--～毫克次片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+\\s*"
    		+ "([0-9.\\smg毫克次片粒颗袋mg拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+)?"
    		+ "(\\s*/\\s*[mg毫克次片粒颗袋mg拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+)?"
    		+ ")"
    		+ "@@"
    		+ "("
			+ "[0-9.]+\\s*[mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+"
			+ ")"
			+ "@@"
			+ "("
			+ "[0-9.一—二三四五六七八九]+\\s*[mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+"
			+ "\\s*[至或~\\--—～]{1}"
			+ "\\s*[0-9.一—二三四五六七八九]+\\s*[mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+"
			+ ")"
			+ "@@"
			+ "("
			+ "[0-9.一—二三四五六七八九]+\\s*(日|曰|天|周|月|小时|晚){1}\\s*"
			+ "[0-9.一—二三四五六七八九]+\\s*[mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]?"
			+ "\\s*[至或~\\--—～]{1}"
			+ "\\s*[0-9.一—二三四五六七八九]+\\s*[mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+"
			+ ")"
			+ "@@"
			+ "("
    		+ "[0-9.一—二三四五六七八九]+\\s*[mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]?"
			+ "\\s*[至或~\\--—～]{1}"
			+ "\\s*[0-9.一—二三四五六七八九]+\\s*[mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+"
			+ ")"
			+ "@@"
			+ "("
			+ "[0-9.一—二三四五六七八九]+\\s*(日|曰|天|周|月|小时|晚){1}\\s*"
			+ "[0-9.一—二三四五六七八九]+\\s*[次mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]?"
			+ "\\s*[至或~\\--—～]{1}"
			+ "\\s*[0-9.一—二三四五六七八九]+\\s*[次mg毫克片粒颗袋拴揿瓶片喷枚盒滴单位袋包百万单位μgWmlIUkgm²]+"
			+ ")";
	
	private static boolean debug = false;
	public static final String DICT_NAME = "dosageDict";
	static void deal() {
		MongoCursor<Document> cursor = MongoUtil
				.iterator("bysy_dxy_medicine_by_search_title");
		while (cursor.hasNext()) {
			Document document = cursor.next();
			Map<String, String> shuoMingDetail = (Map<String, String>) document
					.get("shuoMingDetail");
			String dosage = shuoMingDetail.get("药品名称:");
			String shangPinName = StringUtils.substringAfter(dosage, "商品名称：")
					.trim();
			Map<String, Object> queryMap = new HashMap<String, Object>();
			queryMap.put("createTime", document.getString("createTime"));
			queryMap.put("medicineTitle", document.getString("medicineTitle"));
			Map<String, Object> updateMap = new HashMap<String, Object>();
			updateMap.put("medicineSpName", shangPinName);
			MongoUtil.updateDoc("bysy_dxy_medicine_by_search_title", queryMap,
					updateMap);
		}
	}

	final static List<String> tempTestDrugNameList = new ArrayList<String>();
	final static List<DrugCombinationName> testDrugNameList = new ArrayList<DrugCombinationName>();

	public static void loadTestDrugNameList() throws InvalidFormatException,
			IOException {
		List<List<String>> testDrugList = null;
		testDrugList = ExcelUtils
				.getInstance()
				.readExcel2List(
						"D://爱客服/数据_ALL/北医三院/三院提供/test drug list共163（航慈1-60，张琪61-120，亚希121-163）.xlsx");
		for (int i = 1; i < testDrugList.size(); i++) {
			List<String> drugList = testDrugList.get(i);
			String combinationName = drugList.get(1);
			if (StringUtils.isNotBlank(combinationName)) {
				DrugCombinationName drugCombinationName = new DrugCombinationName(
						combinationName);
				testDrugNameList.add(drugCombinationName);
				tempTestDrugNameList.add(drugCombinationName
						.getCombinationStandardName());
			}
		}
	}

	static {
		try {
			loadDicts();
			loadTestDrugNameList();
			DxyShuoMingShuIndicationDeal.loadICD10Dict();
			iCD10VersionMap = DxyShuoMingShuIndicationDeal.loadICD10VersionMap();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws InvalidFormatException,
			IOException {
		// deal();
//		 System.out.println("本品为双时相胰岛素制剂。本品的双时相组份包含短效胰岛素和中效胰岛素。 在需要快速起效使效应延长时，通常给予预混胰岛素一天一次或一天二次。 "
//				 .matches(".*[日|曰|天|周|月|小时].*[mg|g|片|粒|颗|袋|mg|g|毫克|克|次].*"));
		MongoCursor<Document> dxy_app_drug_detail_simple_cursor = MongoUtil
				.iterator("dxy_app_drug_detail_simple");
		List<String> cells = new ArrayList<String>();
		cells.add("药品名称");
		cells.add("用法用量全文");
		cells.add("给药途径");
		cells.add("提取的部分");
		cells.add("ICD10 (疾病 , 编码 , 版本)");
		cells.add("数字+单位");
		cells.add("数字+单位前后名词");
		cells.add("数字+单位前后名词(所有词+词性)");
		cells.add("可能的用量1");
		cells.add("可能的用量2");
		cells.add("可能的用量3");
		cells.add("可能的用量4");
		cells.add("可能的用量5");
		List<List<String>> values = new ArrayList<List<String>>();
		List<String> drugCombinationExistsInExport = new ArrayList<String>();

		while (dxy_app_drug_detail_simple_cursor.hasNext()) {
			Document doc = dxy_app_drug_detail_simple_cursor.next();
			String commonName = doc.getString("commonName");
			String cnName = doc.getString("cnName");
			String dosage = doc.getString("dosage");
			if (commonName.contains("（")) {
				commonName = StringUtils.substringBefore(commonName, "（");
			}
			DrugCombinationName drugCombinationName = new DrugCombinationName(
					cnName + "(" + commonName + ")");
			
			if (!testDrugNameList.contains(drugCombinationName)) {
				continue;
			}
			if (drugCombinationExistsInExport.contains(drugCombinationName
					.getCombinationStandardName())) {
				continue;
			}
			if(drugCombinationName.getCombinationStandardName().contains("诺和灵30R")){
				System.out.println();
			}
			values.addAll(parseDosageV2(dosage, drugCombinationName));
			drugCombinationExistsInExport.add(drugCombinationName
					.getCombinationStandardName());
			// AnalysisUtil.getTermList(sentence);
		}
		List<List<String>> probablyMedicineValues = new ArrayList<List<String>>();
		List<String> result = ListUtils.subtract(tempTestDrugNameList,
				drugCombinationExistsInExport);
		for (String r : result) {
			DrugCombinationName drugCombinationName = new DrugCombinationName(r);
			String shangPinName = drugCombinationName.getShangPinName();
			String tongYongName = drugCombinationName.getTongYongName();

			Document doc = MongoUtil.findOne(
					"bysy_dxy_medicine_by_search_title", "medicineTitle",
					shangPinName);
			if (doc == null) {
				doc = MongoUtil.findOne("bysy_dxy_medicine_by_search_title",
						"medicineTitle", tongYongName);
				if (doc == null) {
					doc = MongoUtil.findOne(
							"bysy_dxy_medicine_by_search_title",
							"medicineSpName", shangPinName);
				}
				if (doc == null) {
					doc = MongoUtil.findOne(
							"bysy_dxy_medicine_by_search_title",
							"medicineSpName", tongYongName);
				}
			}
			if (doc == null) {
				System.err.println("[drugCombination] "
						+ drugCombinationName.getCombinationStandardName()
						+ " has error!");
				continue;
			} else {
				Map<String, String> shuoMingDetail = (Map<String, String>) doc
						.get("shuoMingDetail");
				String dosage = shuoMingDetail.get("用法用量:");
				dosage = Jsoup.parse(dosage).text();
				probablyMedicineValues.addAll(parseDosageV2(dosage,
						drugCombinationName));
			}
		}
		ExcelUtil.export("D://temp_丁香园剂量导出V5.xls", cells, values);
		ExcelUtil.export("D://temp_丁香园剂量导出V5(不确定的药品).xls", cells,
				probablyMedicineValues);
	}

	private static void loadDicts() {
		AnalysisUtil.loadDict(Resources.useForDosageSplitDicts, DICT_NAME);
	}

	private static List<List<String>> parseDosageV2(String dosage,
			DrugCombinationName drugCombinationName) {
		String[] dosageSetenceArr = dosage.split("。|；");
		List<List<String>> values = new ArrayList<List<String>>();
		for (int i = 0; i < dosageSetenceArr.length; i++) {
			List<String> subValues = new ArrayList<String>();
			String dosageSentence = dosageSetenceArr[i];
			String routeOfMedicine = getRouteOfMedicine(dosage);
			subValues.add(drugCombinationName.getCombinationStandardName());
			subValues.add(dosage);
			subValues.add(routeOfMedicine);
			
			
			if (dosageSentence.matches(dosageFrequencyRegex)) {
				String[] splitByDotArr = dosageSentence.split("，|,");
				subValues.add(dosageSentence);
				subValues.add(getDosageIcdInfo(dosageSentence));
				subValues.add(getDosageFrequency(splitByDotArr));
				
				addSentence(splitByDotArr, subValues);
				addProbablyDosage(splitByDotArr, subValues);

				values.add(subValues);
			} else {
				// values.add(subValues);
			}
		}
		if (values.size() == 0) {
			List<String> subValues = new ArrayList<String>();
			subValues.add(drugCombinationName.getCombinationStandardName());
			subValues.add(dosage);
			String routeOfMedicine = "";
			for (String routeOf : Resources.routeOfMedicineList) {
				if (dosage.contains(routeOf)) {
					routeOfMedicine = routeOf;
					break;
				}
			}
			subValues.add(routeOfMedicine);
			values.add(subValues);
		}
		return values;
	}
	private static String getDosageIcdInfo(String dosageSentence) {
		
		List<String> termNameList = AnalysisUtil.getTermNameList(dosageSentence, DxyShuoMingShuIndicationDeal.INDICATION_TERM_NATURE,DxyShuoMingShuDosageDeal.DICT_NAME);
		if(termNameList == null || termNameList.size() == 0){
			return NO_DATA_DISCRIPTER;
		}
		StringBuffer icd10InfoBuffer = new StringBuffer();
		for (String disease : termNameList) {
			Map<String, Object> filter = new HashMap<String, Object>();
			filter.put("name", disease.trim());
			MongoCursor<Document> wechatIcdItr = MongoUtil.iterator("wechat_icd",filter,null,false);
			while (wechatIcdItr.hasNext()) {
				Document doc = wechatIcdItr.next();
				String code = doc.getString("code");
				String version = doc.getString("version");
				String versionCn = iCD10VersionMap.get(version);
				icd10InfoBuffer.append(disease+" , "+code+" , "+versionCn+" \n");
			}
		}
		return icd10InfoBuffer.toString();
	}
	private static String getDosageFrequency(String[] splitByDotArr) {
		StringBuffer dosageFrequencyBuffer = new StringBuffer();
		for (String splitByDot : splitByDotArr) {
			String[] dosageFrequencyRegexGroupList = dosageFrequencyRegexGroup.split("@@");
			for (String dosageFrequencyRegexGroupEach : dosageFrequencyRegexGroupList) {
				List<String> groupResult = RegexUtils.getByGroup(dosageFrequencyRegexGroupEach, splitByDot);
				if(groupResult.size()>0){
					String dosageFrequency = groupResult.get(0);
					if(debug  == true){
						dosageFrequencyBuffer.append(dosageFrequency+" （"+dosageFrequencyRegexGroupEach+"）| ");
					}else{
						dosageFrequencyBuffer.append(dosageFrequency+" | ");
					}
					break;
				}
			}
		}
		return dosageFrequencyBuffer.toString();
	}

	private static String getRouteOfMedicine(String dosage) {
		for (String routeOf : Resources.routeOfMedicineList) {
			if (dosage.contains(routeOf)) {
				return routeOf;
			}
		}
		return null;
	}

	private static void addProbablyDosage(String[] dosageSetenceArr,
			List<String> subValues) {
		for (int index = 0; index < dosageSetenceArr.length; index++) {
			String sentence = dosageSetenceArr[index];
			if (sentence.matches(dosageRegex)) {
				Set<String> dosageFilterResultSet = new HashSet<String>();
				String[] dosageFilterRegexGroupList = dosageFilterRegex.split("@@");
				for (String dosageFilterRegexGroupEach : dosageFilterRegexGroupList) {
					String dosageFilterResult = RegexUtils.getByRegex(dosageFilterRegexGroupEach, sentence);
					if(StringUtils.isNotBlank(dosageFilterResult)){
						dosageFilterResultSet.add(dosageFilterResult.trim());
					}
				}
				sentence = sentence + "  转换后 : ";
				for (String dosageFilterResult : dosageFilterResultSet) {
					sentence = sentence + dosageFilterResult+" | ";
				}
				subValues.add(sentence);
			}
		}

	}

	private static void appendToSubValues(String[] dosageSetenceArr,
			StringBuffer nounBuffer, StringBuffer allSplitBuffer, int index) {
		List<Term> terms = AnalysisUtil.getTermList(dosageSetenceArr[index]);
		for (Term term : terms) {
			if (term.getNatureStr().equals("n")
					|| term.getNatureStr().equals(DICT_NAME)) {
				nounBuffer.append(term.getName() + " | ");
			}
			if (term.getNatureStr() != null
					&& !term.getNatureStr().equals("null")) {
				allSplitBuffer.append(term.getName() + "("
						+ term.getNatureStr() + ") | ");
			}
		}
	}

	private static void addSentence(String[] dosageSetenceArr,
			List<String> subValues) {
		StringBuffer nounBuffer = new StringBuffer();
		StringBuffer allSplitBuffer = new StringBuffer();
		for (int i = 0; i < dosageSetenceArr.length; i++) {
			appendToSubValues(dosageSetenceArr, nounBuffer,
					allSplitBuffer, i);
		}
		subValues.add(nounBuffer.toString());
		subValues.add(allSplitBuffer.toString());
	}
}
