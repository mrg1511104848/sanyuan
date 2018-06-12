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

import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.skynet.frame.persistent.MongoPersistent;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.http.HttpUtil;
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
		 getDrugEffectMaterial();
	}
	static List<List<String>> atcInfos = null;
	static{
		try {
			atcInfos = ExcelUtils.getInstance().readExcel2List("C://公司/北医三院/atc(药物分类)编码.xls");
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
			
			
			List<ATCInfo> drugAValidAtcInfos = getValidAtcInfosByDrugEnName(drugA);
			if(drugAValidAtcInfos.size() == 0){
				log.warn(drugA+"'s drugAValidAtcInfos not found");
				continue;
			}
			for (ATCInfo drugAValidAtcInfo : drugAValidAtcInfos) {
				saveDrugValidAtcInfo(drugA,drugAValidAtcInfo);
			}
			
			String type = doc.getString("type");
			Object effectMs = doc.get("effectMs");
			if(effectMs!=null){//代表是类别
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
						subValues.add(StringUtils.substringBefore(drugA, " ["));
						subValues.add(drugAValidAtcInfo.getNo());
						subValues.add(drugAValidAtcInfo.getChName());
						subValues.add(drugAValidAtcInfo.getEnName());
						for (ATCInfo drugBValidAtcInfo : classBDrugEachValidAtcInfos) {
							subValues.add(drugInClassBEach);
							subValues.add(StringUtils.substringBefore(drugInClassBEach, " ["));
							subValues.add(drugBValidAtcInfo.getNo());
							subValues.add(drugBValidAtcInfo.getChName());
							subValues.add(drugBValidAtcInfo.getEnName());
							subValues.add(doc.getString("level"));
							subValues.add(doc.getString("type"));
							
							Map<String, Object> drugAtcInfoDDI = new HashMap<String, Object>();
							drugAtcInfoDDI.put("DDIInfoList", subValues);
							MongoUtil.saveDoc("drugAtcInfoDDI", drugAtcInfoDDI);
							
							values.add(subValues);
						}
						
					}
					
					/*Map<String, Object> drugAtcInfoDDI = new HashMap<String, Object>();
					drugAtcInfoDDI.put("drugAEnName", drugA);
					drugAtcInfoDDI.put("drugBEnName", drugInClassBEach);
					
					MongoUtil.saveDoc("drugAtcInfoDDI", drugAtcInfoDDI);*/
				}
			}else if(type.equals("与乙醇相关的禁忌")){//乙醇相关的药品相互作用处理。
				
			}
		}
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
		List<ATCInfo> validAtcInfos = new ArrayList<MicroEffectDeal.ATCInfo>();
		for (List<String> atcInfo : atcInfos) {
			if(atcInfo.get(2).trim().contains(drugEnName)){
				validAtcInfos.add(new ATCInfo(atcInfo.get(0).trim(), atcInfo.get(1).trim(), atcInfo.get(2).trim()));
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
					titleSplit2Map(map, title);
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
						titleSplit2Map(map, title);
						map.put("level", level);
						map.put("type", "与乙醇相关的禁忌");
						MongoUtil.saveDoc("micromedex_dreg_effect_material", map);
						
					}
					while (whileCount++<whileMaxCount);
				}
			}
		}
	}
	private static Map titleSplit2Map(Map map,String title){
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
}
