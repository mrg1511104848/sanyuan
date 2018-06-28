package org.beiyi.datadeal;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.poi.openxml4j.exceptions.InvalidOperationException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.skynet.frame.util.excel.ExcelUtils4Test;
import org.skynet.frame.util.mongo.MongoUtil;
import org.xml.sax.SAXException;

/**
 * 将ATC编码保存到DB中
 * @author 2bu
 *
 */
public class DealAtcCodeToDB {
	public static void main(String[] args) throws InvalidOperationException, IOException, OpenXML4JException, ParserConfigurationException, SAXException {
		saveAtcToMongo();
		
	}
	private static void saveAtcToMongo() throws InvalidOperationException, IOException, OpenXML4JException, ParserConfigurationException, SAXException{
		List<List<String>> atcList = ExcelUtils4Test.read("atc(药物分类)编码.xls", new FileInputStream(new File("D://爱客服/数据_ALL/北医三院/数据/atc(药物分类)编码.xls")), 0, 0, 6);
		for (int i = 1 ; i < atcList.size() ;i++) {
			List<String> list = atcList.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("atcNo", list.get(0));
			map.put("chName", list.get(1));
			map.put("enName", list.get(2));
			map.put("dosage", list.get(3));
			map.put("unit", list.get(4));
			map.put("wayOfTaking", list.get(5));
			MongoUtil.saveDoc("bysy_atc_code", map);
		}
	}
}
