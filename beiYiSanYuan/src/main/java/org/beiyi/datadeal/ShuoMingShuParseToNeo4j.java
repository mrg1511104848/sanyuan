package org.beiyi.datadeal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.beiyi.datadeal.MicroEffectDeal.ATCInfo;
import org.beiyi.entity.DDI;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.verify.ATCCode;
import org.beiyi.entity.verify.ICD10;
import org.bson.Document;
import org.skynet.frame.util.mongo.MongoUtil;

import com.github.crab2died.ExcelUtils;

/**
 * 说明书到neo4j格式的转换
 * 
 * @author 2bu
 *
 */
public class ShuoMingShuParseToNeo4j {
	private static final String diseaseSplitRegex = "；|;";
	static List<List<String>> shuoMingShuRecords = null;
	static {
		// 不基于注解,将Excel内容读至List<List<String>>对象内
		try {
			shuoMingShuRecords = ExcelUtils.getInstance().readExcel2List(
					"D://爱客服/数据_ALL/北医三院/三院提供/20180418说明书提取框架&demo新.xlsx", 0,
					10000, 0);
		} catch (InvalidFormatException | IOException e) {
			e.printStackTrace();
		}
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
		for (List<String> shuoMingShuRecord : shuoMingShuRecords) {
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
