package org.beiyi.datadeal.databaseDeal;

import java.util.Map;

import org.bson.Document;
import org.skynet.frame.util.mongo.MongoUtil;

/**
 * 移动到线上数据库
 * @author 2bu
 *
 */
public class DBCopyToProductionEv {
	public static void main(String[] args) {
//		copy();
		Document doc = MongoUtil.findOne("url_task_list", "url","http://drugs.medlive.cn/drugref/html/11240.shtml");
		Object runResult = doc.get("runResult");
		Document d = (Document)(runResult);
		String html = MongoUtil.getStringParsedValue(d, "html");
		System.out.println(html);
	}
	public static void copy(){
//		String collection = "wechat_icd";
		String[] cpArr = {"yiMaiTongFinalStandard","bysy_atc_code","drugAtcInfoDDIWithDXYV5","dxy_app_drug",
				"dxy_app_drug_detail","dxy_app_drug_detail_deal_final","fanyi","micromedex_dreg_detail",
				"micromedex_dreg_detail_supplement","micromedex_dregclass","drugfutureAndSupplementAll","bysy_config",
				};
		for (String cp : cpArr) {
			copy(cp);
		}
	}
	public static void copy(String collection){
		MongoUtil.cpCollection(collection,collection, "172.20.0.18", "172.20.0.18",
				"27017", "baidubaike_", "baidubaike_123", "27017", "bysy", "bysy_123", "huilanData", "bysy");
	}
	
}
