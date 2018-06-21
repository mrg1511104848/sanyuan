package org.beiyi.datadeal.yimaitong;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.management.InvalidAttributeValueException;

import org.apache.log4j.Logger;
import org.bson.Document;
import org.bson.types.Binary;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.skynet.frame.util.mongo.MongoUtil;
import org.skynet.frame.util.zlib.ZLib;

import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

public class YiMaiTongDeal {
	private static Logger log = Logger.getLogger(YiMaiTongDeal.class.getName());

	public static void main(String[] args) {
		getHtml();
	}

	private static void getHtml() {
		String[] encodeArr = { "GBK", "UTF-8" };
		String saveCollectioName = "yiMaiTongFinalAll_notFilter2_v2";
		MongoUtil.dropCollection(saveCollectioName);
		MongoCollection<Document> collection = MongoUtil
				.getCollection("url_task_list1");
		BasicDBObject params = new BasicDBObject();
		params.put("st", 2);
		params.put("taskName", "yimaitong");
		int totalCount = MongoUtil.getCount(collection, params);
		int nowCount = 0;
		MongoCursor<Document> iterator = collection.find(params).iterator();
		int errorCount = 0;
		while (iterator.hasNext()) {
			System.out.println(String.format("%s/%s", totalCount, ++nowCount));
			Document next = iterator.next();
			String url = next.getString("url");
//			url = "http://drugs.medlive.cn/drugref/html/2.shtml";
			Map<String, Object> saveMap = new LinkedHashMap<String, Object>();
			try {
				@SuppressWarnings("unchecked")
				Map<String, Object> runResult = (Map<String, Object>) next
						.get("runResult");
				byte[] bytes = ZLib.decompress(((Binary) runResult.get("html"))
						.getData());

				for (int j = 0; j < encodeArr.length; j++) {
					String html = new String((bytes), encodeArr[j]);
					YiMaiTongDetailEntity yiMaiTongDetailEntity = new YiMaiTongDetailEntity();
					yiMaiTongDetailEntity.testByHtml(html);
					List<String> titleList = yiMaiTongDetailEntity
							.getTitleList();
					List<String> moreInfomationList = yiMaiTongDetailEntity
							.getMoreInfomationList();
					
					List<String> moreInfomationListHtm = yiMaiTongDetailEntity
							.getMoreInfomationListHtm();
					if (titleList == null || moreInfomationList == null
							|| titleList.size() != moreInfomationList.size()) {
						log.info("titleList invalid || moreInfomationList invalid");
						continue;
					}

					//
					String medicineName = yiMaiTongDetailEntity.getName();
					if(!titleList.contains("药品名称：")){
						if (j == encodeArr.length - 1) {
							errorCount++;
							throw new InvalidAttributeValueException();
						}
						continue;
					}
					for (int i = 0; i < titleList.size(); i++) {
						String title = titleList.get(i);
						String moreInfomation = moreInfomationList.get(i);
						
						if(title.contains("所属类别：")){
							String moreInfomationHtm = moreInfomationListHtm.get(i);
							Elements allCatagoryElements = Jsoup.parse(moreInfomationHtm).select("p");
							List<String> catagoryList = new ArrayList<String>();
							for (Element catagoryEle : allCatagoryElements) {
								catagoryList.add(catagoryEle.text());
							}
							saveMap.put(title, catagoryList);
						}else{
							saveMap.put(title, moreInfomation);
						}
						
					}
					saveMap.put("medicineName", medicineName);
					saveMap.put("url", url);
					// if(!MongoUtil.has("yiMaiTongFinal",
					// "批准文号：",saveMap.get("批准文号：")))
					MongoUtil.saveDoc(saveCollectioName, saveMap);
					break;
				}
			} catch (Exception e) {
				// e.printStackTrace();
				saveMap.put("url", url);
				saveMap.put("error", e.getMessage());
				MongoUtil.saveDoc(saveCollectioName, saveMap);
			}
		}
		System.out.println("err:" + errorCount);
	}

}
