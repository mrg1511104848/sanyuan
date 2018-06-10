package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.github.crab2died.ExcelUtils;

/**
 * 北医三院提供的15种药的demo，提取成图谱需要的格式
 * @author 2bu
 *
 */
public class ShuoMingShuDemoDeal {
	private static final String syzSplitRegex = "；|;";
	public static void main(String[] args) {
		try {
			ShuoMingShuDemoDeal.deal2Neo4j();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		}
	}
	private static void deal2Neo4j() throws IOException, InvalidFormatException {
		Map<String, Object> neo4jMap = new HashMap<String, Object>();
		neo4jMap.put("概要名称", "药品");
		
		List<Map<String, Object>> drugList = new ArrayList<Map<String,Object>>();
		neo4jMap.put("节点列表", drugList);
		List<String> shuoMingShuFields = loadShuoMingShuFields();
		List<String> drugUniqueNameList = new ArrayList<String>();
		Set<String> allShiYingZhengList = new HashSet<String>();
		// 1)
        // 不基于注解,将Excel内容读至List<List<String>>对象内
        List<List<String>> records = ExcelUtils.getInstance().readExcel2List("D://爱客服/数据_ALL/北医三院/三院提供/20180418说明书提取框架&demo新.xlsx",0,10000,0);
		for (int i = 3; i < 49; i++) {
			Map<String, Object> drug = new LinkedHashMap<String, Object>();
			drug.put("节点域名", "药品");
			drug.put("节点标签", new ArrayList<Object>());
			Map<String, String> drugDetailInfo = new HashMap<String, String>();
			if(records.get(i).size()!=49) continue;
			
			List<String> shuoMingShuRecords = records.get(i);
			
			List<String> shiYingZhengList = getShiYingZhengList(shuoMingShuRecords);
			allShiYingZhengList.addAll(shiYingZhengList);
			
			String uniqueName = shuoMingShuRecords.get(0)+"&huilian&"+shuoMingShuRecords.get(1);
			if(drugUniqueNameList.contains(uniqueName)){
				continue;
			}else{
				drugUniqueNameList.add(uniqueName);
			}
			for (int f = 0 ; f < shuoMingShuFields.size(); f++) {
				drugDetailInfo.put(shuoMingShuFields.get(f), shuoMingShuRecords.get(f));
			}
			drug.put("节点属性表",drugDetailInfo);
			drug.put("关键属性名", "通用名");
			drugList.add(drug);
		}
		for (String syz : allShiYingZhengList) {
			if(StringUtils.isBlank(syz)){
				continue;
			}
			Map<String, String> drugDetailInfo = new HashMap<String, String>();
			drugDetailInfo.put("通用名", syz);
			Map<String, Object> drug = new LinkedHashMap<String, Object>();
			drug.put("节点域名", "适应症");
			drug.put("节点标签", new ArrayList<Object>());
			drug.put("节点属性表",drugDetailInfo);
			drug.put("关键属性名", "通用名");
			drugList.add(drug);
		}
		List<Map<String, Object>> shiYingZhengRelations = dealShiYingZheng2Neo4j(records);
		neo4jMap.put("关系列表", shiYingZhengRelations);
		String neo4jDataJson = JSONObject.fromObject(neo4jMap).toString();
		FileUtils.writeStringToFile(new File("D://爱客服/北医三院/数据/数据处理/medicine.data.json2"), neo4jDataJson,Charset.forName("utf-8"));
		System.out.println("success!");
	}
	private static List<Map<String, Object>> dealShiYingZheng2Neo4j(List<List<String>> records) throws InvalidFormatException, IOException{
		List<Map<String, Object>> shiYingZhengRelations = new ArrayList<Map<String,Object>>();
		for (int i = 3; i < 49; i++) {
			List<String> list = records.get(i);
			List<String> shiYingZhengList = getShiYingZhengList(list);
			for (String syz : shiYingZhengList) {
				if(StringUtils.isBlank(syz)){
					continue;
				}
				Map<String, Object> childShiYingZhengRelation = new HashMap<String, Object>();
				childShiYingZhengRelation.put("关系域名", "药品_适应症");
				childShiYingZhengRelation.put("源节点关键属性", list.get(0));
				childShiYingZhengRelation.put("目标节点关键属性", syz);
				childShiYingZhengRelation.put("是否有向", true);
				childShiYingZhengRelation.put("关系属性定义", new HashMap<>());
				childShiYingZhengRelation.put("关系标签",new ArrayList<>());
				childShiYingZhengRelation.put("关系属性表",new ArrayList<>());
				shiYingZhengRelations.add(childShiYingZhengRelation);
			}
		}
		return shiYingZhengRelations;
	}
	private static List<String> getShiYingZhengList(List<String> shuoMingShuRecords){
		String syz = shuoMingShuRecords.get(20);
		String syzExt = shuoMingShuRecords.get(21);
		String[] syzArr  = syz.split(syzSplitRegex);
		String[] syzExtArr  = syzExt.split(syzSplitRegex);
		
		List<String> shiYingZhengList = new ArrayList<String>();
		if(syzArr!=null)
			shiYingZhengList.addAll(Arrays.asList(syzArr));
		if(syzExtArr!=null)
			shiYingZhengList.addAll(Arrays.asList(syzExtArr));
		return shiYingZhengList;
	}
	private static List<String> loadShuoMingShuFields() throws IOException{
		Resource resource1 = new ClassPathResource("shuomingshu_fields.txt");
	    File file = resource1.getFile(); //获取file对象
	    List<String> fields = FileUtils.readLines(file,Charset.forName("utf-8"));
	    return fields ;
	}
}
