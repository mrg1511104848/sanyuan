package org.beiyi.datadeal;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.bson.Document;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.mongo.MongoUtil;

import com.mongodb.client.MongoCursor;

/**
 * icd10处理
 * @author 2bu
 *
 */
public class ICDDeal {
	public static void main(String[] args) {
		exportDb2Excel();
	}
	/**
	 * 导出db中的icd10到excel
	 */
	public static void exportDb2Excel(){
		Map<String, String> icd10versionMap = DxyShuoMingShuIndicationDeal.loadICD10VersionMap();
		List<String> cells = new ArrayList<String>();
		cells.add("诊断编码");
		cells.add("诊断名称");
		cells.add("版本");
		List<List<String>> values = new ArrayList<List<String>>();
		
		MongoCursor<Document> icdCursor = MongoUtil.iterator("wechat_icd");
		while (icdCursor.hasNext()) {
			Document doc = icdCursor.next();
			String code = doc.getString("code");
			String name = doc.getString("name");
			String version = doc.getString("version");
			version = icd10versionMap.get(version);
			List<String> subValues = new ArrayList<String>();
			subValues.add(code);
			subValues.add(name);
			subValues.add(version);
			values.add(subValues);
		}
		ExcelUtil.export("D://爱客服/数据_ALL/北医三院/数据/数据处理/微信ICD10.xls", cells , values);
	}
}
