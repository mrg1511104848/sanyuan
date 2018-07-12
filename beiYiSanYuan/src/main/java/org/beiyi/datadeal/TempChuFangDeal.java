package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidOperationException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.reource.Resources;
import org.bson.Document;
import org.skynet.frame.persistent.MongoIndex;
import org.skynet.frame.util.ListUtil;
import org.skynet.frame.util.excel.ExcelReadUtil;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.mongo.MongoUtil;
import org.xml.sax.SAXException;

public class TempChuFangDeal {
	private static Logger log = Logger.getLogger(TempChuFangDeal.class);
	private static List<List<String>> records;
	public static List<String> cellsList;
	public static List<ChuFang> chuFangList = new ArrayList<ChuFang>();
	public static String chuFangPath = "D://logs/处方明细2014处理.xlsx";
	static List<DrugCombinationName> drugCombinationNames = null;

	public static void main(String[] args) throws IOException,
			InvalidOperationException, OpenXML4JException,
			ParserConfigurationException, SAXException {
		dealVersion2();
	}
	private static void dealVersion1() throws IOException{
		try {
			records = ExcelReadUtil.getRecords(chuFangPath);
			// records = ExcelUtils.getInstance().readExcel2List(chuFangPath);
		} catch (IOException | InvalidOperationException | OpenXML4JException
				| ParserConfigurationException | SAXException e) {
			e.printStackTrace();
		}

		drugCombinationNames = new ArrayList<DrugCombinationName>();
		List<String> drugIds = FileUtils.readLines(new File("C://drugIds.txt"),
				Charset.forName("utf-8"));
		for (String drugId : drugIds) {
			Document doc = MongoUtil.findOne("dxy_app_drug_detail", "drugId",
					drugId);
			String cnName = DXYUtil.getString(doc, "商品名", true);
			String commonName = DXYUtil.getString(doc, "通用名", true);
			drugCombinationNames
					.add(new DrugCombinationName(cnName, commonName));
		}

		read2ChuFangList();

		List<String> cells = new ArrayList<String>();
		cells.add("处方患者ID");
		cells.add("处方药品名称");
		cells.add("处方适应症");
		cells.add("处方适应症编码");
		cells.add("处方ICD10版本");
		cells.add("说明书适应症");
		cells.add("说明书适应症编码");
		cells.add("说明书ICD10版本");
		cells.add("审核结果");
		List<List<String>> values = new ArrayList<List<String>>();
		// List<ChuFang> daiShenHeChuFangList = new ArrayList<ChuFang>();
		int cfIdx = 0;
		for (ChuFang cf : chuFangList) {
			cfIdx++;
			List<Drug> drugs = cf.getDrugs();
			for (Drug drug : drugs) {
				String drugCombinationName = drug.getDrugCombinationName();
				DrugCombinationName combinationName = new DrugCombinationName(
						drugCombinationName);
				String combinationNameStandard = combinationName
						.getCombinationStandardName();
				List<String> cfDiagnosises = cf.getDiagnosises();
				Map<String, Object> filter = new HashMap<String, Object>();
				filter.put("combinationNameStandard", combinationNameStandard);
				List<Document> docs = MongoUtil.findDocList(
						"bysy_drug_syz_final", filter);
				if (docs == null)
					continue;
				List<String> subValues = null;
				List<String> compareToUniqueList = new ArrayList<String>();
				for (Document doc : docs) {
					String shuoMingShuIcd10Code = doc.getString("code");
					String shuoMingShuShiYingZheng = doc.getString("shiYingZheng");
					String shuoMingShuIcd10Version = doc.getString("version");
					outter: for (String cfDiag : cfDiagnosises) {

						Map<String, Object> icdCodeFilter = new HashMap<String, Object>();
						icdCodeFilter.put("name", cfDiag);
						List<Document> wechatIcdDocs = MongoUtil.findDocList("wechat_icd",
								icdCodeFilter);
						
						
						if (wechatIcdDocs == null || wechatIcdDocs.size() == 0) {
							subValues = new ArrayList<String>();
							subValues.add(cf.getChuFangNo());
							subValues.add(combinationNameStandard);
							subValues.add(cfDiag);
							subValues.add("");
							subValues.add("");
							subValues.add("");
							subValues.add("");
							subValues.add("");
							subValues.add("适应症“" + cfDiag + "”未从wechat_icd中找到");
							values.add(subValues);
							continue;
						}
						for (Document wechatIcdDoc : wechatIcdDocs) {
							subValues = new ArrayList<String>();
							subValues.add(cf.getChuFangNo());
							subValues.add(combinationNameStandard);
							subValues.add(cfDiag);
							
							Set<String> matchList = new HashSet<String>();
							String cfDiagIcdCode = wechatIcdDoc.getString("code");
							String cfDiagIcdVersion = Resources.getICD_VERSION_MAP().get(wechatIcdDoc.getString("version"));
							subValues.add(cfDiagIcdCode);
							subValues.add(cfDiagIcdVersion);
							subValues.add(shuoMingShuShiYingZheng);
							subValues.add(shuoMingShuIcd10Code);
							subValues.add(shuoMingShuIcd10Version);
							if(compareToUniqueList.contains(cfDiagIcdCode+shuoMingShuIcd10Code)) continue;
							compareToUniqueList.add(cfDiagIcdCode+shuoMingShuIcd10Code);
							
							if (shuoMingShuIcd10Code.equals(cfDiagIcdCode)) {
								matchList.add("完全正确");
							} else if (shuoMingShuIcd10Code.contains(cfDiagIcdCode)) {
								if (cfDiagIcdCode.contains(".")) {
									if (StringUtils.substringBefore(cfDiagIcdCode,
											".").equals(
											StringUtils.substringBefore(shuoMingShuIcd10Code, "."))) {
										matchList.add("同一个上级");
									}
								} else {
									matchList.add("处方适应症位于说明书适应症上级");
								}
							} else if (cfDiagIcdCode.contains(shuoMingShuIcd10Code)) {
								if (shuoMingShuIcd10Code.contains(".")) {
									if (StringUtils.substringBefore(cfDiagIcdCode,
											".").equals(
											StringUtils.substringBefore(shuoMingShuIcd10Code, "."))) {
										matchList.add("同一个上级");
									}
								} else {
									matchList.add("说明书适应症位于处方适应症上级");
								}
							} else {
								matchList.add("完全不相等");
							}
							if (matchList.contains("完全正确")) {
								subValues.add("完全正确");
							} else {
								for (String match : matchList) {
									subValues.add(match);
								}
							}
							if (subValues != null && subValues.size() > 3) {
								values.add(subValues);
							}
						}
					}
				}
			}
		}
		List<List<List<String>>> allList = ListUtil.createList(values, 100000);
		for (int i = 0; i < allList.size(); i++) {
			ExcelUtil.export("D://logs/处方明细2014处理/机器审核适应症(根据ICD10编码)_"+i+".xlsx", cells,
					allList.get(i));
		}
	}
	private static void dealVersion2() throws IOException{
		try {
			records = ExcelReadUtil.getRecords(chuFangPath);
			// records = ExcelUtils.getInstance().readExcel2List(chuFangPath);
		} catch (IOException | InvalidOperationException | OpenXML4JException
				| ParserConfigurationException | SAXException e) {
			e.printStackTrace();
		}

		drugCombinationNames = new ArrayList<DrugCombinationName>();
		List<String> drugIds = FileUtils.readLines(new File("C://drugIds.txt"),
				Charset.forName("utf-8"));
		for (String drugId : drugIds) {
			Document doc = MongoUtil.findOne("dxy_app_drug_detail", "drugId",
					drugId);
			String cnName = DXYUtil.getString(doc, "商品名", true);
			String commonName = DXYUtil.getString(doc, "通用名", true);
			drugCombinationNames
					.add(new DrugCombinationName(cnName, commonName));
		}

		read2ChuFangList();

		List<String> cells = new ArrayList<String>();
		cells.add("处方患者ID");
		cells.add("处方药品名称");
		cells.add("处方适应症");
		cells.add("处方适应症编码");
		cells.add("说明书适应症");
		cells.add("说明书适应症编码");
		cells.add("审核结果");
		List<List<String>> values = new ArrayList<List<String>>();
		// List<ChuFang> daiShenHeChuFangList = new ArrayList<ChuFang>();
		int allTrueCount = 0;
		int allFailCount = 0;
		int partTrueCount = 0;
		for (ChuFang cf : chuFangList) {
			List<Drug> drugs = cf.getDrugs();
			for (Drug drug : drugs) {
				String drugCombinationName = drug.getDrugCombinationName();
				DrugCombinationName combinationName = new DrugCombinationName(drugCombinationName);
				String combinationNameStandard = combinationName.getCombinationStandardName();
				List<String> cfDiagnosises = cf.getDiagnosises();//处方药品对应适应症列表
				Map<String, Object> filter = new HashMap<String, Object>();
				filter.put("combinationNameStandard", combinationNameStandard);
				List<Document> shuoMingShuShiYingZhengdocs = MongoUtil.findDocList("bysy_drug_syz_final", filter);//整理好的说明书对应的适应症
				List<String> subValues = null;
				if (shuoMingShuShiYingZhengdocs == null || shuoMingShuShiYingZhengdocs.size() == 0){
					subValues = new ArrayList<String>();
					subValues.add(cf.getChuFangNo());
					subValues.add(combinationNameStandard);
					subValues.add("");
					subValues.add("");
					subValues.add("");
					subValues.add("");
					subValues.add("药品未从整理好的说明书找到");
					values.add(subValues);
					continue;
				}
				
				List<String> compareToUniqueList = new ArrayList<String>();
				for (String cfDiag : cfDiagnosises) {
					Map<String, Object> icdCodeFilter = new HashMap<String, Object>();
					icdCodeFilter.put("name", cfDiag);
					List<Document> wechatIcdDocs = MongoUtil.findDocList("wechat_icd",icdCodeFilter);
					
					if (wechatIcdDocs == null || wechatIcdDocs.size() == 0) {
						subValues = new ArrayList<String>();
						subValues.add(cf.getChuFangNo());
						subValues.add(combinationNameStandard);
						subValues.add(cfDiag);
						subValues.add("");
						subValues.add("");
						subValues.add("");
						subValues.add("适应症未从ICD10找到");
						values.add(subValues);
						continue;
					}
					List<List<String>> matchListAll = new ArrayList<List<String>>();
					List<List<String>> matchListChildInfoAll = new ArrayList<List<String>>();
					for (Document shuoMingShuShiYingZhengdoc : shuoMingShuShiYingZhengdocs) {
						String shuoMingShuIcd10Code = shuoMingShuShiYingZhengdoc.getString("code");
						String shuoMingShuShiYingZheng = shuoMingShuShiYingZhengdoc.getString("shiYingZheng");
						
						for (Document wechatIcdDoc : wechatIcdDocs) {
							
							List<String> matchList = new ArrayList<String>();
							List<String> matchListChildInfo = new ArrayList<String>();
							
							String cfDiagIcdCode = wechatIcdDoc.getString("code");
							
							matchListChildInfo.add(cfDiagIcdCode);
							matchListChildInfo.add(shuoMingShuShiYingZheng);
							matchListChildInfo.add(shuoMingShuIcd10Code);
							
							if(compareToUniqueList.contains(cfDiagIcdCode+shuoMingShuIcd10Code)) continue;
							compareToUniqueList.add(cfDiagIcdCode+shuoMingShuIcd10Code);
							
							compareCode(matchList, shuoMingShuIcd10Code, cfDiagIcdCode);
							matchListAll.add(matchList);
							matchListChildInfoAll.add(matchListChildInfo);
						}
					}
					
					
					int allIsTrue = -1;
					List<Integer> sameParent = new ArrayList<Integer>();
					List<Integer> cfIsParent = new ArrayList<Integer>();
					List<Integer> shuoMingShuIsParent = new ArrayList<Integer>();
					List<Integer> notMatch = new ArrayList<Integer>();
					
					for (int i = 0; i < matchListAll.size(); i++) {
						List<String> matchListEach = matchListAll.get(i);
						for (String each : matchListEach) {
							if(each.equals("完全正确")){//完全正确，记录一下坐标号。
								allIsTrue = i;
							}
							if(each.equals("同一个上级")){
								sameParent.add(i);
							}
							if(each.equals("处方适应症位于说明书适应症上级")){
								cfIsParent.add(i);
							}
							if(each.equals("说明书适应症位于处方适应症上级")){
								shuoMingShuIsParent.add(i);
							}
							if(each.equals("完全不相等")){
								notMatch.add(i);
							}
						}
					}
					subValues = new ArrayList<String>();
					if(allIsTrue!=-1){
						subValues.add(cf.getChuFangNo());
						subValues.add(combinationNameStandard);
						subValues.add(cfDiag);
						subValues.add(matchListChildInfoAll.get(allIsTrue).get(0));
						subValues.add(matchListChildInfoAll.get(allIsTrue).get(1));
						subValues.add(matchListChildInfoAll.get(allIsTrue).get(2));
						subValues.add("完全相等");
						values.add(subValues);
						allTrueCount++;
					}else if(cfIsParent.size() > 0 || shuoMingShuIsParent.size() > 0){
						StringBuffer sb = new StringBuffer();
						/*if(sameParent.size() > 0){
							sb.append("【同一上级】处方适应症“"+cfDiag+"("+matchListChildInfoAll.get(sameParent.get(0)).get(0)+")”与说明书适应症"
									+ "“"+matchListChildInfoAll.get(sameParent.get(0)).get(1)+"("+matchListChildInfoAll.get(sameParent.get(0)).get(2)+")”");
						}*/
						if(cfIsParent.size() > 0){
							sb.append("【处方位于说明书上级】处方适应症“"+cfDiag+"("+matchListChildInfoAll.get(cfIsParent.get(0)).get(0)+")”与说明书适应症"
									+ "“"+matchListChildInfoAll.get(cfIsParent.get(0)).get(1)+"("+matchListChildInfoAll.get(cfIsParent.get(0)).get(2)+")”");
						}
						if(shuoMingShuIsParent.size() > 0){
							sb.append("【说明书位于处方上级】处方适应症“"+cfDiag+"("+matchListChildInfoAll.get(shuoMingShuIsParent.get(0)).get(0)+")”与说明书适应症"
									+ "“"+matchListChildInfoAll.get(shuoMingShuIsParent.get(0)).get(1)+"("+matchListChildInfoAll.get(shuoMingShuIsParent.get(0)).get(2)+")”");
						}
						subValues.add(cf.getChuFangNo());
						subValues.add(combinationNameStandard);
						subValues.add(cfDiag);
						subValues.add("");
						subValues.add("");
						subValues.add("");
						subValues.add(sb.toString());
						values.add(subValues);
						partTrueCount++;
					} else if(cfIsParent.size() == 0 && shuoMingShuIsParent.size() == 0 && notMatch.size()>0 ){//不匹配
						subValues.add(cf.getChuFangNo());
						subValues.add(combinationNameStandard);
						subValues.add(cfDiag);
						subValues.add(matchListChildInfoAll.get(notMatch.get(0)).get(0));
						subValues.add(matchListChildInfoAll.get(notMatch.get(0)).get(1));
						subValues.add(matchListChildInfoAll.get(notMatch.get(0)).get(2));
						subValues.add("完全不相等");
						values.add(subValues);
						allFailCount++;
					}
				}
			}
		}
		System.out.println("总量:"+values.size()+" | 全部正确:"+allTrueCount +" | 部分正确:"+partTrueCount+" | 全部错误:"+allFailCount);
		List<List<List<String>>> allList = ListUtil.createList(values, 60000);
		for (int i = 0; i < allList.size(); i++) {
			ExcelUtil.export("D://logs/处方明细2014处理05/机器审核适应症(根据ICD10编码)_"+i+".xlsx", cells,
					allList.get(i));
		}
	}
	private static void compareCode(List<String> matchList,String shuoMingShuIcd10Code,String cfDiagIcdCode){
		if (shuoMingShuIcd10Code.equals(cfDiagIcdCode)) {
			matchList.add("完全正确");
		} else if (shuoMingShuIcd10Code.contains(cfDiagIcdCode)) {
			if (cfDiagIcdCode.contains(".")) {
				if (StringUtils.substringBefore(cfDiagIcdCode,
						".").equals(
						StringUtils.substringBefore(shuoMingShuIcd10Code, "."))) {
					matchList.add("同一个上级");
				}
			} else {
				matchList.add("处方适应症位于说明书适应症上级");
			}
		} else if (cfDiagIcdCode.contains(shuoMingShuIcd10Code)) {
			if (shuoMingShuIcd10Code.contains(".")) {
				if (StringUtils.substringBefore(cfDiagIcdCode,
						".").equals(
						StringUtils.substringBefore(shuoMingShuIcd10Code, "."))) {
					matchList.add("同一个上级");
				}
			} else {
				matchList.add("说明书适应症位于处方适应症上级");
			}
		} else {
			matchList.add("完全不相等");
		}
	}
	/**
	 * 正确的适应症入库到mongo
	 * 
	 * @throws SAXException
	 * @throws ParserConfigurationException
	 * @throws OpenXML4JException
	 * @throws IOException
	 * @throws InvalidOperationException
	 */
	private static void bysySyzInsertToMongo()
			throws InvalidOperationException, IOException, OpenXML4JException,
			ParserConfigurationException, SAXException {
		List<MongoIndex> mongoIndexs = new ArrayList<MongoIndex>();
		mongoIndexs.add(new MongoIndex("combinationNameStandard"));
		mongoIndexs.add(new MongoIndex("shiYingZheng"));
		mongoIndexs.add(new MongoIndex("code"));
		mongoIndexs.add(new MongoIndex("version"));
		MongoUtil.addCombinationIndex("bysy_drug_syz_final", mongoIndexs, true);
		// 正确的适应症 入库
		List<List<String>> validSYZRecords = ExcelReadUtil
				.getRecords("D://爱客服/数据_ALL/北医三院/数据/数据处理/20180709正确的适应症.xlsx");
		for (List<String> list : validSYZRecords) {
			String drugCombinationName = list.get(0);
			DrugCombinationName combinationName = new DrugCombinationName(
					drugCombinationName);
			String combinationNameStandard = combinationName
					.getCombinationStandardName();
			String shiYingZheng = list.get(1);
			String code = list.get(2);
			String version = list.get(3);

			java.util.Map<String, Object> bysy_drug_syz_final = new HashMap<String, Object>();
			bysy_drug_syz_final.put("combinationNameStandard",
					combinationNameStandard);
			bysy_drug_syz_final.put("shiYingZheng", shiYingZheng);
			bysy_drug_syz_final.put("code", code);
			bysy_drug_syz_final.put("version", version);
			MongoUtil.saveDoc("bysy_drug_syz_final", bysy_drug_syz_final);
		}
		System.out.println();
	}

	public static void read2ChuFangList() {
		cellsList = records.get(0);
		for (int i = 1; i < records.size(); i++) {
			System.out.println(i);
			List<String> rI = records.get(i);
			List<List<String>> chuFangRows = new ArrayList<List<String>>();
			chuFangRows.add(rI);
			String chuFangUniqueStrI = getUniquePrescriptionNo(rI);

			int sameChuFangCount = 0;
			for (int j = i + 1; j < records.size(); j++) {
				List<String> rJ = records.get(j);
				String chuFangUniqueStrJ = getUniquePrescriptionNo(rJ);

				if (chuFangUniqueStrI.equals(chuFangUniqueStrJ)) {// 证明是同一个处方
					chuFangRows.add(rJ);
					sameChuFangCount++;
				} else {
					break;
				}
			}
			ChuFang chuFang = parseChuFangRows2ChuFang(chuFangRows);
			if (chuFang == null)
				continue;
			chuFangList.add(chuFang);
			i = i + sameChuFangCount;
		}
	}

	private static String getUniquePrescriptionNo(List<String> rows) {
		return rows.get(3);
	}

	public static ChuFang parseChuFangRows2ChuFang(
			List<List<String>> chuFangRows) {
		ChuFang chuFang = new ChuFang();
		List<Drug> drugs = new ArrayList<Drug>();
		boolean contains = false;
		if (chuFangRows.size() == 0)
			return null;
		Set<String> diagnosisesSet = new HashSet<String>();
		outter: for (List<String> row : chuFangRows) {
			if (row.size() != 6)
				continue;
			try {
				chuFang.setChuFangNo(row.get(3));
				Drug drug = new Drug();
				drug.setDrugCombinationName(row.get(1));
				diagnosisesSet.add(row.get(5));
				for (Drug d : drugs) {
					if (d.getDrugCombinationName().equals(
							drug.getDrugCombinationName()))
						continue outter;
				}
				drugs.add(drug);

				String combinationStandardName = new DrugCombinationName(
						drug.getDrugCombinationName())
						.getCombinationStandardName();
				for (DrugCombinationName drugCombinationName : drugCombinationNames) {
					if (drugCombinationName.getCombinationStandardName()
							.equals(combinationStandardName)) {
						contains = true;
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(chuFangRows + " error !");
			}
		}
		if (!contains) {
			return null;
		}
		List<String> diagnosises = new ArrayList<String>();
		for (String diagnosise : diagnosisesSet) {
			diagnosises.add(diagnosise);
		}
		chuFang.setDiagnosises(diagnosises);
		chuFang.setDrugs(drugs);
		return chuFang;
	}
}
