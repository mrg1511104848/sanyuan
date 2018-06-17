package org.beiyi.reource;

import java.util.HashMap;
import java.util.Map;

import org.bson.Document;
import org.skynet.frame.util.mongo.MongoUtil;

import com.mongodb.client.MongoCursor;

public class BysyConfig {
	private static Map<String, Object> resultMap ;
	static{
		readConfigs();
	}
	private static void readConfigs(){
		resultMap = new HashMap<String, Object>();
		MongoCursor<Document> configCursor = MongoUtil.iterator("bysy_config");
		while (configCursor.hasNext()) {
			Document doc = configCursor.next();
			String name = doc.getString("name");
			Object value = doc.get("value");
			resultMap.put(name, value);
		}
	}
	public static void reloadConfigs(){
		readConfigs();
	}
	public static Object getConfig(String name,String defaultValue){
		return resultMap.get(name) == null ? defaultValue : resultMap.get(name);
	}
}
