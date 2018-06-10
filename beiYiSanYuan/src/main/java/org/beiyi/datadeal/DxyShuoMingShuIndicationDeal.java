package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.ansj.domain.Term;
import org.apache.commons.collections4.ListUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.xmlbeans.impl.jam.mutable.MPackage;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.reource.Resources;
import org.bson.Document;
import org.skynet.frame.util.AnalysisUtil;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.map.MapUtil;
import org.skynet.frame.util.mongo.MongoUtil;

import com.github.crab2died.ExcelUtils;
import com.mongodb.client.MongoCursor;

/**
 * 丁香园说明书适应症处理
 * @author 2bu
 *
 */
public class DxyShuoMingShuIndicationDeal {
	private static Logger log = Logger.getLogger(DxyShuoMingShuIndicationDeal.class); 
	public static final String INDICATION_TERM_NATURE = "disease";
	private static final String NO_DATA_DISCRIPTER = "NONE";
	private static final Map<String, String> DISEASE_ICD10CODE = new HashMap<String, String>();
	private static final Map<String, String> ICD_VERSION_MAP = new HashMap<String, String>();
	public static void main(String[] args) {
		dealByICD10();
		log.info("over!");
	}
	static{
		
	}
	private static List<List<String>> loadICD10FromExcel(){
		final List<List<String>> allIcd10DiseaseList = new ArrayList<List<String>>();
		Thread[] threads = new Thread[3];
		for (int i = 1; i <= 3; i++) {
			final int fI = i;
			threads[i-1] = new Thread(new Runnable() {
				@Override
				public void run() {
					log.info("load icd10 from sheet "+fI);
					List<List<String>> icd10DiseaseList = null;
					try {
						icd10DiseaseList = ExcelUtils.getInstance().readExcel2List("D://爱客服/数据_ALL/北医三院/数据/数据处理/微信ICD10part"+fI+".xls");
					} catch (InvalidFormatException | IOException e) {
						e.printStackTrace();
					}
					allIcd10DiseaseList.addAll(icd10DiseaseList);
				}
			});
		}
		for (int i = 0; i < threads.length; i++) {
			threads[i].start();
		}
		for (int i = 0; i < threads.length; i++) {
			try {
				threads[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		/*for (List<String> list : allIcd10DiseaseList) {
			if(list.get(1).equals("乳腺炎")){
				System.out.println();
			}
		}*/
		System.out.println("over");
		return allIcd10DiseaseList;
	}
	public static void loadICD10Dict(){
		List<String> dictList = new ArrayList<String>();
		List<List<String>> icd10DiseaseList = loadICD10FromExcel();
		log.info("total loading "+icd10DiseaseList.size());
		for (List<String> icd10Disease : icd10DiseaseList) {
			String icd10Code = icd10Disease.get(0).trim();
			String diseaseName = icd10Disease.get(1).trim();
			if(diseaseName.contains("十二指肠溃疡")){
				System.out.println();
			}
			dictList.add(diseaseName);
			DISEASE_ICD10CODE.put(diseaseName, icd10Code);
		}
		AnalysisUtil.loadDict(dictList, INDICATION_TERM_NATURE);
	}
	public static Map<String, String> loadICD10VersionMap(){
		try {
			List<String> icdVersions = Resources.readFile2Lines("classpath:icd_versions.txt");
			for (String icdVersion : icdVersions) {
				String[] icdVersionArr = icdVersion.split(" ");
				ICD_VERSION_MAP.put(icdVersionArr[0], icdVersionArr[1]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return Collections.unmodifiableMap(ICD_VERSION_MAP);
	}
	private static void dealByICD10(){
		List<String> cells = new ArrayList<String>();
		cells.add("药品名称");
		cells.add("适应症全文");
		cells.add("适应症");
		cells.add("在本药适应症中出现词频");
		cells.add("适应症ICD10");
		loadICD10Dict();
//		List<List<String>> icd10DiseaseList = ExcelUtils.getInstance().readExcel2List(icd10path,1);
		List<DrugCombinationName> testDrugNameList = DxyShuoMingShuDosageDeal.testDrugNameList;
		
		MongoCursor<Document> dxy_app_drug_detail_simple_cursor = MongoUtil.iterator("dxy_app_drug_detail_simple");
		
		List<String> drugCombinationExistsInExport = new ArrayList<String>();
		List<List<String>> values = new ArrayList<List<String>>();
		
		while (dxy_app_drug_detail_simple_cursor.hasNext()) {
			Document doc = dxy_app_drug_detail_simple_cursor.next();
			String commonName = doc.getString("commonName");
			String cnName = doc.getString("cnName");
			String indication = doc.getString("indication");
			if(commonName.contains("（")){
				commonName = StringUtils.substringBefore(commonName, "（");
			}
			DrugCombinationName drugCombinationName = new DrugCombinationName(cnName+"("+commonName+")");
			if(!testDrugNameList.contains(drugCombinationName)){
				continue;
			}
			if(drugCombinationExistsInExport.contains(drugCombinationName.getCombinationStandardName())){
				continue;
			}
			List<List<String>> indicationParseResult = parse(indication,drugCombinationName);
			if(indicationParseResult!=null && indicationParseResult.size()>0){
				values.addAll(indicationParseResult);
			}
			drugCombinationExistsInExport.add(drugCombinationName.getCombinationStandardName());
		}
		ExcelUtil.export("D://爱客服/数据_ALL/北医三院/数据/数据处理/拆分丁香园适应症(根据北京版ICD10).xls", cells, values);
		
		/*List<String> result = ListUtils.subtract(DxyShuoMingShuDosageDeal.tempTestDrugNameList,drugCombinationExistsInExport);
		for (String r : result) {
			DrugCombinationName drugCombinationName = new DrugCombinationName(r);
			String shangPinName = drugCombinationName.getShangPinName();
			String tongYongName = drugCombinationName.getTongYongName();
			System.err.println(drugCombinationName.getCombinationStandardName());
		}*/
	}
	private static List<List<String>> parse(String indicationAll,
			DrugCombinationName drugCombinationName) {
		List<List<String>> exportValues = new ArrayList<List<String>>();
		
		List<String> termNameList = AnalysisUtil.getTermNameList(indicationAll, INDICATION_TERM_NATURE,DxyShuoMingShuDosageDeal.DICT_NAME);
		if(termNameList == null || termNameList.size() == 0){
			List<String> exportChildValues = new ArrayList<String>();
			String combinationStandardName = drugCombinationName.getCombinationStandardName();
			exportChildValues.add(combinationStandardName);
			exportChildValues.add(indicationAll);
			exportChildValues.add(NO_DATA_DISCRIPTER);
			exportChildValues.add(NO_DATA_DISCRIPTER);
			exportValues.add(exportChildValues);
			return exportValues;
		}
		Map<String, Integer> indicationNameCountMp = new HashMap<String, Integer>();
		for (String termName : termNameList) {
			if(indicationNameCountMp.containsKey(termName)){
				Integer count = indicationNameCountMp.get(termName);
				indicationNameCountMp.put(termName, count+1);
			}else{
				indicationNameCountMp.put(termName, 1);
			}
		}
		indicationNameCountMp = MapUtil.sortMapByValue(indicationNameCountMp, false);
		Iterator<Entry<String, Integer>> indicationNameCountItr = indicationNameCountMp.entrySet().iterator();
		while (indicationNameCountItr.hasNext()) {
			Entry<String, Integer> indicationNameCountEntry = indicationNameCountItr.next();
			String combinationStandardName = drugCombinationName.getCombinationStandardName();
			String indicationName = indicationNameCountEntry.getKey();
			Integer count = indicationNameCountEntry.getValue();
			
			List<String> exportChildValues = new ArrayList<String>();
			exportChildValues.add(combinationStandardName);
			exportChildValues.add(indicationAll);
			exportChildValues.add(indicationName);
			exportChildValues.add(Integer.toString(count));
			
			Map<String, Object> filter = new HashMap<String, Object>();
			filter.put("name", indicationName.trim());
			MongoCursor<Document> wechatIcdItr = MongoUtil.iterator("wechat_icd",filter,null,false);
			while (wechatIcdItr.hasNext()) {
				Document doc = wechatIcdItr.next();
				
				String code = doc.getString("code");
				String version = doc.getString("version");
				if(version.contains("0")){
					System.out.println();
				}
				exportChildValues.add(code);
				exportChildValues.add(ICD_VERSION_MAP.get(version));
				exportChildValues.add("  ");
			}
//			exportChildValues.add(DISEASE_ICD10CODE.getOrDefault(indicationName, NO_DATA_DISCRIPTER));
			
			exportValues.add(exportChildValues);
		}
		return exportValues;
	}
}




