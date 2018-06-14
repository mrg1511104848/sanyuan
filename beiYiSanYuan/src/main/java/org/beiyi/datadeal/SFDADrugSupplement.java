package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONObject;

import org.apache.commons.collections4.ListUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.bson.Document;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.mongo.MongoUtil;

public class SFDADrugSupplement {
	private static Logger log = Logger.getLogger(SFDADrugSupplement.class);
	static String sfdaCheckCollectionPath = "C://公司/北医三院/";
	static{
		sfdaCheckCollectionPath = "D://爱客服/数据_ALL/北医三院/数据/数据处理";
	}
	public static void main(String[] args) throws IOException {
//		supplementBySFDA();
		deal2DrugfutureAndSupplementAll();
	}
	private static void filterDrugfutureMissingBitCodeList() throws IOException{
		List<String> allList = FileUtils.readLines(new File(sfdaCheckCollectionPath+"/sfda校验集.txt"),Charset.forName("utf-8"));
		List<String> drugfutureDeal = FileUtils.readLines(new File(sfdaCheckCollectionPath+"/drugfutureDeal.json"),Charset.forName("utf-8"));
		List<String> aList = new ArrayList<String>();
		List<SFDADrug>  drugs = new ArrayList<SFDADrugSupplement.SFDADrug>();
		for (String drugEach : allList) {
			
			String drugEachMainInfo = RegexUtils.getByGroup("[\\(（](.+)[\\)）]", drugEach,1).get(0);
			String[] mainInfoArr = drugEachMainInfo.split(" ");
			SFDADrug drug = new SFDADrug();
			String benWeiMaIds = mainInfoArr[0];
			String[] benWeiMaArr = benWeiMaIds.split("；|;");/**/
			
			for (String benWeiMa : benWeiMaArr) {
				if(StringUtils.isNotBlank(benWeiMa))
					drug.getBenWeiMaIds().add(benWeiMa);
			}
			if(drug.getBenWeiMaIds().size()==0){
//				log.warn(String.format("[drug] %s benWeiMaArr.length==0", drugEach));
			}
			/*if(mainInfoArr.length<=2){
				log.warn(String.format("[drug] %s mainInfoArr.length<=2", drugEach));
			}else{
				drug.setGyzz(mainInfoArr[2]);
			}*/
			int lastIdx = drugEach.lastIndexOf("国药");
			String gy = StringUtils.substring(drugEach, lastIdx, drugEach.length()-1);
			if(StringUtils.isBlank(gy)){
				FileUtils.writeStringToFile(new File(sfdaCheckCollectionPath+"/invalidSFDABenWeiMa.txt"), gy+"\n",Charset.forName("utf-8"),true);
				log.warn(String.format("[drug] %s StringUtils.isBlank(gy)", drugEach));
				continue;
			}
			if(gy.length()!=13){
				log.warn(String.format("[drug] %s the length of this bit code must be equal to 13 “%s”", drugEach,gy));
//				continue;
			}
			drugs.add(drug);
			drug.setGyzz(gy);
			aList.add(gy);
		}
		System.out.println(aList.size());
		System.out.println(drugs.size());
		System.out.println();
		
		List<String> bList = new ArrayList<String>();
		for (String drugfutureJson : drugfutureDeal) {
			JSONObject drugfutureJsonObj = JSONObject.fromObject(drugfutureJson);
//			String benWeiMa = drugfutureJsonObj.getString("benWeiMa");
			String piZhunWenHao = drugfutureJsonObj.getString("piZhunWenHao");
//			List<String> benWeiMaIds = new ArrayList<String>();
//			benWeiMaIds.add(benWeiMa);
			
			/*if(!gyzzList.contains(piZhunWenHao)){
				log.error(String.format("[drug] %s not exists", drug));
			}*/
			bList.add(piZhunWenHao);
		}
		List<Document> drugfutureSupplementList = MongoUtil.findDocList("drugfutureSupplementDeal");
		for (Document drugfutureSupplementDoc : drugfutureSupplementList) {
			String piZhunWenHao = drugfutureSupplementDoc.getString("piZhunWenHao");
			bList.add(piZhunWenHao);
		}
		for (String drugfutureJson : drugfutureDeal) {
			JSONObject drugfutureJsonObj = JSONObject.fromObject(drugfutureJson);
//			String benWeiMa = drugfutureJsonObj.getString("benWeiMa");
			String piZhunWenHao = drugfutureJsonObj.getString("piZhunWenHao");
//			List<String> benWeiMaIds = new ArrayList<String>();
//			benWeiMaIds.add(benWeiMa);
			
			/*if(!gyzzList.contains(piZhunWenHao)){
				log.error(String.format("[drug] %s not exists", drug));
			}*/
			bList.add(piZhunWenHao);
		}
		
		List<String> drugfutureMissingBitCodeList = ListUtils.subtract(aList, bList);
		Set<String> filterDrugfutureMissingBitCodeListV2 = new HashSet<String>();
		for (String drugfutureMissingBitCode : drugfutureMissingBitCodeList) {
			filterDrugfutureMissingBitCodeListV2.add(drugfutureMissingBitCode);
		}
		
		System.out.println("drugfutureMissingBitCodeList.size() : "+drugfutureMissingBitCodeList.size());
		System.out.println("filterDrugfutureMissingBitCodeList.size() : "+filterDrugfutureMissingBitCodeListV2.size());
		
		
		List<String> filterDrugfutureMissingBitCodeListV3 = new ArrayList<String>();
		Map<String, Set<String>> guoYaoAndHrefMap = loadGuoYaoAndHrefMap();
		for (String filterDrugfutureMissingBitCode : filterDrugfutureMissingBitCodeListV2) {
			Set<String> hrefList = guoYaoAndHrefMap.get(filterDrugfutureMissingBitCode);
			for (String href : hrefList) {
				filterDrugfutureMissingBitCodeListV3.add(filterDrugfutureMissingBitCode+" "+href);
			}
		}
		FileUtils.writeLines(new File(sfdaCheckCollectionPath+"/filterDrugfutureMissingBitCodeListV2.txt"), filterDrugfutureMissingBitCodeListV2);
		FileUtils.writeLines(new File(sfdaCheckCollectionPath+"/filterDrugfutureMissingBitCodeListV3.txt"), filterDrugfutureMissingBitCodeListV3);
	}
	public static void dealSupplementBySFDA() throws IOException{
		List<Document> docList = MongoUtil.findDocList("drugfutureSupplementBySFDA");
		for (Document drugfutureSupplementBySFDADoc : docList) {
			if(drugfutureSupplementBySFDADoc!=null){
				String h = drugfutureSupplementBySFDADoc.getString("html");
				if(StringUtils.isNotBlank(Jsoup.parse(h).select("body").text())){
					continue;
				}else{
					MongoUtil.delete("drugfutureSupplementBySFDA", "href", drugfutureSupplementBySFDADoc.getString("href"));
				}
			}
		}
	}
	public static void supplementBySFDA() throws IOException{
		System.setProperty("webdriver.chrome.driver",
				"E://学习分享/新建文件夹/chromedriver.exe");
		
		//取消 chrome正受到自动测试软件的控制的信息栏  
        ChromeOptions options = new ChromeOptions();  
        options.addArguments("disable-infobars"); 
        
		WebDriver driver = new ChromeDriver(options);
		List<String> filterDrugfutureMissingBitCodeListV3 = FileUtils.readLines(new File(sfdaCheckCollectionPath+"/filterDrugfutureMissingBitCodeListV3.txt"),Charset.forName("utf-8"));
		for (String filterDrugfutureMissingBitCode : filterDrugfutureMissingBitCodeListV3) {
			String href = filterDrugfutureMissingBitCode.split(" ")[1];
			
			Document drugfutureSupplementBySFDADoc  = MongoUtil.findOne("drugfutureSupplementBySFDA", "href", href);
			if(drugfutureSupplementBySFDADoc!=null){
				String h = drugfutureSupplementBySFDADoc.getString("html");
				if(StringUtils.isNotBlank(Jsoup.parse(h).select("body").text())){
					continue;
				}else{
					MongoUtil.delete("drugfutureSupplementBySFDA", "href", href);
				}
			}
			log.info("start get Href > "+href);
			for (int i = 0; i < 10; i++) {
				driver.get(href);
				if(htmlReourceIsBlank(driver.getPageSource())){
					log.error(String.format("The html of href “%s” is blank ", href));
					try {
						Thread.sleep(5000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}else{
					break;
				}
			}
			log.info("end get Href > "+href);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("href", href);
			map.put("html", driver.getPageSource());
			String hrefId = StringUtils.substringAfter(href,"&Id=");
//			FileUtils.writeStringToFile(new File(sfdaCheckCollectionPath+"/drugfutureSupplementBySFDA/"+hrefId+".txt"), driver.getPageSource(),Charset.forName("utf-8"));
			MongoUtil.saveDoc("drugfutureSupplementBySFDA", map);
			
			try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		driver.quit();
	}
	private static void deal2DrugfutureAndSupplementAll(){
		MongoUtil.cpCollection("drugfutureDeal", "drugfutureAndSupplementAll");
		MongoUtil.cpCollection("drugfutureSupplementDeal", "drugfutureAndSupplementAll");
	}
	private static boolean htmlReourceIsBlank(String pageSource){
		if(pageSource!=null){
			org.jsoup.nodes.Document pageSourceDoc = Jsoup.parse(pageSource);
			String bodyText = pageSourceDoc.select("body").text();
			if(StringUtils.isBlank(bodyText)){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
					 
		}
	}
	public static Map<String, Set<String>> loadGuoYaoAndHrefMap(){
		Map<String, Set<String>> guoYaoAndHrefMap = new HashMap<String, Set<String>>();
		List<Document> docs = MongoUtil.findDocList("sfda_each_page_html_no_rep");
		for (Document doc : docs) {
			String html = doc.getString("html");
			Elements elements = Jsoup.parse(html).select("a:contains(国药)");
			for (Element element : elements) {
				String drugEach = element.text();
				int lastIdx = drugEach.lastIndexOf("国药");
				String gy = StringUtils.substring(drugEach, lastIdx, drugEach.length()-1);
				String href = StringUtils.substringBetween(element.attr("href"), "javascript:commitForECMA(callbackC,'","',null)");
				if(StringUtils.isBlank(href)){
					log.error(element.text());
					continue;
				}
				href = "http://app1.sfda.gov.cn/datasearch/face3/"+href;
				Set<String> gySet = guoYaoAndHrefMap.get(gy);
				if(gySet == null){
					guoYaoAndHrefMap.put(gy, new HashSet<String>());
				}
				guoYaoAndHrefMap.get(gy).add(href);
			}
		}
		return guoYaoAndHrefMap;
	}
	public static List<String> getIntersection(List<String> list1,
            List<String> list2) {
        List<String> result = new ArrayList<String>();
        for (String l2 : list2) {//遍历list1
            if (list1.contains(l2)) {//如果存在这个数
                result.add(l2);//放进一个list里面，这个list就是交集
            }
        }
        return result;
    }
	static class SFDADrug{
		private List<String> benWeiMaIds = new ArrayList<String>();
		private String gyzz;
		
		public SFDADrug() {
			super();
		}

		public String getGyzz() {
			return gyzz;
		}

		public void setGyzz(String gyzz) {
			this.gyzz = gyzz;
		}

		public List<String> getBenWeiMaIds() {
			return benWeiMaIds;
		}

		public void setBenWeiMaIds(List<String> benWeiMaIds) {
			this.benWeiMaIds = benWeiMaIds;
		}
		
	}
}
