package org.beiyi.reource;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.verify.JiLiang;
import org.springframework.util.ResourceUtils;

/**
 * 处理处方用到的资源加载类
 * @author 2bu
 *
 */
public class Resources {
	/**
	 * 用药频率
	 */
	public static List<List<String>> dddsList = new ArrayList<List<String>>();
	public static Map<String, String> dddsCalculateMap = new HashMap<String, String>();
	public static List<List<JiLiang>> jiLiangSelectionGroupList = new ArrayList<List<JiLiang>>();
	public static Map<String, String> patientStatusMap = new HashMap<String, String>();
	public static List<String> routeOfMedicineList = new ArrayList<String>();
	public static Map<String, String[]> dosageUnitConversionMap = new HashMap<String, String[]>();
	public static List<String> useForDosageSplitDicts = new ArrayList<String>();
	static{
		loadDDDS();
		loadDDDSCalculate();
		loadJiLiangSelectionGroupLists();
		loadPatientStatus();
		loadRouteOfMedicineList();
		loadDosageUnitConversion();
		loadUseForDosageSplitDicts();
	}
	public static List<String> readFile2Lines(String filePath) throws IOException{
		File file = ResourceUtils.getFile(filePath);
		List<String> lines = FileUtils.readLines(file,Charset.forName("utf-8"));
		return lines;
	}
	
	private static void loadUseForDosageSplitDicts(){
		try {
			useForDosageSplitDicts = readFile2Lines("classpath:useForDosageSplit.txt");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private static void loadDosageUnitConversion() {
		try {
			List<String> dosageUnitConversion = readFile2Lines("classpath:dosageUnitConversion.txt");
			for (String dosageUnitCver : dosageUnitConversion) {
				if(StringUtils.isBlank(dosageUnitCver)) continue;
				String[] cverInfo = dosageUnitCver.split(" ");
				String[] opEles = cverInfo[0].split("->");
				String fromEle = opEles[0];
				String toEle = opEles[1];
				dosageUnitConversionMap.put(fromEle, new String[]{toEle,cverInfo[1],cverInfo[2]});
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private static void loadRouteOfMedicineList() {
		try {
			List<String> routeOfMedication = readFile2Lines("classpath:routeOfMedication.txt");
			for (String routeOf : routeOfMedication) {
				if(StringUtils.isBlank(routeOf)) continue;
				routeOf = routeOf.trim();
				routeOfMedicineList.add(routeOf);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private static void loadPatientStatus() {
		try {
			List<String> patientStatusLines = readFile2Lines("classpath:patientStatus.txt");
			for (String patientStatus : patientStatusLines) {
				if(StringUtils.isBlank(patientStatus)) continue;
				if(!patientStatus.contains("&&")) continue;
				String[] patientStatusArr = patientStatus.split("&&");
				patientStatusMap.put(patientStatusArr[0], patientStatusArr[1]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 用药频率
	 * @return 
	 */
	private static List<List<String>> loadDDDS(){
		try {
			List<String> dddsLines = readFile2Lines("classpath:ddds.txt");
			for (String dddsEach : dddsLines) {
				
				if(StringUtils.isBlank(dddsEach)) continue;
				
				String[] dddsEqualsArr = dddsEach.split(",");
				
				
				List<String> dddsEqList = new ArrayList<String>();
				for (int i = 0; i < dddsEqualsArr.length; i++) {
					if(StringUtils.isBlank(dddsEqualsArr[i])) continue;
					dddsEqList.add(dddsEqualsArr[i]);
				}
				dddsList.add(dddsEqList);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return dddsList;
	}
	private static void loadDDDSCalculate() {
		try {
			List<String> dddsCalculateLines = readFile2Lines("classpath:ddds_calculate.txt");
			for (String dddsCalculate : dddsCalculateLines) {
				String[] dddsCalculateArr  = dddsCalculate.split(":");
				dddsCalculateMap.put(dddsCalculateArr[0], dddsCalculateArr[1]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 剂量选择 分组，用于将剂量选择分组,判断某个处方是否等于、小于、大于这个剂量分组
	 * @return
	 */
	private static List<List<JiLiang>> loadJiLiangSelectionGroupLists(){
		try {
			
			List<String> jiLiangSelectionGroups = readFile2Lines("classpath:jiLiangSelectionGroup.txt");
			for (String jiLiangInfo : jiLiangSelectionGroups) {
				
				String[] jlInfoArr = jiLiangInfo.split("~~");
				String[] selectionGroups = jlInfoArr[0].split(",");
				String oprator = jlInfoArr[1];
//				String type = jlInfoArr[2];
				
				List<JiLiang> jiLiangs = new ArrayList<JiLiang>();
				for (String selectionGroup : selectionGroups) {
					JiLiang jiLiang = new JiLiang();
					jiLiang.setDoseSelection(selectionGroup);
					jiLiang.setOprator(oprator);
//					jiLiang.setType(type);
					jiLiangs.add(jiLiang);
				}
				jiLiangSelectionGroupList.add(jiLiangs);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void test(){
		System.out.println();
	}
	public static void main(String[] args) {
		Resources.test();
	}
}
