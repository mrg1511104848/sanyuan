package org.beiyi.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.beiyi.changliang.DrugInfoEnum;
import org.beiyi.changliang.JiLiangOpratorEnum;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.entity.verify.HuanZhe;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.entity.verify.Oprator;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.reource.Resources;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.skynet.frame.util.DoubleUtil;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.date.DateUtil;
import org.skynet.frame.util.excel.ExcelUtil;

public class VerifyUtil {
	private static Logger log = Logger.getLogger(VerifyUtil.class);
	private static final String AGE_KEYWORD_REGEX = ".*成人.*|.*年龄.*|.*岁.*|.*儿童.*|.*老年.*";
	public static void main(String[] args) {
		System.out.println("10.0，300".matches("(\\d+|\\d+.\\d+)[;；](\\d+|\\d+.\\d+)"));
	}
	public static Instruction getInstructionOfChuFangDrug(Drug chuFangDrug) {
		// 获取整理好的说明书的药品
		Instruction instruction = InstructionsReadUtil.get(chuFangDrug
				.getDrugCombinationName());
		return instruction;
	}
	public static boolean chuFangDrugContainsInVerifyResultErrorDrugs(VerifyResult verifyResult,Drug chuFangDrug){
		List<DrugVerifyInfo> errorDrugs = verifyResult.getErrorDrugs();
		for (DrugVerifyInfo drugVerifyInfo : errorDrugs) {
			if(drugVerifyInfo.getDrug().equals(chuFangDrug)){
				return true;
			}
		}
		return false;
	}
	public static void addErrorDrugToVerifyResult(VerifyResult verifyResult,Drug chuFangDrug,int errType){
		DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug,errType);
		verifyResult.getErrorDrugs().add(drugVerifyInfo);
		
	}
	public static void addSuccessDrugToVerifyResult(VerifyResult verifyResult,Drug chuFangDrug){
		DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug);
		verifyResult.getSuccessDrugs().add(drugVerifyInfo);
	}
	public static void addNotExistsDrugToVerifyResult(VerifyResult verifyResult,Set<Drug> notExistsDrugs,StringBuffer errMsgBuffer){
		if (notExistsDrugs.size() > 0) {
			for (Drug notExistsDrug : notExistsDrugs) {
				DrugVerifyInfo notExistsDrugVerifyInfo = new DrugVerifyInfo(
						notExistsDrug, VerifyTypeEnums.NO_DRUG);
				verifyResult.getErrorDrugs().add(notExistsDrugVerifyInfo);
				errMsgBuffer.append(String.format("药品“%s” 不存在。",
						notExistsDrug.getDrugCombinationName()));
			}
		}
	}
	public static void packVerifyResultFinal(VerifyResult verifyResult,StringBuffer errMsgBuffer){
		if (verifyResult.getErrorDrugs().size() > 0) {
			verifyResult.setSuccess(false);
			verifyResult.setResultMsg(errMsgBuffer.toString());
		} else {
			verifyResult.setSuccess(true);
		}
	}
	/**
	 * 根据处方中的患者的生日等信息和说明书的患者状态，过滤看患者是否属于那个人群
	 * 
	 * @param chuFang
	 * @param instructionPatientStatusText
	 */
	public static boolean crowdIsValid(ChuFang chuFang,
			String instructionPatientStatusText) {
		HuanZhe huanZhe = chuFang.getHuanZhe();
		if (huanZhe == null)
			throw new RuntimeException("The huanZhe is blank!");

		if (instructionPatientStatusText.contains("暂无")) {
			return true;
		} else if (instructionPatientStatusText.matches(AGE_KEYWORD_REGEX)) {
			if (StringUtils.isNotBlank(huanZhe.getBornDate())) {
				// DateUtils.parseDate(str, parsePatterns)
				try {
					Date bornDate = DateUtil.parseToDate(huanZhe.getBornDate());
					// 查看患者的年龄是否在区间内
					return compareBornDateInInstructionPatientStatus(bornDate,
							instructionPatientStatusText);
				} catch (ParseException e) {
					log.error("The bornDate is not valid", e);
					return false;
				}
			}
		} else {
			// 判断用户的诊断是否符合说明书的患者状态
			List<String> diagnosisesList = chuFang.getDiagnosises();
			if(diagnosisesList==null){ return false;}
			for (String diagnosis : diagnosisesList) {
				if (compareDiagnosisAndInstructionPatientStatus(diagnosis,
						instructionPatientStatusText)) {
					return true;
				}
			}

		}
		return false;
	}
	/**
	 * 查看患者的年龄是否在说明书的患者状态 (成人|老年|other)区间内
	 * 
	 * @param bornDate
	 * @param instructionPatientStatusText
	 * @return
	 */
	private static boolean compareBornDateInInstructionPatientStatus(Date bornDate,
			String instructionPatientStatusText) {
		System.out.println(new SimpleDateFormat(DateUtil.DATE_FORMAT_02)
				.format(bornDate));
		String ageCondition = Resources.patientStatusMap
				.get(instructionPatientStatusText);
		if (StringUtils.isNotBlank(ageCondition)) {
			if (ageCondition.contains("or")) {
				String[] orConditions = ageCondition.split("or");
				boolean condition0InSection = DateUtil.dateInSection(bornDate,
						orConditions[0]);
				boolean condition1InSection = DateUtil.dateInSection(bornDate,
						orConditions[1]);
				if (condition0InSection || condition1InSection) {
					return true;
				}
			} else if (ageCondition.contains("and")) {
				String[] andConditions = ageCondition.split("and");
				boolean condition0InSection = DateUtil.dateInSection(bornDate,
						andConditions[0]);
				boolean condition1InSection = DateUtil.dateInSection(bornDate,
						andConditions[1]);
				if (condition0InSection && condition1InSection) {
					return true;
				}
			} else {
				boolean condition0InSection = DateUtil.dateInSection(bornDate,
						ageCondition);
				return condition0InSection;
			}
		}
		return false;
	}
	private static boolean compareDiagnosisAndInstructionPatientStatus(
			String diagnosis, String instructionPatientStatusText) {
		if (StringUtils.isBlank(diagnosis))
			return false;
		if (diagnosis.equals(instructionPatientStatusText)) {
			return true;
		}
		return false;
	}
	public static String[] parseUnitToStandard(Drug chuFangDrug,Instruction instructionDrug,InstructionUse instructionUse,
			StringBuffer chuFangErrBuffer,VerifyResult verifyResult) {
		String chuFangDrugDosageUnit = chuFangDrug.getDosageUnit(); // 用量单位;
		String instructionDosageUnit = instructionUse.getDosageUnit(); // 粒 片 次/日
//		if (!chuFangDrugDosageUnit.equals(instructionDosageUnit)) {// 不一致
			// 统一单位
			String[] dosageArr = parseToStandardUnit(chuFangDrug,
					instructionUse);// 统一剂量单位 index:[0]
									// chuFangDrugDosage index:[1]
									// instructionDosage
			if (dosageArr == null) {
				String errorMsg = String
						.format(" [统一剂量单位] %s 换算失败  [chuFangDrugDosageUnit] %s [instructionDosageUnit] %s",
								instructionDrug.getDrugCombinationName(),
								chuFangDrugDosageUnit,
								instructionDosageUnit);
				log.error(errorMsg);
				chuFangErrBuffer.append(String.format(
								"%s【药品】 %s 剂量不适宜，具体原因为 ： %s",
								ExcelUtil.NEW_LINE,
								chuFangDrug.getDrugCombinationName(),
								errorMsg));
				// 将处方中错误的药品封装到verifyResult
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(
						chuFangDrug,
						VerifyTypeEnums.ERROR_PARSE_DOSAGE_UNIT);
				verifyResult.getErrorDrugs().add(drugVerifyInfo);
				return null;
			} else {
				String chuFangDrugDosageStandard = dosageArr[0];
				String chuFangDrugDosageUnitStandard = dosageArr[1];
				String instructionDosageStandard = dosageArr[2];
				String instructionDosageUnitStandard = dosageArr[3];
				return new String[]{chuFangDrugDosageStandard,chuFangDrugDosageUnitStandard,
						instructionDosageStandard,instructionDosageUnitStandard};
			}
//		}
//		return null;
	}
	/**
	 * 统一单位
	 * 
	 * @param instructionUse
	 *            说明书
	 * @param chuFangDrug
	 *            处方
	 * @return index:[0] 处方中的格式化后的剂量 index:[1] 说明书中的格式化后的剂量
	 */
	private static String[] parseToStandardUnit(Drug chuFangDrug,
			InstructionUse instructionUse) {
		if (chuFangDrug == null || instructionUse == null) {
			return null;
		}

		String chuFangDrugStandard = chuFangDrug.getStandard();// 处方药品规格
		if (chuFangDrugStandard == null) {
			throw new RuntimeException(String.format("[chuFangDrug-name] %s's standard is blank", chuFangDrug.getDrugCombinationName()));
		}
		// 查看处方的Drug的剂量单位 和 说明书的Drug的剂量单位 ， 是否可以直接转换为mg
		String chuFangDosage = chuFangDrug.getDosage();
		String chuFangDosageUnit = chuFangDrug.getDosageUnit();

		String instructionDosage = instructionUse.getDosage();
		String instructionDosageUnit = instructionUse.getDosageUnit();

		String[] chuFangDosageStandard = null;
		List<String[]> instructionDosageStandards = null;

		// 进行包装单位转换
		String[] chuFangDosageAndDosageUnit = parseDosagePackUnit(chuFangDrug, chuFangDosage, chuFangDosageUnit);
		String[] instructionDosageAndDosageUnit = parseDosagePackUnit(chuFangDrug, instructionDosage, instructionDosageUnit);
		if(chuFangDosageAndDosageUnit == null || instructionDosageAndDosageUnit == null){
			//发现药品单位是包装单位但是转换失败。
			return null;
		}
		// 进行剂量单位转换
		chuFangDosageStandard = parseDosageUnitToStandard(chuFangDosageAndDosageUnit[0],
				chuFangDosageAndDosageUnit[1]);
		;
		instructionDosageStandards = parseDosageUnitToStandardList(
				instructionDosageAndDosageUnit[0], instructionDosageAndDosageUnit[1]);

		if(instructionDosageStandards == null) {
			return null;
		}
		for (String[] instructionDosageStandard : instructionDosageStandards) {
			if (chuFangDosageStandard != null && instructionDosageStandard != null
					&& chuFangDosageStandard.length == 2
					&& instructionDosageStandard.length == 2) {
				if (StringUtils.isBlank(chuFangDosageStandard[1])
						|| StringUtils.isBlank(instructionDosageStandard[1])) {
					return null;
				}
				if (chuFangDosageStandard[1].equals(instructionDosageStandard[1])) {
					return new String[] { chuFangDosageStandard[0],chuFangDosageStandard[1],
							instructionDosageStandard[0],instructionDosageStandard[1] };
				}
			}
		}
		return null;
	}
	/**
	 * 针对包装单位的转换
	 * 
	 * @param chuFangDrug
	 * @param dosage
	 * @param dosageUnit
	 * @return
	 */
	public static String[] parseDosagePackUnit(String chuFangDrugStandard,String dosage,
			String dosageUnit) {
		if (StringUtils.isBlank(dosage)) {
			throw new RuntimeException("The dosage is blank!");
		}
		if (StringUtils.isBlank(dosageUnit)) {
			throw new RuntimeException("The DosageUnit is blank!");
		}
		if (!dosageUnit.matches("粒|拴|揿|瓶|片|喷|枚")) {
			return new String[] { dosage, dosageUnit };
		}
		if (chuFangDrugStandard == null) {
			return null;
		}
		String chuFangDosagePackUnitFromDrugStandard = getDosagePackUnit(chuFangDrugStandard); // 处方中的包装单位

		if (StringUtils.isBlank(chuFangDosagePackUnitFromDrugStandard)) {
			return null;
		}
		// 计量单位/包装单位dosageUnit 是否等于处方中的包装单位，相等的话在转换剂量及单位
		if (dosageUnit.trim().equalsIgnoreCase(chuFangDosagePackUnitFromDrugStandard.trim())) {
			// 0.3g * 20粒 /盒  
			//得到 0.3(dosageFromDrugStandard) 和 g(dosageUnitFromDrugStandard)
			String dosageFromDrugStandard = getDosage(chuFangDrugStandard);// 从规格中获取处方中的剂量
			String dosageUnitFromDrugStandard = getDosageUnit(chuFangDrugStandard);// 从规格中获取处方中的剂量单位
			
			if(StringUtils.isBlank(dosageFromDrugStandard)){
				return null;
			}
			if(StringUtils.isBlank(dosageFromDrugStandard)){
				return null;
			}
			//0.3(dosageFromDrugStandard) 和 1(dosage) 相乘得到每次用量
			double dosageDouble = DoubleUtil.parseStr2Double(dosageFromDrugStandard, 3);
			double dosageFromDrugStandardDouble = DoubleUtil.parseStr2Double(dosage, 3);
			double dosageShouldBeUseEachTime = dosageDouble * dosageFromDrugStandardDouble; //相乘得到每次应该用的量
			
			//将g(dosageUnitFromDrugStandard)和相乘得到每次应该用的量dosageShouldBeUseEachTime相组合，返回。
			return new String[] { dosageShouldBeUseEachTime+"", dosageUnitFromDrugStandard };
		}
		return null;
	}
	/**
	 * 针对包装单位的转换
	 * 
	 * @param chuFangDrug
	 * @param dosage
	 * @param dosageUnit
	 * @return
	 */
	private static String[] parseDosagePackUnit(Drug chuFangDrug, String dosage,
			String dosageUnit) {
		if (StringUtils.isBlank(dosage)) {
			throw new RuntimeException("The dosage is blank!");
		}
		if (StringUtils.isBlank(dosageUnit)) {
			throw new RuntimeException("The DosageUnit is blank!");
		}
		if (!dosageUnit.matches("粒|拴|揿|瓶|片|喷|枚")) {
			return new String[] { dosage, dosageUnit };
		}
		String chuFangDrugStandard = chuFangDrug.getStandard();// 规格
		if (chuFangDrugStandard == null) {
			log.error(String.format("[处方-药品] %s 规格为空",
					chuFangDrug.getDrugCombinationName()));
			return null;
		}
		String chuFangDosagePackUnitFromDrugStandard = getDosagePackUnit(chuFangDrugStandard); // 处方中的包装单位

		if (StringUtils.isBlank(chuFangDosagePackUnitFromDrugStandard)) {
			log.error(String.format("[处方-药品] %s 处方中规格 “%s” 获取的包装单位为空",
					chuFangDrug.getDrugCombinationName(),chuFangDrugStandard));
			return null;
		}
		// 计量单位/包装单位dosageUnit 是否等于处方中的包装单位，相等的话在转换剂量及单位
		if (dosageUnit.trim().equalsIgnoreCase(chuFangDosagePackUnitFromDrugStandard.trim())) {
			// 0.3g * 20粒 /盒  
			//得到 0.3(dosageFromDrugStandard) 和 g(dosageUnitFromDrugStandard)
			String dosageFromDrugStandard = getDosage(chuFangDrugStandard);// 从规格中获取处方中的剂量
			String dosageUnitFromDrugStandard = getDosageUnit(chuFangDrugStandard);// 从规格中获取处方中的剂量单位
			
			if(StringUtils.isBlank(dosageFromDrugStandard)){
				log.error(String.format("[处方-药品] %s 处方中规格 “%s” 获取的剂量为空",
						chuFangDrug.getDrugCombinationName(),chuFangDrugStandard));
				return null;
			}
			if(StringUtils.isBlank(dosageFromDrugStandard)){
				log.error(String.format("[处方-药品] %s 处方中规格 “%s” 获取的剂量单位为空",
						chuFangDrug.getDrugCombinationName(),chuFangDrugStandard));
				return null;
			}
			//0.3(dosageFromDrugStandard) 和 1(dosage) 相乘得到每次用量
			double dosageDouble = DoubleUtil.parseStr2Double(dosageFromDrugStandard, 3);
			double dosageFromDrugStandardDouble = DoubleUtil.parseStr2Double(dosage, 3);
			double dosageShouldBeUseEachTime = dosageDouble * dosageFromDrugStandardDouble; //相乘得到每次应该用的量
			
			//将g(dosageUnitFromDrugStandard)和相乘得到每次应该用的量dosageShouldBeUseEachTime相组合，返回。
			return new String[] { dosageShouldBeUseEachTime+"", dosageUnitFromDrugStandard };
		}
		return null;
	}
	/**
	 * 转换成常规的剂量单位，不对包装单位转换 //常见质量单位：1克（g）=1000毫克（mg）=10000000微克（μg）；
	 * //常见体积单位：1升（L）=1000毫升（ml）=1000000微升（μl）；
	 * 
	 * @param dosage
	 * @param dosageUnit
	 * @return
	 */
	public static List<String[]> parseDosageUnitToStandardList(String dosage, String dosageUnit) {
		List<String[]> parseResults = new ArrayList<String[]>();
		if(dosage.matches("(\\d+|\\d+.\\d+)[;；](\\d+|\\d+.\\d+)")){
			String[] dosageArr = dosage.split("；|;");
			for (String dsg : dosageArr) {
				String[] parseResult = parseDosageUnitToStandard(dsg, dosageUnit);
				if(parseResult== null || parseResult.length == 0){
					continue;
				}
				parseResults.add(parseResult);
			}
		}else{
			String[] parseResult = parseDosageUnitToStandard(dosage, dosageUnit);
			parseResults.add(parseResult);
		}
		return parseResults;
	}
	/**
	 * 转换成常规的剂量单位，不对包装单位转换 //常见质量单位：1克（g）=1000毫克（mg）=10000000微克（μg）；
	 * //常见体积单位：1升（L）=1000毫升（ml）=1000000微升（μl）；
	 * 
	 * @param dosage
	 * @param dosageUnit
	 * @return
	 */
	public static String[] parseDosageUnitToStandard(String dosage, String dosageUnit) {
		if (StringUtils.isBlank(dosage) || StringUtils.isBlank(dosageUnit)) {
			return null;
		}
		String parsedDosage = null;
		if(Resources.dosageUnitConversionMap.containsKey(dosageUnit)){
			String[] convertInfo = Resources.dosageUnitConversionMap.get(dosageUnit);
			String parsedDosageUnit = convertInfo[0];
			String opNum = convertInfo[1];
			String op = convertInfo[2];
			Oprator oprator = getSpecialParseToStandardOp(opNum);
			if(oprator.getType().equals(JiLiangOpratorEnum.BETWEEN)){
				List<Double> ranges = oprator.getToCompareNums();
				if(op.equals(JiLiangOpratorEnum.MULTIPLY)){
					double start = DoubleUtil.parseStr2Double(dosage, 3)*ranges.get(0);
					double end = DoubleUtil.parseStr2Double(dosage, 3)*ranges.get(1);
					parsedDosage = start+"~"+end;
				}else{
					throw new RuntimeException(" The other oprators not support!");
				}
			}else if(oprator.getType().equals(JiLiangOpratorEnum.EQ)){
				if(op.equals(JiLiangOpratorEnum.MULTIPLY)){
					double parsedDosageDouble = DoubleUtil.parseStr2Double(dosage, 3)*DoubleUtil.parseStr2Double(opNum, 3);
					parsedDosage = parsedDosageDouble + "";
				}else if(op.equals(JiLiangOpratorEnum.DEVIDED)){
					double parsedDosageDouble = DoubleUtil.parseStr2Double(dosage, 3)/DoubleUtil.parseStr2Double(opNum, 3);
					parsedDosage = parsedDosageDouble + "";
				}
			}
			return new String[] { parsedDosage, parsedDosageUnit };
		}
		return null;
	}
	private static Oprator getSpecialParseToStandardOp(String insDosage) {
		Oprator oprator = new Oprator();
		String[] regex = { "(\\d+|\\d+.\\d+)~(\\d+|\\d+.\\d+)", "(\\d+)","(\\d+|\\d+.\\d+)[;；](\\d+|\\d+.\\d+)" };
		String[] regexType = { JiLiangOpratorEnum.BETWEEN,
				JiLiangOpratorEnum.EQ,JiLiangOpratorEnum.OR };
		for (int i = 0; i < regex.length; i++) {
			String r = regex[i];
			List<String> tarNums = RegexUtils.getByGroup(r, insDosage);
			if (tarNums.size() != 0) {
				List<Double> toCompareNums = new ArrayList<Double>();
				for (String n : tarNums) {
					toCompareNums.add(DoubleUtil.parseStr2Double(n, 3));
				}
				oprator.setType(regexType[i]);
				oprator.setToCompareNums(toCompareNums);
				break;
			}
		}
		return oprator;
	}
	/**
	 * 根据规则获取剂量
	 * 
	 * @param standard
	 * @return
	 */
	private static String getDosage(String standard) {
		List<String> dosageList = RegexUtils.getByGroup(
				DrugInfoEnum.standardRegex, standard, 1);
		return dosageList == null || dosageList.size() == 0 ? null : dosageList
				.get(0).trim();
	}
	/**
	 * 根据规则获取剂量单位
	 * 
	 * @param standard
	 * @return
	 */
	private static String getDosageUnit(String standard) {
		List<String> dosageList = RegexUtils.getByGroup(
				DrugInfoEnum.dosageUnitRegex, standard, 2);
		return dosageList == null || dosageList.size() == 0 ? null : dosageList
				.get(0).trim();
	}
	/**
	 * 根据规则获取包装单位 如 粒、颗
	 * 
	 * @param standard
	 * @return
	 */
	private static String getDosagePackUnit(String standard) {
		List<String> dosageList = RegexUtils.getByGroup(
				DrugInfoEnum.standardRegex, standard, 4);
		return dosageList == null || dosageList.size() == 0 ? null : dosageList
				.get(0).trim();
	}
	public static String parseDoseSelection(String doseSelection){
		if(StringUtils.isBlank(doseSelection)){
			return "常规剂量";
		}
		return doseSelection;
	}
	public static void appendDrugAndErrorMsg(List<ChuFangCheckRecord> checkRecords,Drug chuFangDrug,IDrugVeryfy verify,StringBuffer errMsgBuffer,VerifyResult verifyResult,int errType){
		List<ChuFangCheckRecord> errors = VerifyUtil.getErrorCheckRecords(checkRecords);
		if(errors.size()>0){
			String errorMsg = verify.appendErrors(chuFangDrug,errors);
			errMsgBuffer.append(errorMsg);
			VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrug, errType);
		}else{
			VerifyUtil.addSuccessDrugToVerifyResult(verifyResult, chuFangDrug);
		}
	}
	public static List<ChuFangCheckRecord> getErrorCheckRecords(List<ChuFangCheckRecord> checkRecords) {
		if(checkRecords== null || checkRecords.size() == 0){
			throw new RuntimeException("The checkRecords is blank!");
		}
		List<ChuFangCheckRecord> errorResults = new ArrayList<ChuFangCheckRecord>();
		for (ChuFangCheckRecord dosageCheckRecord : checkRecords) {
			if(dosageCheckRecord.getValid()){
				return new ArrayList<ChuFangCheckRecord>(0);
			}
		}
		
		for (ChuFangCheckRecord dosageCheckRecord : checkRecords) {
			if(!dosageCheckRecord.getValid()){
				errorResults.add(dosageCheckRecord);
			}
		}
		return errorResults;
	}
}
