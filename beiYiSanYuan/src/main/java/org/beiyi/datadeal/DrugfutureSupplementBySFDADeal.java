package org.beiyi.datadeal;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.beiyi.datadeal.entity.DrugfutureSupplementBySFDA;
import org.bson.Document;
import org.jsoup.Jsoup;
import org.skynet.frame.annotation.Path;
import org.skynet.frame.base.SkynetEntity;
import org.skynet.frame.util.mongo.MongoUtil;

/**
 * 集合drugfutureSupplementBySFDA的处理
 * @author mrg
 *
 */
public class DrugfutureSupplementBySFDADeal {
	private static Logger log = Logger.getLogger(DrugfutureSupplementBySFDADeal.class);
	public static void main(String[] args) {
		deal2StandardField();
//		String html  = MongoUtil.findOne("drugfutureSupplementBySFDA", "href","http://app1.sfda.gov.cn/datasearch/face3/content.jsp?tableId=25&tableName=TABLE25&tableView=国产药品&Id=215763").getString("html");
	}
	
	/**
	 * 处理成标准的字段,处理后放到drugfutureSupplementBySFDADeal中
	 */
	public static void deal2StandardField(){
		List<Document> docs = MongoUtil.findDocList("drugfutureSupplementBySFDA");
		for (Document doc : docs) {
			String html = doc.getString("html");
			DrugfutureSupplementBySFDA cfda = new DrugfutureSupplementBySFDA();
			String href= doc.getString("href");
			cfda.setCurrHref(href);
			cfda.testByHtml(html);
			if(MongoUtil.has("drugfutureSupplementBySFDADeal", "currHref",href)){
				continue;
			}
			
			if(StringUtils.isBlank(cfda.getBenWeiMa())){
				log.error("href>>"+href+" benWeiMa is blank");
			}
			MongoUtil.saveBean("drugfutureSupplementBySFDADeal", cfda);
		}
		
	}
}
