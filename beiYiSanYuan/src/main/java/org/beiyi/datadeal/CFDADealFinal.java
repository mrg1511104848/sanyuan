package org.beiyi.datadeal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.bson.Document;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.mongo.MongoUtil;

import com.mongodb.client.MongoCursor;

/**
 * cfda最后的处理程序
 * @author mrg
 *
 */
public class CFDADealFinal {
	private static Logger log = Logger.getLogger(CFDADealFinal.class);
	public static void main(String[] args) {
		dealFinal();
		
	}
	/**
	 * 将sfda_each_page_html_no_rep遍历，并取出商品名、本位码、生产公司、药品批准文号， 去drugfutureAndSupplementAll中查找。如果找到，则将结果封装到 cfda_final中
	 */
	public static void dealFinal(){
		List<Document> docs = MongoUtil.findDocList("sfda_each_page_html_no_rep");
		for (Document doc : docs) {
			String html = doc.getString("html");
			
			Elements elements = Jsoup.parse(html).select("a:contains(国药)");
			for (Element element : elements) {
				String drugEach = element.text();
				//3.龟黄补酒() (86901890000654；86901890000661；86901890000678 远大医药黄石飞云制药有限公司 国药准字Z20026072)
//				drugEach = "18338.诺氟沙星胶囊 (86901689000124 江苏中天药业有限公司　 国药准字H32020896)";
				List<String> moreInfos = RegexUtils.getByGroup("[（\\(]([\\d；;]*[\\s　]*[\u4e00-\u9fa5\\(（\\)））·〇\\- \\+]+[\\s　]*国药.+?)[）\\)]+", drugEach);
				if(moreInfos.size() == 0 ){
					moreInfos = RegexUtils.getByGroup("[（\\(]([\\d；;]*[\\s　]*[\u4e00-\u9fa5\\(（\\)））\\d\\.·〇-]+公司+[\\s　]*国药.+)", drugEach);
				}
				if(moreInfos.size() == 0 ){
					log.error("[href] > "+ doc.getInteger("href")+" more info err >"+drugEach);
					continue;
				}
				String moreInfo = moreInfos.get(0);
				String spm = StringUtils.substringBetween(drugEach, ".", moreInfo);
				if(StringUtils.isBlank(spm)){
					log.error("[href] > "+ doc.getInteger("href")+" spm blank err >"+drugEach);
					continue;
				}
				Map<String, Object> queryMap = new HashMap<String, Object>();
				String productName = spm.substring(0,spm.length()-1);
				if(StringUtils.isNotBlank(productName)){
					productName = productName.trim();
//					queryMap.put("productName", productName);
				}
				String[] moreInfoArr = moreInfo.split("[\\s　]+");
				String piZhunWenHao = moreInfoArr[moreInfoArr.length-1];
				if(StringUtils.isNotBlank(piZhunWenHao)){
					piZhunWenHao= piZhunWenHao.trim();
					piZhunWenHao = StringUtils.removeEnd(piZhunWenHao, "）");
					piZhunWenHao = StringUtils.removeEnd(piZhunWenHao, ")");
					queryMap.put("piZhunWenHao", piZhunWenHao);
				}
				List<String> manufactureFactoryRegexResult = RegexUtils.getByGroup("([\\s　]*[\u4e00-\u9fa5\\(（\\)））·〇\\- \\+].+?)[\\s　]+国药", moreInfo,1);
				String manufactureFactory=null;
				if(manufactureFactoryRegexResult.size()>0){
					manufactureFactory= manufactureFactoryRegexResult.get(0).trim();
//					queryMap.put("manufactureFactory", manufactureFactory);
				}
				String benWeiMa= RegexUtils.getByRegex("([\\d；;]*)", moreInfo);
				if(StringUtils.isNotBlank(benWeiMa)){
					benWeiMa = benWeiMa.trim();
//					queryMap.put("benWeiMa", benWeiMa);
				}
				if(queryMap.size() == 0 ){
					log.error("[href] > "+ doc.getInteger("href")+" queryMap.size() == 0  err >"+drugEach);
					continue;
				}
				if(MongoUtil.has("cfda_final", queryMap)){
					continue;
				}
				
				
				MongoCursor<Document> drugfutureFindResultCursor = MongoUtil.iterator("drugfutureAndSupplementAll", queryMap,null,true);
				Document drugfutureFindResult = null;
				while (drugfutureFindResultCursor.hasNext()) {
					Document next = drugfutureFindResultCursor.next();
					String dbBenWeiMa = next.getString("benWeiMa");
					
					if(dbBenWeiMa.equals(benWeiMa)){
						drugfutureFindResult = next;
						break;
					}
					
					String[] dbBenWeiMaArr = dbBenWeiMa.split("；|;");
					String[] benWeiMaArr = benWeiMa.split("；|;");
					out:
					for (String dbBWM : dbBenWeiMaArr) {
						for (String bwm : benWeiMaArr) {
							if(dbBWM.trim().equalsIgnoreCase(bwm.trim())){
								drugfutureFindResult = next;
								drugfutureFindResult.put("cfdaBenWeiMa", benWeiMa);
								drugfutureFindResult.put("cfdaProductName", productName);
								drugfutureFindResult.put("cfdaManufactureFactory", manufactureFactory);
								break out;
							}
						}
					}
				}
				if(drugfutureFindResult==null){
					log.error("[href] > "+ doc.getInteger("href")+" drugfutureAndSupplementAll find not result err >"+drugEach);
					continue;
				}
				
				
				MongoUtil.saveDoc("cfda_final", drugfutureFindResult);
				
				/*String[] moreInfoArr = moreInfo.split(" ");
				if(moreInfoArr.length!=3){
					log.error("drugEach != 3 >>"+drugEach);
				}*/
				
				
			}
		}
	}
}
