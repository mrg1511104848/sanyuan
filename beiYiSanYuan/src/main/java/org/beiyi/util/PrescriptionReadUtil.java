package org.beiyi.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.poi.openxml4j.exceptions.InvalidOperationException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.HuanZhe;
import org.skynet.frame.util.excel.ExcelReadUtil;
import org.xml.sax.SAXException;

/**
 * 处方读取类
 * 
 * @author 2bu
 *
 */
public class PrescriptionReadUtil {
	private static List<List<String>> records;// 处方记录
	public static List<String> cellsList;
	public static List<ChuFang> chuFangList = new ArrayList<ChuFang>();
	// public static String chuFangPath =
	// "D://爱客服/北医三院/三院提供/三院提供的数据/处方/门急诊处方明细表-2017.3.6-2017.3.10（重新整理20180420）(1).xlsx";
//	public static String chuFangPath = "D://爱客服/北医三院/三院提供/三院提供的数据/处方/模拟处方/错误处方模拟_多个药一种病.xlsx";
//	public static String chuFangPath = "D://爱客服/数据_ALL/北医三院/三院提供/三院提供的数据/处方/模拟处方/cs.xlsx";
//	public static String chuFangPath = "D://用法用量错误处方模拟20180601.xlsx";
//	public static String chuFangPath = "D://爱客服/数据_ALL/北医三院/三院提供/用法用量+test.xlsx";
//	public static String chuFangPath = "D://logs/错误处方模拟_其他测试/新建 XLSX 工作表.xlsx";
//	public static String chuFangPath = "D://logs/错误处方模拟_其他测试/新建 XLSX 工作表 (2).xlsx";
//	public static String chuFangPath = "D://logs/错误处方模拟_其他测试/新建 XLSX 工作表 (3).xlsx";
//	public static String chuFangPath = "C://公司/北医三院/错误处方模拟_其他测试/用法用量+test.xlsx";
//	public static String chuFangPath = "D://logs/错误处方模拟_其他测试/测试_错误处方.xlsx";
//	public static String chuFangPath = "D://logs/错误处方模拟_其他测试/测试2_错误处方.xlsx";
	public static String chuFangPath = "D://logs/错误处方模拟_其他测试/测试3_错误处方.xlsx";
	static {
		try {
			// records =
			// ExcelReadUtil.getRecords("D://爱客服/北医三院/三院提供/三院提供的数据/处方/test.xlsx");
			records = ExcelReadUtil.getRecords(chuFangPath);
//			records = ExcelUtils.getInstance().readExcel2List(chuFangPath);
			read2ChuFangList();
		} catch (InvalidOperationException | IOException | OpenXML4JException | ParserConfigurationException | SAXException e) {
			e.printStackTrace();
		}
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
			chuFangList.add(chuFang);
			i = i + sameChuFangCount;
		}
	}

	private static ChuFang parseChuFangRows2ChuFang(
			List<List<String>> chuFangRows) {
		ChuFang chuFang = new ChuFang();
		List<String> firstRow = chuFangRows.get(0);
		chuFang.setChuFangNo(firstRow.get(1));
		HuanZhe huanZhe = new HuanZhe();
		huanZhe.setBornDate(firstRow.get(6));
		huanZhe.setJiuZhenDate(firstRow.get(9));
		chuFang.setHuanZhe(huanZhe);
		List<String> diagnosises = new ArrayList<String>();
		List<Drug> drugs = new ArrayList<Drug>();
		for (List<String> list : chuFangRows) {
			String shiYingZheng = list.get(16);
			String[] shiYingZhengArr = shiYingZheng.split(";|；|，|,");
			for (String syz : shiYingZhengArr) {
				if (org.apache.commons.lang3.StringUtils.isNotBlank(syz)
						&& !diagnosises.contains(syz.trim())) {
					diagnosises.add(syz.trim());
				}
			}
			Drug drug = new Drug();
			DrugCombinationName drugCombinationName = new DrugCombinationName(list.get(21));
			drug.setDrugCombinationName(drugCombinationName.getCombinationStandardName());
			drug.setForm(list.get(22));
			drug.setStandard(list.get(23));
			drug.setPack(list.get(24));
			drug.setRouteOfMedication(list.get(25));
			drug.setCompany(list.get(26));
			drug.setDosage(list.get(27));
			drug.setDosageUnit(list.get(28));
			drug.setDosingFrequency(list.get(29));
			drug.setDrugQuantity(list.get(30));
			drug.setDrugQuantityUnit(list.get(31));
			drugs.add(drug);
		}
		chuFang.setDiagnosises(diagnosises);
		chuFang.setDrugs(drugs);
		chuFang.setChuFangOldRows(chuFangRows);
		return chuFang;
	}

	/**
	 * 根据一行的excel记录获取到唯一的一个处方编号
	 * 
	 * @param list
	 * @return
	 */
	private static String getUniquePrescriptionNo(List<String> list) {
		String prescriptionNoI = list.get(1);

		String huanZheIdNoI = list.get(3);
		String huanZheJiuZhenDateI = list.get(9).split(" ")[0];
		String huanZheJiuZhenKeShiI = list.get(10);

		prescriptionNoI = prescriptionNoI.substring(0, 12) + "_" + huanZheIdNoI
				+ "_" + huanZheJiuZhenDateI + "_" + huanZheJiuZhenKeShiI;
		return prescriptionNoI;
	}

	public static void main(String[] args) {
	}

	public static List<List<String>> getRecords() {
		return records;
	}

	public static void setRecords(List<List<String>> records) {
		PrescriptionReadUtil.records = records;
	}
}
