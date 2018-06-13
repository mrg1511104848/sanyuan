package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.beiyi.entity.Drug;
import org.beiyi.util.DrugInfoParseToStandard;
import org.beiyi.util.ICD10ParseUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.skynet.frame.persistent.MongoIndex;
import org.skynet.frame.persistent.MongoPersistent;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.http.HttpUtil;
import org.skynet.frame.util.map.MapUtil;
import org.skynet.frame.util.mongo.MongoUtil;

import com.github.crab2died.ExcelUtils;
import com.mongodb.client.MongoCursor;

public class MicroEffectDeal {
	private static Logger log = Logger.getLogger(MicroEffectDeal.class.getName());
	// private static final String micromedex_dregclass =
	// "micromedex_dregclass";
	private static final String micromedex_dreg_detail = "micromedex_dreg_detail";
	private static final String micromedex_dreg_effect = "micromedex_dreg_effect1";
	static Map<String, String> headers = new HashMap<String, String>();
	static {
		headers.put("Accept-Encoding", "gzip, deflate");
		headers.put("Accept-Language",
				"zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2");
		headers.put("Connection", "keep-alive");
		headers.put("Content-Type", "application/x-www-form-urlencoded");
		headers.put(
				"Cookie",
				"MDX_ACCOUNT_INFO=\"cid=744270001|account=Peking University Health Science Library|auth=IP|uid=\"; JSESSIONID=7DD3C591F5E2CC8FE99D176424103F55.RMiYhXMsJYrvrqwvt; THCAPPV/micromedex2=4.170.0; THCOWN=7D532F525AE; THCTIME=1516506153929; ScG=6AA324143ED88DA7F5A480399FFE86E2; THCTEST=HereIAm; THCSTKT=1113926912|1.0|3|IP|710148282|LKS7Ry2TR0e+yfqfu9RohY+eMMdw+W+bFc2Mpn4SDjm0932eWxWRF1zasxdfKz+OwnQxmjkB1UW6M3pQ0YYBUhuDA981DOxm; THCCONN=710148282; THCLSID=1113926913");
		headers.put("Host", "www.micromedexsolutions.com");
		headers.put("User-Agent",
				"Mozilla/5.0 (Windows NT 6.1; W…) Gecko/20100101 Firefox/57.0");
		headers.put("X-Requested-With", "XMLHttpRequest");
	}

	public static void main(String[] args) throws IOException, Exception {
//		 exportToExcel();
//		 getDrugEffectMaterial();
//		step1();
//		step2();
		drugAtcInfoDDIExport();
		drugAtcInfoDDIWithDXYExport();
	}
	static List<List<String>> atcInfos = null;
	static{
		try {
			String path = "C://公司/北医三院/atc(药物分类)编码.xls";
			path = "";
			atcInfos = ExcelUtils.getInstance().readExcel2List("D://爱客服/数据_ALL/北医三院/数据/atc(药物分类)编码.xls");
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		filterValidAtcInfos(7);
	}
	/**
	 * 遍历micromedex_dreg_effect_material集合中的level为Major和Contraindicated的文档。
	 * 通过a药品，如果有effectMs，表示b是一个类别。需要将b类别下的effectMs遍历，挨个去atc第四级英文
	 * 名称中匹配，如是atc第四级中的英文名的子集，则记录下该atc的通用名。
	 * @throws IOException 
	 * @throws InvalidFormatException 
	 */
	@SuppressWarnings("unused")
	private static void step1() throws InvalidFormatException, IOException{
		Map<String, Object> filter = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> level1 = new HashMap<String, Object>();
		level1.put("level", "Major");
		list.add(level1);
		Map<String, Object> level2 = new HashMap<String, Object>();
		level2.put("level", "Contraindicated");
		list.add(level2);
		filter.put("$or", list);
		MongoCursor<org.bson.Document> cursor = MongoUtil.iterator("micromedex_dreg_effect_material",filter,null,false);
		
		List<String> cells = new ArrayList<String>();
		cells.add("A药英文名");
		cells.add("A药英文名(实际匹配过程中用到的)");
		cells.add("A药ATC编码");
		cells.add("A药ATC中文名");
		cells.add("A药ATC英文名");
//		cells.add("B药所属分类");
		cells.add("B药英文名");
		cells.add("B药英文名(实际匹配过程中用到的)");
		cells.add("B药ATC编码");
		cells.add("B药ATC中文名");
		cells.add("B药ATC英文名");
		cells.add("相互作用级别");
		cells.add("相互作用类型");
		List<List<String>> values = new ArrayList<List<String>>();
		while (cursor.hasNext()) {
			org.bson.Document doc = cursor.next();
			String drugA = doc.getString("a");
			String drugOrDrugClassB = doc.getString("b");
			String type = doc.getString("type");
			Object effectMs = doc.get("effectMs");
			if(effectMs!=null){//代表是类别
				
				List<ATCInfo> drugAValidAtcInfos = getValidAtcInfosByDrugEnName(drugA);
				if(drugAValidAtcInfos.size() == 0){
					log.warn(drugA+"'s drugAValidAtcInfos not found");
					continue;
				}
				for (ATCInfo drugAValidAtcInfo : drugAValidAtcInfos) {
					saveDrugValidAtcInfo(drugA,drugAValidAtcInfo);
				}
				
				List<String> effectMsList = (List<String>)effectMs;
				for (String drugInClassBEach : effectMsList) {
					List<ATCInfo> classBDrugEachValidAtcInfos = getValidAtcInfosByDrugEnName(drugInClassBEach);
					if(classBDrugEachValidAtcInfos.size() == 0){
						log.warn(drugInClassBEach+"'s classBDrugEachValidAtcInfos not found");
						continue;
					}
					
					for (ATCInfo drugBValidAtcInfo : classBDrugEachValidAtcInfos) {
						saveDrugValidAtcInfo(drugInClassBEach,drugBValidAtcInfo);
					}
					
					//建立关联
					for (ATCInfo drugAValidAtcInfo : drugAValidAtcInfos) {
						
						List<String> subValues = new ArrayList<String>();
						subValues.add(drugA);
						if(drugA.contains("AZATHIOPRINE")){
							System.out.println();
						}
						subValues.add(StringUtils.substringBefore(drugA, " ["));
						subValues.add(drugAValidAtcInfo.getNo());
						subValues.add(drugAValidAtcInfo.getChName());
						subValues.add(drugAValidAtcInfo.getEnName());
						
						for (ATCInfo drugBValidAtcInfo : classBDrugEachValidAtcInfos) {
//							subValues.add(drugOrDrugClassB);
							subValues.add(drugInClassBEach);
							subValues.add(StringUtils.substringBefore(drugInClassBEach, " ["));
							subValues.add(drugBValidAtcInfo.getNo());
							subValues.add(drugBValidAtcInfo.getChName());
							subValues.add(drugBValidAtcInfo.getEnName());
							subValues.add(doc.getString("level"));
							subValues.add(doc.getString("type"));
							values.add(subValues);
							saveDrugAtcInfoDDI(subValues);
						}
					}
					
					/*Map<String, Object> drugAtcInfoDDI = new HashMap<String, Object>();
					drugAtcInfoDDI.put("drugAEnName", drugA);
					drugAtcInfoDDI.put("drugBEnName", drugInClassBEach);
					
					MongoUtil.saveDoc("drugAtcInfoDDI", drugAtcInfoDDI);*/
				}
			}
			else if(type.equals("与乙醇相关的禁忌")){//乙醇相关的药品相互作用处理。
				List<ATCInfo> eachValidAtcInfos = null;
				String drugFirst = null;
				String drugIsETHANOL = null;
				if(StringUtils.substringBefore(drugA, " [").equalsIgnoreCase("ETHANOL")){
					eachValidAtcInfos = getValidAtcInfosByDrugEnName(drugOrDrugClassB);
					drugFirst = drugOrDrugClassB;
					drugIsETHANOL = drugA;
				}else if(StringUtils.substringBefore(drugOrDrugClassB, " [").equalsIgnoreCase("ETHANOL")){
					eachValidAtcInfos = getValidAtcInfosByDrugEnName(drugA);
					drugFirst = drugA;
					drugIsETHANOL = drugOrDrugClassB;
				}
				//建立关联
				for (ATCInfo drugAtcInfo : eachValidAtcInfos) {
					List<String> subValues = new ArrayList<String>();
					subValues.add(drugFirst);
					subValues.add(StringUtils.substringBefore(drugFirst, " ["));
					subValues.add(drugAtcInfo.getNo());
					subValues.add(drugAtcInfo.getChName());
					subValues.add(drugAtcInfo.getEnName());
					
					subValues.add(drugIsETHANOL);
					subValues.add(StringUtils.substringBefore(drugIsETHANOL, " ["));
					subValues.add("");
					subValues.add("");
					subValues.add("");
					subValues.add(doc.getString("level"));
					subValues.add(doc.getString("type"));
					saveDrugAtcInfoDDI(subValues);
				}
			}
		}
	}
	/**
	 * 遍历drugAtcInfoDDI通过drugAAtcChName和drugBAtcChName去丁香园dxy_app_drug_detail_deal中匹配药品
	 * ，并存储药品间的的相互作用至drugAtcInfoDDIWithDXY集合中
	 * @throws InvalidFormatException
	 * @throws IOException
	 */
	private static void step2() throws InvalidFormatException, IOException{
		MongoCursor<org.bson.Document> cursor = MongoUtil.iterator("drugAtcInfoDDI");
		int drugAtcInfoDDITotal = MongoUtil.getCount("drugAtcInfoDDI");
		int curr = 0;
		while (cursor.hasNext()) {
			org.bson.Document doc = cursor.next();
			String level = doc.getString("level");
			String type = doc.getString("type");
			String drugAAtcChName = doc.getString("drugAAtcChName");
			String drugBAtcChName = doc.getString("drugBAtcChName");
			List<Drug> dxyADrugs =  getDrugList(drugAAtcChName);
			if(StringUtils.isNotBlank(type)&&type.equals("与乙醇相关的禁忌")){
				//去药品中辅料找辅料中含有乙醇或者酒精的。
				//TODO 去药品中辅料找辅料中含有乙醇或者酒精的。
				continue;
			}else{
				List<Drug> dxyBDrugs = getDrugList(drugBAtcChName);
				for (Drug drugA : dxyADrugs) {
					for (Drug drugB : dxyBDrugs) {
						Map<String, Object> drugAtcInfoDDIWithDXY = new HashMap<String, Object>();
						MapUtil.cpAndRemoveNullValue(doc, drugAtcInfoDDIWithDXY);
						drugAtcInfoDDIWithDXY.put("dxyDrugAId", drugA.getId());
						drugAtcInfoDDIWithDXY.put("dxyDrugAShangPinMing", drugA.getShangPinName());
						drugAtcInfoDDIWithDXY.put("dxyDrugATongYongMing", drugA.getTongYongName());
						drugAtcInfoDDIWithDXY.put("dxyDrugBId", drugB.getId());
						drugAtcInfoDDIWithDXY.put("dxyDrugBShangPinMing", drugB.getShangPinName());
						drugAtcInfoDDIWithDXY.put("dxyDrugBTongYongMing", drugB.getTongYongName());
						MongoUtil.saveDoc("drugAtcInfoDDIWithDXY", drugAtcInfoDDIWithDXY);
					}
				}
			}
			System.out.println(++curr+"\t"+drugAtcInfoDDITotal);
		}
	}
	
	/**
	 * 遍历dxy_app_drug_detail_deal集合，去掉tongYongMing字段中的胶囊、口服、片等字。并存到新的dxy_app_drug_detail_deal_final集合中
	 * @return
	 */
	private static void dealdxy_app_drug_detailName(){
		MongoCursor<org.bson.Document> cursor = MongoUtil.iterator("dxy_app_drug_detail_deal");
		while (cursor.hasNext()) {
			org.bson.Document doc = cursor.next();
			String tongYongMing = doc.getString("tongYongMing");
			tongYongMing = DrugInfoParseToStandard.tongYongNameParseToStandard(tongYongMing);
	    	Map<String, Object> dxy_app_drug_detail_deal_final = new HashMap<String, Object>();
			MapUtil.cpAndRemoveNullValue(doc, dxy_app_drug_detail_deal_final);
			dxy_app_drug_detail_deal_final.put("tongYongMingUpdate",tongYongMing);
			MongoUtil.saveDoc("dxy_app_drug_detail_deal_final", dxy_app_drug_detail_deal_final);
		}
	}
	private static List<org.beiyi.entity.Drug> getDrugList(String icd10DiseaseTongYongName){
		List<String> tongYongNameList = ICD10ParseUtil.getDiseaseNames(icd10DiseaseTongYongName);
		List<org.beiyi.entity.Drug> drugList = new ArrayList<org.beiyi.entity.Drug>();
		List<String> temp_tongYongNameRegexList_toFile = new ArrayList<String>();
		for (String tongYongName : tongYongNameList) {
			temp_tongYongNameRegexList_toFile.add(tongYongName);
			Map<String, Object> filterMap = new HashMap<String, Object>();
			filterMap.put("tongYongMingUpdate", tongYongName);
//			Pattern tongYongNameRegex = Pattern.compile("^.*" + tongYongName+ ".*$", Pattern.CASE_INSENSITIVE); 
//			filterMap.put("tongYongMing", tongYongNameRegex);
			MongoCursor<org.bson.Document> dxy_app_drug_detail_deal_cursor = MongoUtil.iterator("dxy_app_drug_detail_deal_final",filterMap,null,false);
			while (dxy_app_drug_detail_deal_cursor.hasNext()) {
				org.bson.Document d = dxy_app_drug_detail_deal_cursor.next();
				String drugId = d.getString("drugId");
				String shangPinMing = d.getString("shangPinMing");
				String tongYongMingFromDxy = d.getString("tongYongMing");//这里仍用不去掉胶囊等字的通用名，为了以后辨别用。
				org.beiyi.entity.Drug drug = new org.beiyi.entity.Drug();
				drug.setId(drugId);
				drug.setTongYongName(tongYongMingFromDxy);
				drug.setShangPinName(shangPinMing);
				drugList.add(drug);
				
				temp_tongYongNameRegexList_toFile.add(tongYongMingFromDxy);
			}
		}
		temp_tongYongNameRegexList_toFile.add("");
		temp_tongYongNameRegexList_toFile.add("");
		try {
			FileUtils.writeLines(new File("C://temp_tongYongNameRegex.txt"), temp_tongYongNameRegexList_toFile,true);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return drugList;
	}
	private static void saveDrugAtcInfoDDI(List<String> subValues){
		Map<String, Object> query = new HashMap<String, Object>();
		Map<String, Object> or1 = new HashMap<String, Object>();
		Map<String, Object> or2 = new HashMap<String, Object>();
		
		String level = subValues.get(10);
		String type = subValues.get(11);
		or1.put("drugAName", subValues.get(0));
		or1.put("drugBName", subValues.get(5));
		or1.put("level", level);
		or1.put("type", type);
		
		or2.put("drugBName", subValues.get(0));
		or2.put("drugAName", subValues.get(5));
		or2.put("level", level);
		or2.put("type", type);
		
		
		
		List<Object> orList = new ArrayList<Object>();
		orList.add(or1);
		orList.add(or2);
		query.put("$or", orList);
		if(MongoUtil.has("drugAtcInfoDDI", query)){
			return;
		}
		Map<String, Object> saveMap = new LinkedHashMap<String, Object>();
		saveMap.put("drugAName", subValues.get(0));
		saveMap.put("drugAParseName", subValues.get(1));
		saveMap.put("drugAAtcNo", subValues.get(2));
		saveMap.put("drugAAtcChName", subValues.get(3));
		saveMap.put("drugAAtcEnName", subValues.get(4));
		
		saveMap.put("drugBName", subValues.get(5));
		saveMap.put("drugBParseName", subValues.get(6));
		saveMap.put("drugBAtcNo", subValues.get(7));
		saveMap.put("drugBAtcChName", subValues.get(8));
		saveMap.put("drugBAtcEnName", subValues.get(9));
		saveMap.put("level",level);
		saveMap.put("type",type);
		MongoUtil.saveDoc("drugAtcInfoDDI", saveMap);
	}
	private static Map<String, Object> saveDrugValidAtcInfo(String drugEnName,ATCInfo drugValidAtcInfo){
		String atcNo = drugValidAtcInfo.getNo();
		String atcChName = drugValidAtcInfo.getChName();
		String atcEnName = drugValidAtcInfo.getEnName();
		Map<String, Object> drugAtcInfo = new HashMap<String, Object>();
		drugAtcInfo.put("drugEnName", drugEnName);
		drugAtcInfo.put("drugEnNameDeal", StringUtils.substringBefore(drugEnName, " ["));
		drugAtcInfo.put("atcNo", atcNo);
		drugAtcInfo.put("atcChName", atcChName);
		drugAtcInfo.put("atcEnName", atcEnName);
		MongoUtil.saveDoc("drugAtcInfo", drugAtcInfo);
		return drugAtcInfo;
	}
	private static void filterValidAtcInfos(int limitLen) {
		Iterator<List<String>> atcItr = atcInfos.iterator();
		while (atcItr.hasNext()) {
			List<String> atcInfo = atcItr.next();
			if(StringUtils.isNotBlank(atcInfo.get(0)) && atcInfo.get(0).trim().length() == limitLen){
				continue;
			}
			atcItr.remove();
		}
	}
	static class ATCInfo{
		private String no;
		private String chName;
		private String enName;
		public ATCInfo(String no, String chName, String enName) {
			super();
			this.no = no;
			this.chName = chName;
			this.enName = enName;
		}
		public String getNo() {
			return no;
		}
		public void setNo(String no) {
			this.no = no;
		}
		public String getChName() {
			return chName;
		}
		public void setChName(String chName) {
			this.chName = chName;
		}
		public String getEnName() {
			return enName;
		}
		public void setEnName(String enName) {
			this.enName = enName;
		}
	}
	private static List<ATCInfo> getValidAtcInfosByDrugEnName(String drugEnName){
		drugEnName = StringUtils.substringBefore(drugEnName, " [");
		List<ATCInfo> validAtcInfos = new ArrayList<MicroEffectDeal.ATCInfo>();
		for (List<String> atcInfo : atcInfos) {
			String[] atcInfoArr = atcInfo.get(2).trim().toUpperCase().split(" ");
			for (String atcInfoEach : atcInfoArr) {
				if(atcInfoEach.equalsIgnoreCase(drugEnName.toUpperCase())){
					validAtcInfos.add(new ATCInfo(atcInfo.get(0).trim(), atcInfo.get(1).trim(), atcInfo.get(2).trim()));
				}
			}
		}
		return validAtcInfos;
	}
	private static void exportToExcel() {
		List<String> cells = new ArrayList<String>();
		List<List<String>> values = new ArrayList<List<String>>();
		cells.add("TITLE");
		cells.add("CONTENT");

		MongoCursor<org.bson.Document> cursor = MongoUtil.iterator(
				"micromedex_dreg_detail");
		int totalCount = MongoUtil.getCount("micromedex_dreg_detail");
		int currCount = 1;
		while (cursor.hasNext()) {
			System.out.println(currCount+++"/"+totalCount);
			org.bson.Document doc = cursor.next();
			String title = doc.getString("title");
			title = title.replaceAll("/", "_");
			String html = MongoUtil.getStringParsedValue(doc, "html");
			if (html.length() <= 3912){
				System.out.println(title); 
				continue;
			}
			/*List<String> subValues = new ArrayList<String>();
			subValues.add(title);
			subValues.add(Jsoup.parse(html).text());
			values.add(subValues);*/
			/*try {
				FileUtils.writeStringToFile(new File(
						"D://爱客服/北医三院/数据/micromedex_drug_detail/" + title
								+ ".html"), html, Charset
						.forName("utf-8"));
			} catch (IOException e) {
				e.printStackTrace();
			}*/
		}
		// ExcelUtil.export("D://爱客服/北医三院/数据/micromedex_drug_detail.xls", cells,
		// values);
	}

	private static void getDrugEffectMaterial() {
		MongoCursor<org.bson.Document> cursor = MongoUtil
				.iterator("micromedex_dreg_effect_html");
		MongoUtil.dropCollection("micromedex_dreg_effect_material");
		while (cursor.hasNext()) {
			org.bson.Document doc = cursor.next();
			String name = doc.getString("name");
			String html = MongoUtil.getStringParsedValue(doc, "html");
			if (html.contains("相互作用物质")) {
				Document d = Jsoup.parse(html);
				Elements effectMaterials = d.select("span:contains(相互作用物质)");
				for (Element effectM : effectMaterials) {
					String interactWithTextDeal = effectM.parent().text();
					String interactWithTextBefore = StringUtils.substringBefore(interactWithTextDeal, "interact(s)").trim();
					
					String effectMHtml = effectM.nextElementSibling().html();
					String[] effectMs = effectMHtml.split("<br>");
					List<String> effectMsList = new ArrayList<String>();
					for (int i = 0; i < effectMs.length; i++) {
						if (StringUtils.isNotBlank(effectMs[i])) {
							effectMsList.add(effectMs[i].replace("\n", "")
									.trim());
						}
					}
					String title = effectM.parent().parent()
							.select(".linkDetails").first().text();
					String level = effectM.parent().parent().nextElementSibling()
							.select(">div>a:eq(1)").text().trim();
					Map<String, Object> map = new LinkedHashMap<String, Object>();
					map.put("name", name);
					if(titleSplit2Map(interactWithTextBefore,map, title) == null){
						continue;
					}
//					map.put("title_eq_name_flag", 
//							(map.get("a")!=null ? name.equalsIgnoreCase(map.get("a").toString()) : false) ||
//							(map.get("b")!=null ? name.equalsIgnoreCase(map.get("b").toString()) : false));
					map.put("level", level);
					map.put("effectMs", effectMsList);
					MongoUtil.saveDoc("micromedex_dreg_effect_material", map);
				}
				
				Element yiChunTitleBarEle = d.select("tr:contains(Drug-乙醇)").first();
				
				int drugEffectAboutYiChunLen = yiChunTitleBarEle.nextElementSibling().select("th").size();
				if(drugEffectAboutYiChunLen>0){
					int whileMaxCount = 100;
					int whileCount = 1;
					Element lastEle = yiChunTitleBarEle;
					do{
						lastEle = lastEle.nextElementSibling();
						if(lastEle.select("td.emptySubsectionsDI,td.sectionTitleDI").size()>0){
							break;
						}
						if(lastEle.select("td:eq(0) .linkDetails").size()==0) continue;
						String title = lastEle.select("td:eq(0) .linkDetails").first().text();
						String level = lastEle
								.select("td:eq(1)>div>a:eq(1)").text().trim();
						Map<String, Object> map = new LinkedHashMap<String, Object>();
						map.put("name", name);
						
						if (title.contains("--")) {
							map.put("a", title.split("--")[0].trim());
							map.put("b", title.split("--")[1].trim());
						} else if(title.contains("-")) {
							map.put("a", title.split("-")[0].trim());
							map.put("b", title.split("-")[1].trim());
						}else{
							map.put("a_b", title);
							map.put("hasNoSpicialSymbol", 1);
						}
						
						map.put("level", level);
						map.put("type", "与乙醇相关的禁忌");
						MongoUtil.saveDoc("micromedex_dreg_effect_material", map);
						
					}
					while (whileCount++<whileMaxCount);
				}
			}
		}
	}
	private static Map titleSplit2Map(String interactWithTextBefore,Map map,String title){
		if (title.contains("--")) {
			map.put("a", title.split("--")[0].trim());
			map.put("b", title.split("--")[1].trim());
		} else if(title.contains("-")) {
			map.put("a", title.split("-")[0].trim());
			map.put("b", title.split("-")[1].trim());
		}else{
			map.put("a_b", title);
			map.put("hasNoSpicialSymbol", 1);
		}
		String effectMsWith = null;
		if(map.get("a")!=null && map.get("b")!=null ){
			if(map.get("a").toString().equalsIgnoreCase(interactWithTextBefore)){
				effectMsWith = map.get("a").toString();
				
				
			}else if(map.get("b").toString().equalsIgnoreCase(interactWithTextBefore)){
				effectMsWith = map.get("b").toString();
				
				//a,b置换位置，保证a是药品，b是分类
				String a = map.get("a").toString();
				map.put("b", a);
				map.put("a", effectMsWith);
			}
			if(effectMsWith == null){
				return null;
			}
		}else{
			return null;
		}
		return map;
	}
	private static void getMedicineInteractions() throws IOException {
		List<String> meditionNames = FileUtils.readLines(new File(
				"D://meditionNames.txt"), "utf-8");
		outter: for (int i = 0; i < meditionNames.size(); i++) {
			String meditionNameI = meditionNames.get(i);
			Map<String, Object> queryCountMap = new HashMap<String, Object>();
			queryCountMap.put("a", meditionNameI);
			if (MongoUtil.getCount(micromedex_dreg_effect, queryCountMap) > 0) {
				log.info("--exists a:" + meditionNameI);
				continue;
			}
			try {
				List<String> meditionNameList = new ArrayList<String>();
				meditionNameList.add(meditionNameI);
				log.info("start a:" + meditionNameI
						+ " getMedicineInteractions");
				String isValid = getMedicineInteractions(meditionNameList);
				if (isValid != null) {
					if (isValid.replaceFirst("errIndex", "").equals("0")) {
						continue outter;
					} else {
						continue;
					}
				}
				log.info("end a:" + meditionNameI + " getMedicineInteractions");
			} catch (Exception e) {
				log.error("-- ERROR EFEECT : meditionNameI:" + meditionNameI
						+ "\t" + " is error");
				e.printStackTrace();
			}
			log.info("剩餘 ： " + (meditionNames.size() - (i + 1)));
		}
	}

	private static boolean checkSessionAndReLogin(String html) {
		BasicCookieStore cookieStore = new BasicCookieStore();
		CloseableHttpClient httpClient = HttpClients.custom()
				.setDefaultCookieStore(cookieStore).build();
		if (html.contains("Your session has timed out. Please log in again")) {
			try {
				String content = HttpUtil.get(httpClient,
						"http://www.micromedexsolutions.com/home/dispatch",
						null);
				// FileUtils.writeStringToFile(new File("D://result01.txt"),
				// content,"utf-8");

				content = HttpUtil
						.get(httpClient,
								"http://www.micromedexsolutions.com/micromedex2/librarian/",
								null);
				// FileUtils.writeStringToFile(new File("D://result02.txt"),
				// content,"utf-8");

				content = HttpUtil
						.get(httpClient,
								"http://www.micromedexsolutions.com/micromedex2/librarian/CS/B01939/ND_PR/evidencexpert/ND_P/evidencexpert/DUPLICATIONSHIELDSYNC/42F49C/ND_PG/evidencexpert/ND_B/evidencexpert/ND_AppProduct/evidencexpert/ND_T/evidencexpert/PFActionId/evidencexpert.IntermediateToDocumentLink?docId=466580&contentSetId=100&title=Physostigmine+Salicylate&servicesTitle=Physostigmine+Salicylate&topicId=null#",
								null);
				FileUtils.writeStringToFile(new File("D://result03.txt"),
						content, "utf-8");

				/*
				 * List<Cookie> cookies = cookieStore.getCookies();
				 * ArrayList<Map<String, Object>> diyCookies = new
				 * ArrayList<Map<String,Object>>(); for (int i = 0; i <
				 * cookies.size(); i++) { Map<String,Object> diyCookieMap = new
				 * HashMap<String, Object>();
				 * diyCookieMap.put(cookies.get(i).getName(),
				 * cookies.get(i).getValue()); Iterator<Map<String, Object>>
				 * iterator = diyCookies.iterator();//做sesion驅蟲處理 while
				 * (iterator.hasNext()) { Map<String, Object> next =
				 * iterator.next();
				 * if(next.get(cookies.get(i).getName())!=null){
				 * iterator.remove(); break; } } diyCookies.add(diyCookieMap); }
				 */

				String cookieStr = HttpUtil.parseCookieToStr(cookieStore);
				headers.put("Cookie", cookieStr.toString());
				log.info("--update Cookie: " + cookieStr);
			} catch (Exception e) {
				log.error("--update Cookie fail: ");
				e.printStackTrace();
			} finally {
				try {
					if (httpClient != null)
						httpClient.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return true;
		}
		return false;
	}

	static MongoPersistent mongoPersistent = new MongoPersistent(
			micromedex_dreg_detail);

	private static String searchKeyForInteractions(List<String> meditionNames)
			throws IOException, Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for (int i = 0; i < meditionNames.size(); i++) {
			String meditionName = meditionNames.get(i);
			String key = searchKeyForInteractions(meditionName);
			if (key.contains("null"))
				return "errIndex" + i;
			sb.append(key).append(",");
		}
		sb.append("]");
		return StringUtils.replaceFirst(sb.toString(), ",]", "]").replaceAll(
				"\"", "'");
	}

	private static String searchKeyForInteractions(String meditionName)
			throws IOException, Exception {
		final String searchUrl = "http://www.micromedexsolutions.com/micromedex2/librarian/PFDefaultActionId/evidencexpert.AjaxSearch?searchType=diName&channel=drug&SearchTerm=^%s&randomNum=4144&LoadLimit=0";
		String searchResultJsonStr = HttpUtil.get(
				String.format(searchUrl, meditionName), headers);

		if (checkSessionAndReLogin(searchResultJsonStr)) {
			searchResultJsonStr = HttpUtil.get(
					String.format(searchUrl, meditionName), headers);
		}

		JSONArray searchResultArrayJson = JSONArray
				.fromObject(searchResultJsonStr);
		String key0 = null;
		String key1 = null;
		if (searchResultArrayJson != null && searchResultArrayJson.size() > 1) {
			JSONArray arr = (JSONArray) searchResultArrayJson.get(1);
			if (arr != null && arr.size() == 5) {
				if (arr.get(0).equals(arr.get(2))
						&& arr.get(0).equals(meditionName)) {
					key0 = arr.get(1).toString();
					key1 = arr.get(3).toString();
				}
			}
		}
		List<String> meditionKeys = new ArrayList<String>();
		meditionKeys.add(key0);
		meditionKeys.add(meditionName.replaceAll(" ", "+"));
		meditionKeys.add(meditionName.replaceAll(" ", "+"));
		meditionKeys.add(key1);
		return JSONArray.fromObject(meditionKeys).toString();
	}

	/**
	 * 药物相互作用
	 * 
	 * @return
	 * @throws Exception
	 * @throws IOException
	 */
	private static String getMedicineInteractions(List<String> meditionNames)
			throws IOException, Exception {
		String interactionsKeyParam = searchKeyForInteractions(meditionNames);
		if (interactionsKeyParam.contains("errIndex"))
			return interactionsKeyParam;
		final String medicineInterractionUrl = "http://www.micromedexsolutions.com/micromedex2/librarian/PFDefaultActionId/evidencexpert.ShowDrugInteractionsResults";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("CS", "1AEBBA");
		params.put("ND_PR", "evidencexpert");
		params.put("ND_P", "evidencexpert");
		params.put("DUPLICATIONSHIELDSYNC", "9D4ACF");
		params.put("ND_PG", "evidencexpert");
		params.put("ND_B", "evidencexpert");
		params.put("ND_AppProduct", "evidencexpert");
		params.put("ND_T", "evidencexpert");
		params.put("WordWheel_SearchTerm_index_0", "");
		params.put("WordWheel_ContentSetId_index_0", "107");
		params.put("WordWheel_ItemId_index_0", "665300");
		params.put("WordWheel_MainSelected_index_0", "A+&+D");
		params.put("WordWheel_SecondarySelected_index_0", "");
		params.put("WordWheel_TermIndicator_index_0", "");
		params.put("selectedDrugs", interactionsKeyParam);
		params.put("selectedAllergies_index_0", "");
		params.put("unmappedAllergies", "");
		params.put("unmappedDrugs", "");

		String result = HttpUtil.doHttpPost(medicineInterractionUrl, params,
				headers);
		if (checkSessionAndReLogin(result)) {
			result = HttpUtil.doHttpPost(medicineInterractionUrl, params,
					headers);
		}
		Document doc = Jsoup.parse(result);
		Elements diDrugTitles = doc.select("#diDrugTitles");
		for (Element diDrugElement : diDrugTitles) {
			String childTitle = diDrugElement.text();
			Element diDrugLinkElement = diDrugElement.parent();
			String href = StringUtils.substringBetween(
					diDrugLinkElement.attr("onclick"), ",'", "')");
			Element trElement = diDrugLinkElement.parents().select("tr")
					.first();
			String level = trElement.select("td:eq(1)>div>img").first()
					.attr("alt");
			String summarize = trElement.select("td:eq(3)").first().text();
			String title = null;
			int limitCount = 30;
			int currCount = 0;
			while (++currCount < limitCount) {
				Element trPre = trElement.previousElementSibling();
				Element titleElement = trElement.previousElementSibling()
						.select(".sectionTitleDI").first();
				if (titleElement != null) {
					title = titleElement.text();
					break;
				} else {
					trElement = trPre;
				}
			}
			System.out.println(title + "\t" + href + level);
			String effectHtm = HttpUtil.get(href, headers);
			Map<String, Object> doc_micromedex_dreg_effect = new HashMap<String, Object>();
			doc_micromedex_dreg_effect.put("level", level);
			doc_micromedex_dreg_effect.put("title", title);
			doc_micromedex_dreg_effect.put("childTitle", childTitle);
			doc_micromedex_dreg_effect.put("href", href);
			doc_micromedex_dreg_effect.put("summarize", summarize);
			doc_micromedex_dreg_effect.put("effectHtm", effectHtm);
			doc_micromedex_dreg_effect.put("a", meditionNames.get(0));
			doc_micromedex_dreg_effect.put("b", meditionNames.get(1));
			MongoUtil.saveDoc(micromedex_dreg_effect,
					doc_micromedex_dreg_effect);
		}
		return null;
	}
	/**
	 * drugAtcInfoDDI集合导出到excel
	 */
	private static void drugAtcInfoDDIExport(){
		List<String> cells = new ArrayList<String>();
		List<List<String>> values = new ArrayList<List<String>>();
		cells.add("A药品英文名(Micro)");
		cells.add("A药品英文名转换后(Micro)");
		cells.add("A药品匹配到的ATC编码");
		cells.add("A药品匹配到的ATC中文名");
		cells.add("A药品匹配到的ATC英文名");
		
		cells.add("B药品英文名(Micro)");
		cells.add("B药品英文名转换后(Micro)");
		cells.add("B药品匹配到的ATC编码");
		cells.add("B药品匹配到的ATC中文名");
		cells.add("B药品匹配到的ATC英文名");
		
		cells.add("级别");
		cells.add("类型(是否是乙醇)");
		MongoCursor<org.bson.Document> cursor = MongoUtil.iterator("drugAtcInfoDDI");
		while (cursor.hasNext()) {
			org.bson.Document doc = cursor.next();
			String drugAName = doc.getString("drugAName");
			String drugAParseName = doc.getString("drugAParseName");
			String drugAAtcNo = doc.getString("drugAAtcNo");
			String drugAAtcChName = doc.getString("drugAAtcChName");
			String drugAAtcEnName = doc.getString("drugAAtcEnName");
			
			String drugBName = doc.getString("drugBName");
			String drugBParseName = doc.getString("drugBParseName");
			String drugBAtcNo = doc.getString("drugBAtcNo");
			String drugBAtcChName = doc.getString("drugBAtcChName");
			String drugBAtcEnName = doc.getString("drugBAtcEnName");
			
			String level = doc.getString("level");
			String type = doc.getString("type");
			
			List<String> subValues = new ArrayList<String>();
			subValues.add(drugAName);
			subValues.add(drugAParseName);
			subValues.add(drugAAtcNo);
			subValues.add(drugAAtcChName);
			subValues.add(drugAAtcEnName);
			
			subValues.add(drugBName);
			subValues.add(drugBParseName);
			subValues.add(drugBAtcNo);
			subValues.add(drugBAtcChName);
			subValues.add(drugBAtcEnName);
			
			subValues.add(level);
			subValues.add(type);
			values.add(subValues);
		}
		ExcelUtil.export("D://爱客服/数据_ALL/北医三院/数据/数据处理/DDI.xls", cells, values);
	}
	/**
	 * drugAtcInfoDDIWithDXY集合导出到excel
	 */
	private static void drugAtcInfoDDIWithDXYExport(){
		List<String> cells = new ArrayList<String>();
		List<List<String>> values = new ArrayList<List<String>>();
		cells.add("A药品英文名(Micro)");
		cells.add("A药品英文名转换后(Micro)");
		cells.add("A药品匹配到的ATC编码");
		cells.add("A药品匹配到的ATC中文名");
		cells.add("A药品匹配到的ATC英文名");
		cells.add("A药品匹配到的丁香园药品(商品名)");
		cells.add("A药品匹配到的丁香园药品(通用名)");
		
		cells.add("B药品英文名(Micro)");
		cells.add("B药品英文名转换后(Micro)");
		cells.add("B药品匹配到的ATC编码");
		cells.add("B药品匹配到的ATC中文名");
		cells.add("B药品匹配到的ATC英文名");
		cells.add("B药品匹配到的丁香园药品(商品名)");
		cells.add("B药品匹配到的丁香园药品(通用名)");
		cells.add("级别");
		
		MongoCursor<org.bson.Document> cursor = MongoUtil.iterator("drugAtcInfoDDIWithDXY");
		while (cursor.hasNext()) {
			org.bson.Document doc = cursor.next();
			String drugAName = doc.getString("drugAName");
			String drugAParseName = doc.getString("drugAParseName");
			String drugAAtcNo = doc.getString("drugAAtcNo");
			String drugAAtcChName = doc.getString("drugAAtcChName");
			String drugAAtcEnName = doc.getString("drugAAtcEnName");
			String dxyDrugAShangPinMing = doc.getString("dxyDrugAShangPinMing");
			String dxyDrugATongYongMing = doc.getString("dxyDrugATongYongMing");
			
			String drugBName = doc.getString("drugBName");
			String drugBParseName = doc.getString("drugBParseName");
			String drugBAtcNo = doc.getString("drugBAtcNo");
			String drugBAtcChName = doc.getString("drugBAtcChName");
			String drugBAtcEnName = doc.getString("drugBAtcEnName");
			String dxyDrugBShangPinMing = doc.getString("dxyDrugBShangPinMing");
			String dxyDrugBTongYongMing = doc.getString("dxyDrugBTongYongMing");
			
			String level = doc.getString("level");
			
			List<String> subValues = new ArrayList<String>();
			subValues.add(drugAName);
			subValues.add(drugAParseName);
			subValues.add(drugAAtcNo);
			subValues.add(drugAAtcChName);
			subValues.add(drugAAtcEnName);
			subValues.add(dxyDrugAShangPinMing);
			subValues.add(dxyDrugATongYongMing);
			subValues.add(drugBName);
			subValues.add(drugBParseName);
			subValues.add(drugBAtcNo);
			subValues.add(drugBAtcChName);
			subValues.add(drugBAtcEnName);
			subValues.add(dxyDrugBShangPinMing);
			subValues.add(dxyDrugBTongYongMing);
			subValues.add(level);
			values.add(subValues);
		}
		
		ExcelUtil.export("D://爱客服/数据_ALL/北医三院/数据/数据处理/DDI(与丁香园药品关联).xls", cells, values);
	}
}
