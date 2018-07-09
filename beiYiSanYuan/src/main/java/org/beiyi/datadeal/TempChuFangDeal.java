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
