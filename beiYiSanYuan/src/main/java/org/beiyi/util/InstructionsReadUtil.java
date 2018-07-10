package org.beiyi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.verify.ATCCode;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.springframework.util.ResourceUtils;

import com.github.crab2died.ExcelUtils;

/**
 * 整理好的说明书读取类
 * @author 2bu
 *
 */
public class InstructionsReadUtil {
	private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(InstructionsReadUtil.class);
	private static List<List<String>> records;//说明书记录
	private static List<Instruction> instructions = new ArrayList<Instruction>();
	public static Map<String, Set<String>> drugShiYingZhengMap = new HashMap<String, Set<String>>(); //药品适应症对应MAP
	static{
		/*try {
			records = ExcelReadUtil.getRecords("D://爱客服/北医三院/三院提供/20180418说明书提取框架&demo新.xlsx");
		} catch (InvalidOperationException | IOException | OpenXML4JException
				| ParserConfigurationException | SAXException e) {
			e.printStackTrace();
		}*/
		
		/*try {
//			String instrunctionPath = "D://爱客服/数据_ALL/北医三院/三院提供/20180418说明书提取框架&demo新.xlsx";
//			instrunctionPath = "C://公司/北医三院/20180418说明书提取框架&demo新.xlsx";
			File instrunctionFile = ResourceUtils.getFile("classpath:20180418说明书提取框架&demo新.xlsx");
			records = ExcelUtils.getInstance().readExcel2List(new FileInputStream(instrunctionFile));
		} catch (InvalidFormatException | IOException e) {
			e.printStackTrace();
		}
		instructionRead();
//		loadTests();
		loadInstructionCategorys();*/
	}
	public static Instruction get(String drugCombinationName){
		/*for (Instruction instruction : instructions) {
			if(instruction.getDrugCombinationName().equals(drugCombinationName)){
				return instruction;
			}
		}
		return null;*/
		
		return null;
	}
	private static void loadTests() {
		String[] tests = {"自维(L-谷氨酰胺胶囊)","新麦林(谷氨酰胺颗粒)"};
		for (int i = 0; i < tests.length; i++) {
			Instruction instruction = new Instruction();
			instruction.setDrugCombinationName(tests[i]);
			ATCCode atcCode = new ATCCode();
//			atcCode.setAtcNo("A0"+i+"CC1"+i);
			instruction.setAtcCode(atcCode);
			instructions.add(instruction);
		}
	}
	public static List<Instruction> instructionRead(){
		for (int i = 3; i < records.size(); i++) {
			List<String> r = records.get(i);
			if(r.size()<20) continue;
			String tongYongName = r.get(0);
			String shangPinName = r.get(1);
			String form = r.get(4);
			String standard = r.get(10);
			String atcCode = r.get(11);
			String shiyingzheng = r.get(20);
			String shiyingzhengKuoZhan = r.get(21);
			String containdications = r.get(35);
			if(StringUtils.isBlank(tongYongName) || tongYongName.equals("直接提取")){
				continue;
			}
			tongYongName = tongYongName.trim();
			DrugCombinationName drugCombinationName = new DrugCombinationName(shangPinName, tongYongName);
			String combinationName = drugCombinationName.getCombinationStandardName();
			Set<String> syzAll = getOneDrugShiYingZhengAll(shiyingzheng,shiyingzhengKuoZhan);//单个药品所有的适应症
			Set<String> containdicationAll = getOneDrugContaindicationAll(containdications);//单个药品所有的 禁用-疾病状态/特殊人群
			
			Instruction instruction = new Instruction();
			instruction.setDrugCombinationName(combinationName);
			
			ATCCode atcCd = new ATCCode();
			atcCd.setAtcNo(atcCode);
			instruction.setAtcCode(atcCd);
			if(instructions.contains(instruction)){
				for (Instruction inst : instructions) {
					if(inst.equals(instruction)){
						instruction = inst;
						break;
					}
				}
			}
			//重新将适应症封装到已有的说明书的药品的适应症中
			List<String> diagnosisesList = instruction.getDiagnosises();
			if(diagnosisesList == null){
				diagnosisesList = new ArrayList<String>();
			}
			Iterator<String> syzItr = syzAll.iterator();
			while (syzItr.hasNext()) {
				String syz = syzItr.next();
				if(!diagnosisesList.contains(syz)){
					diagnosisesList.add(syz);
				}
			}
			instruction.setDiagnosises(diagnosisesList);
			
			//重新将 禁用-疾病状态/特殊人群 封装到已有的说明书的药品的 禁用-疾病状态/特殊人群 中
			List<String> contraindicationsList = instruction.getContraindications();
			if(contraindicationsList == null){
				contraindicationsList = new ArrayList<String>();
			}
			Iterator<String> contraindicationsItr = containdicationAll.iterator();
			while (contraindicationsItr.hasNext()) {
				String contraindication = contraindicationsItr.next();
				if(!contraindicationsList.contains(contraindication)){
					contraindicationsList.add(contraindication);
				}
			}
			instruction.setContraindications(contraindicationsList);
			
			
			
			instruction.setForm(form);
			instruction.setStandard(standard);
			
			List<InstructionUse> instructionUses = instruction.getInstructionUses();
			if(instructionUses == null){
				instructionUses = new ArrayList<InstructionUse>();
			}
			InstructionUse instructionUse = new InstructionUse();
			instructionUse.setDoseSelection(r.get(22));
			instructionUse.setPatientStatus(r.get(23));
			instructionUse.setDosage(r.get(25));
			instructionUse.setDosageUnit(r.get(26));
			instructionUse.setDosingFrequency(r.get(27));
			instructionUse.setRouteOfMedication(r.get(28));
			instructionUse.setCourseControl(r.get(29));
			instructionUses.add(instructionUse);
			
			instruction.setInstructionUses(instructionUses);
			if(!instructions.contains(instruction)){
				instructions.add(instruction);
			}
			System.out.println(combinationName+"\t"+shiyingzheng);
		}
		return instructions;
	}
	private static Set<String> getOneDrugContaindicationAll(
			String containdications) {
		Set<String> containdicationAll = new HashSet<String>();
		String[] containdicationList = containdications.split("；|;");
		for (String containdication : containdicationList) {
			if(StringUtils.isNotBlank(containdication)){
				containdication = containdication.trim();
				containdicationAll.add(containdication);
			}
		}
		return containdicationAll;
	}
	/**
	 * 加载说明书中药品的分类
	 */
	private static void loadInstructionCategorys(){
		/*logger.info(" -- start load instruction categorys");
		for (Instruction instruction : instructions) {
			DrugCombinationName drugCombinationName = new DrugCombinationName(instruction.getDrugCombinationName());
			String combinationStandardName = drugCombinationName.getCombinationStandardName();
			
			Document yiMaiTongFinalStandardDoc = MongoUtil.findOne("yiMaiTongFinalStandard", "combinationStandardName", combinationStandardName);
			if(yiMaiTongFinalStandardDoc!=null){
				String category = yiMaiTongFinalStandardDoc.getString("category");
				DrugCategory drugCategory = new DrugCategory();
				drugCategory.setCategoryName(category);
				drugCategory.setSource("医脉通");
				instruction.setCategory(drugCategory);
			}
		}
		logger.info(" -- end load instruction categorys");*/
	}
	/**
	 * 加载说明书中药品的分类
	 */
	private static void loadInstructionATCLevels(){
		logger.info(" -- start load instruction ATC levels");
		/*for (Instruction instruction : instructions) {
			ATCCode atcCode = instruction.getAtcCode();
		}*/
		logger.info(" -- end load instruction ATC levels");
	}
	private static Set<String> getOneDrugShiYingZhengAll(String... shiyingzheng){
		Set<String> shiYingZhengFilterAfter = new HashSet<String>();
		for (String syz : shiyingzheng) {
			if(StringUtils.isBlank(syz)){
				continue;
			}
			syz = syz.trim().replaceAll(" ", "");
			String[] shiYingZhengList = syz.split("；|;");
			for (String eachSyz : shiYingZhengList) {
				if(StringUtils.isNotBlank(eachSyz))
					shiYingZhengFilterAfter.add(eachSyz);
			}
		}
		return shiYingZhengFilterAfter;
	}
	private static void add2ShiYingZhengMap(String combinationName,String shiyingzheng){
		if(StringUtils.isBlank(shiyingzheng) ){
			return;
		}
		String[] shiYingZhengList = shiyingzheng.split("；|;");
		Set<String> shiYingZhengFilterAfter = null;
		if(drugShiYingZhengMap.get(combinationName) == null){
			shiYingZhengFilterAfter = new HashSet<String>();
		}else{
			shiYingZhengFilterAfter = drugShiYingZhengMap.get(combinationName);
		}
		for (String syz : shiYingZhengList) {
			shiYingZhengFilterAfter.add(syz);
		}
		drugShiYingZhengMap.put(combinationName, shiYingZhengFilterAfter);
	}
	public static List<List<String>> getRecords() {
		return records;
	}
	public static void setRecords(List<List<String>> records) {
		InstructionsReadUtil.records = records;
	}
	public static void main(String[] args) {
	}
	public static boolean contains(String combinationName) {
		for (Instruction instruction : instructions) {
			if(instruction.getDrugCombinationName().equals(combinationName)){
				return true;
			}
		}
		return false;
	}
	public static List<Instruction> getInstructions() {
		return instructions;
	}
	public static void setInstructions(List<Instruction> instructions) {
		InstructionsReadUtil.instructions = instructions;
	}
	
}
