package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.beiyi.entity.DDI;
import org.beiyi.entity.Drug;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.verify.ATCCode;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.reource.Resources;
import org.beiyi.util.ATCUtil;
import org.beiyi.util.InstructionsReadUtil;
import org.beiyi.util.Neo4jBuildUtil;
import org.bson.Document;
import org.skynet.frame.util.encrypt.MD5Util;
import org.skynet.frame.util.mongo.MongoUtil;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.github.crab2died.ExcelUtils;

/**
 * 说明书到neo4j格式的转换 version2
 * 
 * @author 2bu
 *
 */
public class ShuoMingShuParseToNeo4jVersion2 {
	private static Logger log = Logger.getLogger(ShuoMingShuParseToNeo4jVersion2.class);
	private static final String diseaseSplitRegex = "；|;";
	private static List<List<String>> records = null;
	private static String path = "D://爱客服/数据_ALL/北医三院/三院提供/";
	private static List<String> drugUniqueNameList = new ArrayList<String>();
	static {
//		path = "C://公司/北医三院/";
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
		//转换所有药品
		ShuoMingShuParseToNeo4jVersion2 shuoMingShuParseToNeo4jVersion2 = new ShuoMingShuParseToNeo4jVersion2();
		shuoMingShuParseToNeo4jVersion2.parseMedicines();
		shuoMingShuParseToNeo4jVersion2.parseYongFaNodeAndDiseaseRelation();
		shuoMingShuParseToNeo4jVersion2.parseICD10ToNeo4j();
		shuoMingShuParseToNeo4jVersion2.dealShiYingZheng2Neo4j(records);
		shuoMingShuParseToNeo4jVersion2.parseMainIngredients();
		shuoMingShuParseToNeo4jVersion2.getAllDDI();
		shuoMingShuParseToNeo4jVersion2.getAllATC();
//		shuoMingShuParseToNeo4jVersion2.parseAllDDI(atcCodes);
		Neo4jBuildUtil.writeNeo4jDataTo(path+"bysy.data.json");
		
		/*List<Instruction> instructions = shuoMingShuParseToNeo4jVersion2.getAllShuoMingShu();
		for (Instruction instruction : instructions) {
			String combinationName = instruction.getDrugCombinationName();
			DrugCombinationName drugCombinationName = new DrugCombinationName(combinationName);
			List<ATCCode> atcCodes = shuoMingShuParseToNeo4jVersion2.getAllDrugIngredients(drugCombinationName);
		}*/
	}
	/*private void parseAllDDI(List<ATCCode> atcCodes) {
		for (int i = 0; i < atcCodes.size(); i++) {
			ATCCode atcCodeI = atcCodes.get(i);
			for (int j = 0; j < atcCodes.size(); j++) {
				ATCCode atcCodeJ = atcCodes.get(j);
				Map<String, Object> query = new HashMap<String, Object>();//"drugAAtcNo" : "C09AA01"	
				query.put("drugAAtcNo", atcCodeI.getAtcNo());
				query.put("drugBAtcNo", atcCodeJ.getAtcNo());
				Document result0 = MongoUtil.findOne("drugAtcInfoDDI", query);
				if(result0!=null){
					List<String> effectLevelTitles = new ArrayList<String>();
					effectLevelTitles.add("ID");
					effectLevelTitles.add("级别名称");
					
					List<String> effectLevelValues = new ArrayList<String>();
					effectLevelValues.add("ATC_XHZY_LEVEL_"+MD5Util.encode(atcCodeI.getAtcNo()+atcCodeJ.getAtcNo()));
					Neo4jBuildUtil.addToNeo4j("ATC相互作用级别", effectLevelTitles, effectLevelValues, 
							pivotalFieldName, uniqueKeyword);
					continue;
				}
				query = new HashMap<String, Object>();
				query.put("drugAAtcNo", atcCodeJ.getAtcNo());
				query.put("drugBAtcNo", atcCodeI.getAtcNo());
				Document result1 = MongoUtil.findOne("drugAtcInfoDDI", query);
				
				
			}
		}
	}*/
	public void parseICD10ToNeo4j(){
		List<String> titles = new ArrayList<String>();
		titles.add("名称");
		titles.add("英文名");
		titles.add("编码");
		titles.add("版本");
		
		List<String> values0 = new ArrayList<String>();
		values0.add("ICD-10");
		values0.add("ICD-10");
		values0.add("ICD-10");
		values0.add(Resources.getICD_VERSION_MAP().get("0"));
		Neo4jBuildUtil.addToNeo4j("ICD10", titles, values0, "编码","ICD-10");
		
//		List<String> uniqueList = new ArrayList<String>();
		List<Map<String, String>> shuoMingShuoDiseaseICDMap = readShuoMingShuDiseaseICDMap();
		for (Map<String, String> map : shuoMingShuoDiseaseICDMap) {
			String code = map.get("code").toString();
			while(true){
				Document document = MongoUtil.findOne("wechat_icd","code" , code.replaceAll("\\s*", "").split(";")[0]);
				if(document == null){
					log.error("The code “"+code+"” is not find!");
					break;
				}
				if(code.equals("I00-I99")){
					System.out.println();
				}
				String name = document.getString("name");
				String nameEn = document.getString("nameEn");
				String version = document.getString("version");

//				String parentName = document.getString("_parentName");
//				String parentNameEn = document.getString("_parentNameEn");
				String parentCode = document.getString("parent");
				
				
				
				List<String> values = new ArrayList<String>();
				values.add(name);
				values.add(nameEn);
				values.add(code);
				values.add(Resources.getICD_VERSION_MAP().get(version));
				
				String unique = name+code;
					Neo4jBuildUtil.addToNeo4j("ICD10", titles, values, "编码",unique);
					Neo4jBuildUtil.addRelationToNeo4j("ICD分类归属", code, parentCode);
				if(parentCode.equals("ICD-10")){
					break;
				}
				code = parentCode;
			}
		}
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
				DrugCombinationName syzParse = new DrugCombinationName(syz);
				String syzParsedName = syzParse.getShangPinName();
				String syzParsedCode = indicationAndIcd10Map.get(syzParsedName);
				if(syzParsedCode == null) continue;
				Neo4jBuildUtil.addRelationToNeo4j("适应症_ICD10", syz, syzParsedCode);
			}
		}
		return shiYingZhengRelations;
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
	/**
	 * 某药品的用法用量、以及对应的疾病的关系
	 */
	private void parseYongFaNodeAndDiseaseRelation() {
		List<String> yfylTitles = new ArrayList<String>();
		yfylTitles.add("ID");
		yfylTitles.add("所属药品");
		yfylTitles.add("剂量选择");
		yfylTitles.add("患者状态");
		yfylTitles.add("用量");
		yfylTitles.add("单位");
		yfylTitles.add("用药频率");
		yfylTitles.add("给药途径");
		yfylTitles.add("疗程控制");
		yfylTitles.add("适应症");
		List<String> diagnosiseTitles = new ArrayList<String>();
		diagnosiseTitles.add("名称");
		List<String> contraindicationTitles = new ArrayList<String>();
		contraindicationTitles.add("名称");
		
//		List<String> syzUniqueList = new ArrayList<String>();
//		List<String> jinjiUniqueList = new ArrayList<String>();
		String[] keywords = {"痛","疼","炎","热","感"};
		StringBuffer diseasePtn = new StringBuffer();
		for (String k : keywords) {
			diseasePtn.append(".*" + k + ".*|");
		}
		String strDiseasePtn = diseasePtn.substring(0, diseasePtn.length() - 1);
		
 		List<Instruction> allShuoMingShu = getAllShuoMingShu();
		for (Instruction instruction : allShuoMingShu) {
			String drugCombinationName = instruction.getDrugCombinationName();
			DrugCombinationName combinationName = new DrugCombinationName(drugCombinationName);
			String tongYongName = combinationName.getTongYongName();
			List<InstructionUse> instructionUses = instruction.getInstructionUses();
			List<String> diagnosisesOld = instruction.getDiagnosises();
			List<String> diagnosisesNew = new ArrayList<String>();
			Iterator<String> diagnosisesItr = diagnosisesOld.iterator();
			while (diagnosisesItr.hasNext()) {
				String diagnosise = diagnosisesItr.next();
				if(diagnosise.startsWith("（提取处方所有")){
					continue;
				}
				String newDiagnosise = diagnosise;
				if(diagnosise.endsWith("病")){
					newDiagnosise = diagnosise.substring(0,diagnosise.length()-1);
				}
				diagnosisesNew.add(newDiagnosise);
			}
			//临时处理
			if(tongYongName.equals("酚麻美敏片")){
				Map<String, Object> filter = new HashMap<String, Object>();
				Pattern DiseasePtn = Pattern.compile(strDiseasePtn, Pattern.CASE_INSENSITIVE); 
				filter.put("drugName", "泰诺片(酚麻美敏片)");
				filter.put("disease", DiseasePtn);
				List<Document> docs = MongoUtil.findDocList("bysy_chufang_drug_disease", filter);
				for (Document doc : docs) {
					String disease = doc.getString("disease");
					if(disease.endsWith("病")){
						disease = disease.substring(0,disease.length()-1);
					}
					diagnosisesNew.add(disease);
				}
			}
			for (String diagnosise : diagnosisesNew) {
				List<String> diagnosiseValues = new ArrayList<String>();
				diagnosiseValues.add(diagnosise);
				Neo4jBuildUtil.addToNeo4j("适应症", diagnosiseTitles, diagnosiseValues, "名称",diagnosise);
			}
			List<String> contraindications = instruction.getContraindications();
			for (String contraindication : contraindications) {
				List<String> contraindicationValues = new ArrayList<String>();
				if(contraindication.endsWith("病")){
					contraindication = contraindication.substring(0,contraindication.length()-1);
				}
				contraindicationValues.add(contraindication);
				
				Neo4jBuildUtil.addToNeo4j("禁忌", contraindicationTitles, contraindicationValues, "名称",contraindication);
				
				Neo4jBuildUtil.addRelationToNeo4j("药品_禁忌", tongYongName, contraindication);
			}
			for (int i = 0; i < instructionUses.size(); i++) {
				InstructionUse instructionUse = instructionUses.get(i);
				String dosageSelection = instructionUse.getDoseSelection();
				String patientStatus = instructionUse.getPatientStatus();
				String dosage = instructionUse.getDosage();
				String dosageUnit = instructionUse.getDosageUnit();
				String dosingFrequency = instructionUse.getDosingFrequency();
				String routeOfMedication = instructionUse.getRouteOfMedication();
				String courseControl = instructionUse.getCourseControl();
				String yongFaYongLiangUnique = "YFYL_"+MD5Util.encode(drugCombinationName+"用法用量"+i);
				
				List<String> yfylValues = new ArrayList<String>();
				yfylValues.add(yongFaYongLiangUnique);
				yfylValues.add(combinationName.getCombinationName());
				yfylValues.add(dosageSelection);
				yfylValues.add(patientStatus);
				yfylValues.add(dosage);
				yfylValues.add(dosageUnit);
				yfylValues.add(dosingFrequency);
				yfylValues.add(routeOfMedication);
				yfylValues.add(courseControl);
				StringBuffer diagnosisesBuffer = new StringBuffer();
				for (String diagnosise : diagnosisesNew) {
					Neo4jBuildUtil.addRelationToNeo4j("用法用量_适应症", yongFaYongLiangUnique, diagnosise);
					diagnosisesBuffer.append(diagnosise+";");
				}
				yfylValues.add(diagnosisesBuffer.toString());
				Neo4jBuildUtil.addToNeo4j("用法用量", yfylTitles, yfylValues, "ID",yongFaYongLiangUnique);
				Neo4jBuildUtil.addRelationToNeo4j("药品_用法用量", tongYongName, yongFaYongLiangUnique);
				
				
			}
		}
	}
	/**
	 * 加载所有药品
	 * @throws IOException 
	 */
	private void parseMedicines() throws IOException{
		List<String> shuoMingShuFields = loadShuoMingShuFields();
		// 1)
        // 不基于注解,将Excel内容读至List<List<String>>对象内
		for (int i = 3; i < 49; i++) {
			Map<String, Object> drug = new LinkedHashMap<String, Object>();
			drug.put("节点域名", "药品");
			drug.put("节点标签", new ArrayList<Object>());
			Map<String, String> drugDetailInfo = new HashMap<String, String>();
			if(records.get(i).size()!=49) continue;
			
			List<String> shuoMingShuRecords = records.get(i);
			
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
			Neo4jBuildUtil.getNodeList().add(drug);
		}
	}
	private List<ATCCode> parseMainIngredients() {
		List<ATCCode> atcCodes = new ArrayList<ATCCode>();
		List<Document> bysy_drug_major_constituent = MongoUtil.findDocList("bysy_drug_major_constituent");
		List<String> titles = new ArrayList<String>();
		titles.add("名称");
		List<String> atcTitles = new ArrayList<String>();
		atcTitles.add("编码");
		atcTitles.add("中文名");
		atcTitles.add("英文名");
		
		for (Document bysy_drug_major_constituent_document : bysy_drug_major_constituent) {
//			String shangPinMing = bysy_drug_major_constituent_document.getString("shangPinMing");
			String tongYongMing = bysy_drug_major_constituent_document.getString("tongYongMing");
			String majorConstituents = bysy_drug_major_constituent_document.getString("major_constituent");
			String[] majorConstituentArr = majorConstituents.split(";|；|,|，");
			for (String majorConstituent : majorConstituentArr) {
				List<String> values = new ArrayList<String>();
				values.add(majorConstituent);
//				values.add(new DrugCombinationName(shangPinMing, tongYongMing).getCombinationName());
				Neo4jBuildUtil.addToNeo4j("主成分", titles, values, "名称",majorConstituent);
				Neo4jBuildUtil.addRelationToNeo4j("药品_主成分", tongYongMing, majorConstituent);
				
				Map<String, Object> query = new HashMap<String, Object>();
				query.put("chName", majorConstituent);
				Document resultDoc = MongoUtil.findOne("bysy_atc_code", query);
				if(resultDoc != null){
					ATCCode atcCode = new ATCCode(
							resultDoc.getString("atcNo"),
							resultDoc.getString("chName"),resultDoc.getString("enName"));
					atcCodes.add(atcCode);
					buildAtcRelationByAtcCode(atcCode);
					Neo4jBuildUtil.addRelationToNeo4j("主成分_ATC", majorConstituent, resultDoc.getString("atcNo"));
				}
			}
		}
		return atcCodes;
	}
	static Map<org.bson.Document, List<String>> drugIdAndEnNameList;
	/**
	 * 获取一个药品的根据ATC匹配的成分
	 * @param drugCombinationName
	 * @return
	 */
	private List<ATCCode> getAllDrugIngredients(DrugCombinationName drugCombinationName){
		List<ATCCode> atcCodes = new ArrayList<ATCCode>(); 
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("shangPinMing", drugCombinationName.getShangPinName());
		filter.put("tongYongMing", drugCombinationName.getTongYongName());
		
		Document document = MongoUtil.findOne("dxy_app_drug_detail_deal_final",filter);
		String englishName = document.getString("englishName");
		String[] englishNameArr = englishName.split(" ");
//		List<String> enNameList = new ArrayList<String>();
		for (String enName : englishNameArr) {
			Map<String, Object> query = new HashMap<String, Object>();
			Map<String, Object> subQuery = new HashMap<String, Object>();
			subQuery.put("$regex", "^"+enName+"$");
			subQuery.put("$options", "i");
			query.put("enName", subQuery);
			Document resultDoc = MongoUtil.findOne("bysy_atc_code", query);
			if(resultDoc == null){
				continue;
			}
			ATCCode atcCode = new ATCCode();
			atcCode.setAtcNo(resultDoc.getString("atcNo"));
			atcCode.setChName(resultDoc.getString("chName"));
			atcCode.setEnName(resultDoc.getString("enName"));
			atcCodes.add(atcCode);
			System.out.println(drugCombinationName.getCombinationName()+"["+englishName+"] -> "+enName+" -> "+atcCode);
		}
		if(atcCodes.size() == 0){
			System.err.println(drugCombinationName.getCombinationName()+"["+englishName+"]"+" has no macthed ingredients");
		}
		return atcCodes;
	}
	private static List<org.beiyi.entity.Drug> getDrugList(String icd10DiseaseEnName){
		List<org.beiyi.entity.Drug> drugList = new ArrayList<Drug>();
		Iterator<Entry<org.bson.Document, List<String>>> itr = drugIdAndEnNameList.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<org.bson.Document, List<String>> entry = itr.next();
			List<String> enNameList = entry.getValue();
			org.bson.Document doc = entry.getKey();
			if(enNameList!=null){
				for (String enName : enNameList) {
					if(icd10DiseaseEnName.trim().equalsIgnoreCase(enName.trim())){
						Drug d = new Drug();
						d.setId(doc.getString("drugId"));
						d.setShangPinName(doc.getString("shangPinMing"));
						d.setTongYongName(doc.getString("tongYongMing"));
						d.setEnName(doc.getString("englishName"));
						d.getEffectCFList().add(enName);
						drugList.add(d);
					}
				}
			}
		}
		return drugList;
	}
	/**
	 * 提取ATC(药品成分)
	 */
	public List<ATCCode> getAllATC() {
		
		List<Instruction> allShuoMingShu = getAllShuoMingShu();
		
		for (Instruction instruction : allShuoMingShu) {
			ATCCode atcCode = instruction.getAtcCode();
			if(StringUtils.isBlank(atcCode.getAtcNo())) continue;
			String tongYongName = new DrugCombinationName(instruction.getDrugCombinationName()).getTongYongName();
			Neo4jBuildUtil.addRelationToNeo4j("药品_ATC", tongYongName, atcCode.getAtcNo());
			buildAtcRelationByAtcCode(atcCode);
		}
		return null;
	}
	private void buildAtcRelationByAtcCode(ATCCode atcCode){
		List<String> titles = new ArrayList<String>();
		titles.add("编码");
		titles.add("中文名");
		titles.add("英文名");
		
		List<ATCCode> atcCodes = new ArrayList<ATCCode>();
		Map<Integer, ATCCode> atcParentsMap = ATCUtil.getATCCodeParentsByAtcCode(atcCode);
		if(atcParentsMap == null){
			System.err.println(atcCode + " 's atcParentsMap is blank!");
			return;
		}
		for (int i = atcParentsMap.size(); i >=1; i--) {
			ATCCode nextV = atcParentsMap.get(i);
			String atcNo  = nextV.getAtcNo();
			ATCCode atcCode1 = getATCCode(atcNo);
			if(atcCode1 == null){
				atcCode1 = new ATCCode();
				atcCode1.setAtcNo(atcNo);
			}
			atcCodes.add(atcCode1);
			List<String> values = new ArrayList<String>();
			values.add(atcNo);
			values.add(atcCode1.getChName());
			values.add(atcCode1.getEnName());
			Neo4jBuildUtil.addToNeo4j("ATC", titles, values, "编码",atcNo);
		}
		for (int i = 0; i < atcCodes.size(); i++) {
			if(i+1 < atcCodes.size()){
				ATCCode code1 = atcCodes.get(i);
				ATCCode code2 = atcCodes.get(i+1);
				Neo4jBuildUtil.addRelationToNeo4j("ATC_ATC", code1.getAtcNo(), code2.getAtcNo());
			}
		}
	}
	/**
	 * 提取所有的药品间相互作用 过滤15种药品
	 * @return 
	 */
	public List<DDI> getAllDDI() {
		
		List<String> atcTitles = new ArrayList<String>();
		atcTitles.add("编码");
		atcTitles.add("中文名");
		atcTitles.add("英文名");
		List<String> atcValues = null;
		
		List<Instruction> allShuoMingShu = getAllShuoMingShu();
		List<String> uniqueList = new ArrayList<String>();
//		List<String> medicineNameUniqueList = new ArrayList<String>();
		List<String> titles = new ArrayList<String>();
		titles.add("通用名");
		titles.add("商品名");
		
		for (Instruction instruction : allShuoMingShu) {
			String tongYongName = new DrugCombinationName(instruction.getDrugCombinationName()).getTongYongName();
			String shangPinName = new DrugCombinationName(instruction.getDrugCombinationName()).getShangPinName();
			
			/*ATCCode atc = instruction.getAtcCode();
			atcValues = new ArrayList<String>();
			atcValues.add(atc.getAtcNo());
			atcValues.add(atc.getChName());
			atcValues.add(atc.getEnName());
			Neo4jBuildUtil.addToNeo4j("ATC", atcTitles, atcValues, "编码",atc.getAtcNo());
			buildAtcRelationByAtcCode(atc);
			Neo4jBuildUtil.addRelationToNeo4j("药品_ATC", tongYongName, atc.getAtcNo());*/
			
			Map<String, Object> queryMap = new HashMap<String, Object>();
			
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			
			Map<String, Object> or1 = new HashMap<String, Object>();
			or1.put("dxyDrugAShangPinMing", shangPinName);
			or1.put("dxyDrugATongYongMing", tongYongName);
			list.add(or1);
			Map<String, Object> or2 = new HashMap<String, Object>();
			or2.put("dxyDrugBShangPinMing", shangPinName);
			or2.put("dxyDrugBTongYongMing", tongYongName);
			list.add(or2);
			queryMap.put("$or", list);
			List<Document> docs = MongoUtil.findDocList("drugAtcInfoDDIWithDXYV5", queryMap);
			
			
			for (Document document : docs) {
				String drugAShangPinName = document.getString("dxyDrugAShangPinMing");
				String dxyDrugATongYongMing = document.getString("dxyDrugATongYongMing");
				String drugAAtcNo = document.getString("drugAAtcNo");
				String drugAAtcChName = document.getString("drugAAtcChName");
				String drugAAtcEnName = document.getString("drugAAtcEnName");
				
			    
			    
				String drugBShangPinName = document.getString("dxyDrugBShangPinMing");
				String dxyDrugBTongYongMing = document.getString("dxyDrugBTongYongMing");
				String drugBAtcNo = document.getString("drugBAtcNo");
				String drugBAtcChName = document.getString("drugBAtcChName");
				String drugBAtcEnName = document.getString("drugBAtcEnName");
				String level = document.getString("level");
				
				/*Neo4jBuildUtil.addRelationToNeo4j("药品_ATC", dxyDrugATongYongMing, drugAAtcNo);
				Neo4jBuildUtil.addRelationToNeo4j("药品_ATC", dxyDrugBTongYongMing, drugBAtcNo);*/
				
				
				boolean isA = false;
				if(drugAShangPinName.equals(shangPinName) && dxyDrugATongYongMing.equals(tongYongName)){
					isA = true;
				}
				
				String unique1 = drugAShangPinName+dxyDrugATongYongMing+drugBShangPinName+dxyDrugBTongYongMing;
				String unique2 = drugBShangPinName+dxyDrugBTongYongMing+drugAShangPinName+dxyDrugATongYongMing;
				if(uniqueList.contains(unique1) || uniqueList.contains(unique2) ) continue;
				uniqueList.add(unique1);
				uniqueList.add(unique2);
				
				List<String> values = new ArrayList<String>();
				
				if(isA){
					values.add(dxyDrugBTongYongMing);
					values.add(drugBShangPinName);
					Neo4jBuildUtil.addToNeo4j("药品", titles, values, "通用名",dxyDrugBTongYongMing+drugBShangPinName);
					addMajorConstituent(drugBAtcChName,new DrugCombinationName(drugBShangPinName, dxyDrugBTongYongMing).getCombinationName());
					Neo4jBuildUtil.addRelationToNeo4j("药品_主成分", dxyDrugBTongYongMing, drugBAtcChName);
					Neo4jBuildUtil.addRelationToNeo4j("主成分_ATC", drugBAtcChName, drugBAtcNo);
				}else{
					values.add(dxyDrugATongYongMing);
					values.add(drugAShangPinName);
					Neo4jBuildUtil.addToNeo4j("药品", titles, values, "通用名",dxyDrugATongYongMing+drugAShangPinName);
					addMajorConstituent(drugAAtcChName,new DrugCombinationName(drugAShangPinName, dxyDrugATongYongMing).getCombinationName());
					Neo4jBuildUtil.addRelationToNeo4j("药品_主成分", dxyDrugATongYongMing, drugAAtcChName);
					Neo4jBuildUtil.addRelationToNeo4j("主成分_ATC", drugAAtcChName, drugAAtcNo);
				}
				atcValues = new ArrayList<String>();
				atcValues.add(drugAAtcNo);
				atcValues.add(drugAAtcChName);
				atcValues.add(drugAAtcEnName);
				Neo4jBuildUtil.addToNeo4j("ATC", atcTitles, atcValues, "编码",drugAAtcNo);
				
				atcValues = new ArrayList<String>();
				atcValues.add(drugBAtcNo);
				atcValues.add(drugBAtcChName);
				atcValues.add(drugBAtcEnName);
				Neo4jBuildUtil.addToNeo4j("ATC", atcTitles, atcValues, "编码",drugBAtcNo);
				
				String ID = "ATC_XHZY_LEVEL_"+MD5Util.encode(drugAAtcNo+drugBAtcNo);
				List<String> effectLevelTitles = new ArrayList<String>();
				effectLevelTitles.add("ID");
				effectLevelTitles.add("名称");
				effectLevelTitles.add("ATC_FIRST");
				effectLevelTitles.add("ATC_SECOND");
				List<String> effectLevelValues = new ArrayList<String>();
				effectLevelValues.add(ID);
				effectLevelValues.add(level);
				effectLevelValues.add(drugAAtcNo);
				effectLevelValues.add(drugBAtcNo);
				Neo4jBuildUtil.addToNeo4j("ATC相互作用级别", effectLevelTitles, effectLevelValues,"ID", ID);
				Neo4jBuildUtil.addRelationToNeo4j("ATC_ATC相互作用级别", drugAAtcNo, ID);
				Neo4jBuildUtil.addRelationToNeo4j("ATC相互作用级别_ATC",ID,drugBAtcNo);
			}
		}
		
		return null;
	}
	private void addMajorConstituent(String value,String drugComName){
		List<String> majorConstituentTitleList = new ArrayList<String>();
		majorConstituentTitleList.add("名称");
//		majorConstituentTitleList.add("所属药品");
		List<String> majorConstituentValueList = new ArrayList<String>();
		majorConstituentValueList.add(value);
//		majorConstituentValueList.add(drugComName);
		Neo4jBuildUtil.addToNeo4j("主成分", majorConstituentTitleList, majorConstituentValueList, "名称",value);
	}
	private ATCCode getATCCode(String atcNo){
		Document atcDoc = MongoUtil.findOne("bysy_atc_code", "atcNo" , atcNo);
		if(atcDoc == null){
			log.warn("The atcNo “"+atcNo+"”'s atcDoc not found in db!");
			return null;
		}
		String chName = atcDoc.getString("chName");
		String enName = atcDoc.getString("enName");
		ATCCode atcCode = new ATCCode(atcNo,chName,enName);
		return atcCode;
	}
	/**
	 * 加载说明书字段
	 * @return
	 * @throws IOException
	 */
	private static List<String> loadShuoMingShuFields() throws IOException{
		Resource resource1 = new ClassPathResource("shuomingshu_fields.txt");
	    File file = resource1.getFile(); //获取file对象
	    List<String> fields = FileUtils.readLines(file,Charset.forName("utf-8"));
	    return fields ;
	}
	/**
	 * 提取所有说明书
	 * 
	 * @return
	 */
	private List<Instruction> getAllShuoMingShu() {
		List<Instruction> instructions = InstructionsReadUtil.getInstructions();
		return instructions;
	}
}
