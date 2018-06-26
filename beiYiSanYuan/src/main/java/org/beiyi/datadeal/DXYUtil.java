package org.beiyi.datadeal;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.bson.Document;
import org.jsoup.Jsoup;
import org.skynet.frame.base.SkynetMongoDocument;

public class DXYUtil {
	public static String getString(Document doc, String fieldName,
			boolean byInfoList) {
		return getString(doc, fieldName, byInfoList, false);
	}

	public static String getString(Document doc, String fieldName,
			boolean byInfoList, boolean onlyText) {
		String fieldValue = null;
		if (byInfoList) {
			fieldValue = getFieldValueFromArray(doc, "infoList", "cnName",
					fieldName, "value");
		} else {
			fieldValue = doc.getString(fieldName);
		}
		if (StringUtils.isBlank(fieldValue)) {
			return "无";
		}
		if (onlyText) {
			fieldValue = Jsoup.parse(fieldValue).text();
		}
		return fieldValue;
	}

	private static String getFieldValueFromArray(Document doc,
			String arrayName, String fieldName, String fieldNameValue,
			String fieldValueName) {
		String fieldValue = null;
		List<Map<String, Object>> infoList = SkynetMongoDocument.getArray(doc,
				arrayName);
		if(infoList == null) return null;
		for (Map<String, Object> map : infoList) {
			if (map.get(fieldName).toString().equals(fieldNameValue)) {
				fieldValue = map.get(fieldValueName).toString();
				break;
			}
		}
		if (fieldValue == null) {
			// log.error(String
			// .format("[%s] fieldValue is blank!", fieldNameValue));
		}
		return fieldValue;
	}
}
