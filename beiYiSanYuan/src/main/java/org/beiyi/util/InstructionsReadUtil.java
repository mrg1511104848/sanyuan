package org.beiyi.util;

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
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;

import com.github.crab2died.ExcelUtils;

/**
 * 整理好的说明书读取类
 * @author 2bu
 *
 */
public class InstructionsReadUtil {
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
		
		try {
			String instrunctionPath = "D://爱客服/数据_ALL/北医三院/三院提供/20180418说明书提取框架&demo新.xlsx";
//			instrunctionPath = "C://公司/北医三院/20180418说明书提取框架&demo新.xlsx";
			
			records = ExcelUtils.getInstance().readExcel2List(instrunctionPath);
		} catch (InvalidFormatException | IOException e) {
			e.printStackTrace();
		}
		shiYingZhengRead();
	}
	public static Instruction get(String drugCombinationName){
		for (Instruction instruction : instructions) {
			if(instruction.getDrugCombinationName().equals(drugCombinationName)){
				return instruction;
			}
		}
		return null;
	}
	public static List<Instruction> shiYingZhengRead(){
		for (int i = 3; i < records.size(); i++) {
			List<String> r = records.get(i);
			if(r.size()<20) continue;
			String tongYongName = r.get(0);
			if(StringUtils.isBlank(tongYongName) || tongYongName.equals("直接提取")){
				continue;
			}
			String shangPinName = r.get(1);
			tongYongName = tongYongName.trim();
			DrugCombinationName drugCombinationName = new DrugCombinationName(shangPinName, tongYongName);
			String combinationName = drugCombinationName.getCombinationStandardName();
			String shiyingzheng = r.get(20);
			String shiyingzhengKuoZhan = r.get(21);
			Set<String> syzAll = getOneDrugShiYingZhengAll(shiyingzheng,shiyingzhengKuoZhan);//单个药品所有的适应症
			
			Instruction instruction = new Instruction();
			instruction.setDrugCombinationName(combinationName);
			if(instructions.contains(instruction)){
				for (Instruction inst : instructions) {
					if(inst.equals(instruction)){
						instruction = inst;
						break;
					}
				}
			}
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
			instruction.setForm(r.get(4));
			instruction.setStandard(r.get(10));
			
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
		shiYingZhengRead();
	}
	public static boolean contains(String combinationName) {
		for (Instruction instruction : instructions) {
			if(instruction.getDrugCombinationName().equals(combinationName)){
				return true;
			}
		}
		return false;
	}
}
