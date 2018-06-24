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
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.beiyi.datadeal.MicroEffectDeal.ATCInfo;
import org.beiyi.entity.DDI;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.verify.ATCCode;
import org.beiyi.entity.verify.ICD10;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.reource.Resources;
import org.beiyi.util.InstructionsReadUtil;
import org.bson.Document;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.mongo.MongoUtil;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.github.crab2died.ExcelUtils;

/**
 * 说明书到neo4j格式的转换
 * 
 * @author 2bu
 *
 */
public class ShuoMingShuParseToNeo4j {
	private static Logger log = Logger.getLogger(ShuoMingShuParseToNeo4j.class);
	private static final String diseaseSplitRegex = "；|;";
	static List<List<String>> records = null;
	static String path = "D://爱客服/数据_ALL/北医三院/三院提供/";
	
	static Map<String, Object> neo4jMap = new HashMap<String, Object>();
	static List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
	static List<Map<String, Object>> relations = new ArrayList<Map<String,Object>>();
	static{
		neo4jMap.put("概要名称", "医药数据库");
		neo4jMap.put("节点列表", list);
		neo4jMap.put("关系列表", relations);
	}
	
	static {
		path = "C://公司/北医三院/";
		// 不基于注解,将Excel内容读至List<List<String>>对象内
		try {
			records = ExcelUtils.getInstance().readExcel2List(
					path+"20180418说明书提取框架&demo新.xlsx", 0,
					10000, 0);
		} catch (InvalidFormatException | IOException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) throws IOException, InvalidFormatException {
//		readShuoMingShuDiseaseICDMap();
		ShuoMingShuParseToNeo4j neo4j = new ShuoMingShuParseToNeo4j();
		neo4j.parseICD10ToNeo4j();
		neo4j.parseAllIndicationToNeo4j();
		neo4j.parseAllShuoMingShuContraindication();
		neo4j.parseShuoMingShuContraindicationRelation();
		String neo4jDataJson = JSONObject.fromObject(neo4jMap).toString();
		FileUtils.writeStringToFile(new File(path+"bysy.data.json"), neo4jDataJson,Charset.forName("utf-8"));
		System.out.println("success!");
	}
	/**
	 * 提取所有说明书的疾病
	 * 
	 * @return
	 */
	public Set<ICD10> getAllDisease() {
		Set<ICD10> allDiseases = new HashSet<ICD10>();
		allDiseases.addAll(getAllShuoMingShuDisease());
		allDiseases.addAll(getAllICD10());
		return allDiseases;
	}

	/**
	 * 提取所有说明书和ICD10的疾病
	 * 
	 * @return
	 */
	public List<ICD10> getAllShuoMingShuDisease() {
		List<ICD10> shiYingZhengList = new ArrayList<ICD10>();
		for (List<String> shuoMingShuRecord : records) {
			String syz = shuoMingShuRecord.get(20);
			String syzExt = shuoMingShuRecord.get(21);
			String[] syzArr = syz.split(diseaseSplitRegex);
			String[] syzExtArr = syzExt.split(diseaseSplitRegex);

			if (syzArr != null) {
				for (String syzEach : syzArr) {
					ICD10 icd10 = new ICD10();
					icd10.setName(syzEach);
					shiYingZhengList.add(icd10);
				}
			}
			if (syzExtArr != null) {
				for (String syzEach : syzExtArr) {
					ICD10 icd10 = new ICD10();
					icd10.setName(syzEach);
					shiYingZhengList.add(icd10);
				}
			}
		}
		return shiYingZhengList;
	}
	public void parseAllIndicationToNeo4j() throws InvalidFormatException, IOException{
		
		List<String> shuoMingShuFields = loadShuoMingShuFields();
		List<String> drugUniqueNameList = new ArrayList<String>();
		Set<String> allShiYingZhengList = new HashSet<String>();
		// 1)
        // 不基于注解,将Excel内容读至List<List<String>>对象内
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
			list.add(drug);
		}
		Map<String, String> indicationAndIcd10Map = parseShuoMingShuDiseaseICDToNeo4j();
		for (String syz : allShiYingZhengList) {
			if(StringUtils.isBlank(syz)){
				continue;
			}
			Map<String, String> drugDetailInfo = new HashMap<String, String>();
			drugDetailInfo.put("通用名", syz);
			
			/*DrugCombinationName syzParse = new DrugCombinationName(syz);
			String syzParsedName = syzParse.getShangPinName();
			String syzParsedCode = indicationAndIcd10Map.get(syzParsedName);
			if(syzParsedCode != null){
				drugDetailInfo.put("编码", syz);
			}*/
			Map<String, Object> drug = new LinkedHashMap<String, Object>();
			drug.put("节点域名", "适应症");
			drug.put("节点标签", new ArrayList<Object>());
			drug.put("节点属性表",drugDetailInfo);
			drug.put("关键属性名", "通用名");
			list.add(drug);
		}
		List<Map<String, Object>> shiYingZhengRelations = dealShiYingZheng2Neo4j(records);
		relations.addAll(shiYingZhengRelations);
	}
	private List<Map<String, Object>> dealShiYingZheng2Neo4j(List<List<String>> records) throws InvalidFormatException, IOException{
		Map<String, String> indicationAndIcd10Map = parseShuoMingShuDiseaseICDToNeo4j();
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
				
				
				DrugCombinationName syzParse = new DrugCombinationName(syz);
				String syzParsedName = syzParse.getShangPinName();
				String syzParsedCode = indicationAndIcd10Map.get(syzParsedName);
				if(syzParsedCode == null) continue;
				addRelationToNeo4j("适应症_ICD10", syz, syzParsedCode);
			}
		}
		return shiYingZhengRelations;
	}
	private static List<String> loadShuoMingShuFields() throws IOException{
		Resource resource1 = new ClassPathResource("shuomingshu_fields.txt");
	    File file = resource1.getFile(); //获取file对象
	    List<String> fields = FileUtils.readLines(file,Charset.forName("utf-8"));
	    return fields ;
	}
	
	private static List<String> getShiYingZhengList(List<String> shuoMingShuRecords){
		String syz = shuoMingShuRecords.get(20);
		String syzExt = shuoMingShuRecords.get(21);
		String[] syzArr  = syz.split(diseaseSplitRegex);
		String[] syzExtArr  = syzExt.split(diseaseSplitRegex);
		
		List<String> shiYingZhengList = new ArrayList<String>();
		if(syzArr!=null)
			shiYingZhengList.addAll(Arrays.asList(syzArr));
		if(syzExtArr!=null)
			shiYingZhengList.addAll(Arrays.asList(syzExtArr));
		return shiYingZhengList;
	}
	/**
	 * 提取所有说明书的禁忌
	 * 
	 * @return
	 */
	public List<Instruction> getAllShuoMingShuContraindication() {
		List<Instruction> instructions = InstructionsReadUtil.getInstructions();
		return instructions;
	}
	public void parseAllShuoMingShuContraindication() {
		List<Instruction> allList = getAllShuoMingShuContraindication();
		List<String> titles = new ArrayList<String>();
		titles.add("通用名");
		Set<String> allContraindications = new HashSet<String>();
		for (Instruction each : allList) {
			List<String> contraindications = each.getContraindications();
			allContraindications.addAll(contraindications);
		}
		for (String each : allContraindications) {
			List<String> values= new ArrayList<String>();
			values.add(each);
			addToNeo4j("禁忌", titles, values, "通用名");
		}
	}
	
	public void parseShuoMingShuContraindicationRelation() {
		List<Instruction> allList = getAllShuoMingShuContraindication();
		for (Instruction instruction : allList) {
			List<String> contraindications = instruction.getContraindications();
			for (String contraindication : contraindications) {
				addRelationToNeo4j("药品_禁忌", new DrugCombinationName(instruction.getDrugCombinationName()).getTongYongName(), contraindication);
			}
		}
	}
	/**
	 * 提取ICD10(疾病)
	 */
	public List<ICD10> getAllICD10() {
		List<ICD10> icd10List = new ArrayList<ICD10>();
		List<Document> docs = MongoUtil.findDocList("wechat_icd");
		for (Document document : docs) {
			String name = document.getString("name");
			String nameEn = document.getString("nameEn");
			String code = document.getString("code");
			String version = document.getString("version");

			String parentName = document.getString("_parentName");
			String parentNameEn = document.getString("_parentNameEn");
			String parentCode = document.getString("parent");

			ICD10 icd10 = new ICD10(code, name, nameEn, version, parentName,
					parentNameEn, parentCode);
			icd10List.add(icd10);
			
			
		}
		return icd10List;
	}
	
	public void parseICD10ToNeo4j(){
		List<Map<String, String>> shuoMingShuoDiseaseICDMap = readShuoMingShuDiseaseICDMap();
		for (Map<String, String> map : shuoMingShuoDiseaseICDMap) {
			String code = map.get("code").toString();
			while(true){
				Document document = MongoUtil.findOne("wechat_icd","code" , code.replaceAll("\\s*", "").split(";")[0]);
				if(document == null){
					log.error("The code “"+code+"” is not find!");
					break;
				}
				String name = document.getString("name");
				String nameEn = document.getString("nameEn");
				String version = document.getString("version");

				String parentName = document.getString("_parentName");
				String parentNameEn = document.getString("_parentNameEn");
				String parentCode = document.getString("parent");
				
				
				List<String> titles = new ArrayList<String>();
				titles.add("名称");
				titles.add("英文名");
				titles.add("编码");
				titles.add("版本");
				
				List<String> values = new ArrayList<String>();
				values.add(name);
				values.add(nameEn);
				values.add(code);
				values.add(Resources.getICD_VERSION_MAP().get(version));
				
				addToNeo4j("ICD10", titles, values, "编码");
				
				
				addRelationToNeo4j("ICD分类归属", code, parentCode);
				
				if(parentCode.equals("ICD-10")){
					break;
				}
				
				code = parentCode;
			}
		}
		
		/*List<ICD10> allICD10 = getAllICD10();
		for (ICD10 icd10 : allICD10) {
			
			String icdName = icd10.getName();
			String nameEn = icd10.getNameEn();
			String icdCode = icd10.getCode();
			String parentName = icd10.getParentName();
			
			List<String> titles = new ArrayList<String>();
			titles.add("名称");
			titles.add("英文名");
			titles.add("编码");
			
			List<String> values = new ArrayList<String>();
			values.add(icdName);
			values.add(nameEn);
			values.add(icdCode);
			addToNeo4j("ICD10", titles, values, "名称");
			
			if(StringUtils.isNotBlank(parentName) && !parentName.equals("null")){
				addRelationToNeo4j("ICD分类归属", icdName, parentName);
			}
		}*/
	}
	private void addToNeo4j(String nodeAreaName,List<String> titles,List<String> values,String pivotalFieldName){
		Map<String, Object> element = new LinkedHashMap<String, Object>();
		element.put("节点域名", nodeAreaName);
		element.put("节点标签", new ArrayList<Object>());
		Map<String, String> drugDetailInfo = new HashMap<String, String>();
		for (int i = 0; i < titles.size(); i++) {
			drugDetailInfo.put(titles.get(i), values.get(i));
		}
		element.put("节点属性表",drugDetailInfo);
		element.put("关键属性名", pivotalFieldName);
		list.add(element);
	}
	private void addRelationToNeo4j(String nodeAreaName,String srcNodeAttr,String tartNodeAttr){
		Map<String, Object> relation = new HashMap<String, Object>();
		relation.put("关系域名", nodeAreaName);
		relation.put("源节点关键属性", srcNodeAttr);
		relation.put("目标节点关键属性", tartNodeAttr);
		relation.put("是否有向", true);
		relation.put("关系属性定义", new HashMap<>());
		relation.put("关系标签",new ArrayList<>());
		relation.put("关系属性表",new ArrayList<>());
		relations.add(relation);
	}
	/**
	 * 提取ATC(药品成分)
	 */
	public List<ATCCode> getAllATC() {
		List<ATCCode> atcCodes = new ArrayList<ATCCode>();
		List<Document> docs = MongoUtil.findDocList("bysy_atc_code");
		for (Document doc : docs) {
			String enName = doc.getString("enName");
			String chName = doc.getString("chName");
			String atcNo = doc.getString("atcNo");

			ATCCode atcCode = new ATCCode(atcNo, chName, enName);
			atcCodes.add(atcCode);
		}
		return atcCodes;
	}

	/**
	 * 提取所有的药品间相互作用 过滤15种药品
	 * @return 
	 */
	public List<DDI> getAllDDI() {
		List<DDI> DDIList = new ArrayList<DDI>();
		List<Document> docs = MongoUtil.findDocList("drugAtcInfoDDIWithDXYV5");
		for (Document doc : docs) {
			String dxyDrugATongYongMing = doc.getString("dxyDrugATongYongMing");
			String dxyDrugAShangPinMing = doc.getString("dxyDrugAShangPinMing");
			String dxyDrugBTongYongMing = doc.getString("dxyDrugBTongYongMing");
			String dxyDrugBShangPinMing = doc.getString("dxyDrugBShangPinMing");
			String level = doc.getString("level");
			
			DDI ddi = new DDI(dxyDrugATongYongMing, dxyDrugAShangPinMing, dxyDrugBTongYongMing, dxyDrugBShangPinMing, level);
			DDIList.add(ddi);
		}
		return DDIList;
	}

	/**
	 * 提取所有的人群
	 */
	public void getAllCrowd() {
		
	}
	private static List<Map<String, String>> readShuoMingShuDiseaseICDMap(){
		List<Map<String, String>> icd10List = new ArrayList<Map<String, String>>();
		try {
			List<String> shuoMingShuDiseaseIcd10List = FileUtils.readLines(new File(path+"知识图谱 疾病对应ICD10.txt"),Charset.forName("utf-8"));
			for (String shuoMingShuDiseaseIcd10 : shuoMingShuDiseaseIcd10List) {
				if (StringUtils.isBlank(shuoMingShuDiseaseIcd10)) {
					continue;
				}
				String diseaseName = shuoMingShuDiseaseIcd10.split(" ")[0];
				String icd10 = shuoMingShuDiseaseIcd10.split(" ")[1];
				Map<String, String> map = new HashMap<String, String>();
				map.put("name", diseaseName);
				map.put("code", icd10);
				icd10List.add(map);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return icd10List;
	}
	private static Map<String, String> parseShuoMingShuDiseaseICDToNeo4j(){
		List<Map<String, String>> shuoMingShuoDiseaseICDMap = readShuoMingShuDiseaseICDMap();
		Map<String, String> indicationAndIcdCodeMap = new HashMap<String, String>();
		for (Map<String, String> map : shuoMingShuoDiseaseICDMap) {
			String code = map.get("code").toString();
			String name = map.get("name").toString();
			indicationAndIcdCodeMap.put(name, code);
		}
		return indicationAndIcdCodeMap;
	}
	final static List<DrugCombinationName> testDrugNameList = new ArrayList<DrugCombinationName>();
	public static void loadTestDrugNameList() throws InvalidFormatException,
			IOException {
		List<List<String>> testDrugList = null;
		String path = "D://爱客服/数据_ALL/北医三院/三院提供/test drug list共163（航慈1-60，张琪61-120，亚希121-163）.xlsx";
		testDrugList = ExcelUtils.getInstance().readExcel2List(path);
		for (int i = 1; i < testDrugList.size(); i++) {
			List<String> drugList = testDrugList.get(i);
			String combinationName = drugList.get(1);
			if (StringUtils.isNotBlank(combinationName)) {
				DrugCombinationName drugCombinationName = new DrugCombinationName(combinationName);
				testDrugNameList.add(drugCombinationName);
			}
		}
	}
	
	
}
