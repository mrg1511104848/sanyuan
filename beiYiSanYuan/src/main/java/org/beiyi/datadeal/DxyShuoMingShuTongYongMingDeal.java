package org.beiyi.datadeal;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.bson.Document;
import org.jsoup.Jsoup;
import org.skynet.frame.util.mongo.MongoUtil;


/**
 * 用于统计说明书中通用名共有多少个
 * @author 2bu
 *
 */
public class DxyShuoMingShuTongYongMingDeal {
	public static void main(String[] args) {
		Set<String> commonNameSet = new HashSet<String>();
		List<Document> document = MongoUtil.findDocList("dxy_app_drug_detail_simple");
		for (Document d : document) {
			String commonName=  d.getString("commonName");
			if(commonName.equals("无")) continue;
			commonNameSet.add(Jsoup.parse(commonName).text());
		}
		
		Set<String> totalCommonNameSet = new HashSet<String>();
		
		document = MongoUtil.findDocList("drugfutureAndSupplementAll");
		for (Document d : document) {
			String commonName=  d.getString("productName");
			if(commonName == null || commonName.equals("无")) continue;
			totalCommonNameSet.add(Jsoup.parse(commonName).text());
		}
		System.out.println("统计: 丁香园:"+commonNameSet.size()+"，总量:"+totalCommonNameSet.size()+"个");
	}
}
