package org.beiyi.util;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;

public class Neo4jBuildUtil {
	private static Map<String, Object> neo4jMap = new HashMap<String, Object>();
	private static List<Map<String, Object>> nodeList = new ArrayList<Map<String,Object>>();
	private static List<Map<String, Object>> relations = new ArrayList<Map<String,Object>>();
	private static List<String> relationUniqueList = new ArrayList<String>();
	private static List<String> nodeUniqueList = new ArrayList<String>();
	static{
		neo4jMap.put("概要名称", "医药数据库");
		neo4jMap.put("节点列表", nodeList);
		neo4jMap.put("关系列表", relations);
	}
	public static List<Map<String, Object>> getNodeList() {
		return nodeList;
	}

	public static void setNodeList(List<Map<String, Object>> nodeList) {
		Neo4jBuildUtil.nodeList = nodeList;
	}
	public static List<Map<String, Object>> getRelations() {
		return relations;
	}
	public static void setRelations(List<Map<String, Object>> relations) {
		Neo4jBuildUtil.relations = relations;
	}
	public static void writeNeo4jDataTo(String targetPath) throws IOException{
		String neo4jDataJson = JSONObject.fromObject(neo4jMap).toString();
		FileUtils.writeStringToFile(new File(targetPath), neo4jDataJson,Charset.forName("utf-8"));
	}
	public static void addToNeo4j(String nodeAreaName,List<String> titles,List<String> values,String pivotalFieldName,String uniqueKeyword){
		Map<String, Object> element = new LinkedHashMap<String, Object>();
		element.put("节点域名", nodeAreaName);
		element.put("节点标签", new ArrayList<Object>());
		Map<String, String> drugDetailInfo = new HashMap<String, String>();
		for (int i = 0; i < titles.size(); i++) {
			drugDetailInfo.put(titles.get(i), values.get(i));
		}
		element.put("节点属性表",drugDetailInfo);
		element.put("关键属性名", pivotalFieldName);
		if(nodeUniqueList.contains(nodeAreaName+uniqueKeyword)) return;
		nodeUniqueList.add(nodeAreaName+uniqueKeyword);
		Neo4jBuildUtil.getNodeList().add(element);
	}
	public static void addRelationToNeo4j(String nodeAreaName,String srcNodeAttr,String tartNodeAttr){
		Map<String, Object> relation = new HashMap<String, Object>();
		relation.put("关系域名", nodeAreaName);
		relation.put("源节点关键属性", srcNodeAttr);
		relation.put("目标节点关键属性", tartNodeAttr);
		relation.put("是否有向", true);
		relation.put("关系属性定义", new HashMap<>());
		relation.put("关系标签",new ArrayList<>());
		relation.put("关系属性表",new ArrayList<>());
		
		if(relationUniqueList.contains(nodeAreaName+srcNodeAttr+tartNodeAttr)){
			return;
		}
		relationUniqueList.add(nodeAreaName+srcNodeAttr+tartNodeAttr);
		relations.add(relation);
	}
}
