package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.changliang.DrugInfoEnum;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.DosingFrequencyUtil;
import org.beiyi.util.InstructionsReadUtil;
import org.beiyi.util.VerifyUtil;
import org.skynet.frame.util.DoubleUtil;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.StringBufferUtil;

/**
 * 疗程审核
 * 
 * @author mrg
 *
 */
public class CourseOfTreatmentVerifyService implements IDrugVeryfy {
	private static final String COURSE_OF_TREATMENT_REGEX = "(\\d+([-~]\\d+)?)";
	public static void main(String[] args) {
	}
	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
//		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行计量审核
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			if(chuFangDrug.getDrugCombinationName().contains("布洛芬")){
				System.out.println();
			}
			// 获取整理好的说明书的药品
			Instruction instructionDrug = InstructionsReadUtil.get(chuFangDrug
					.getDrugCombinationName());
//			if (instructionDrug == null) {
//				notExistsDrugs.add(chuFangDrug);
//				continue;
//			}
			boolean containsInVerifyResultErrorDrugs = VerifyUtil
					.chuFangDrugContainsInVerifyResultErrorDrugs(verifyResult,
							chuFangDrug);
			if (containsInVerifyResultErrorDrugs) {
				continue;
			}
			// 用来存放剂量审核的记录，最后进行最终剂量评判的标准
			List<ChuFangCheckRecord> checkRecords = new ArrayList<ChuFangCheckRecord>();
			List<InstructionUse> instructionUses = instructionDrug
					.getInstructionUses();
			// 遍历 整理好的说明书 - 药品使用相关信息
			for (InstructionUse instructionUse : instructionUses) {
				String instructionPatientStatusText = instructionUse
						.getPatientStatus();// 患者状态
				String instructionDoseSelection = instructionUse
						.getDoseSelection();// 剂量选择
				instructionDoseSelection = VerifyUtil
						.parseDoseSelection(instructionDoseSelection); // 转换一下说明书中的剂量选择
				// 0.筛选人群
				boolean crowdValid = VerifyUtil.crowdIsValid(chuFang,
						instructionPatientStatusText);
				if (!crowdValid) {// 不属于该人群的话，continue;
					continue;
				}
				//1.获取可使用的天数
				Integer canUseDay = getCanUseDays(chuFangDrug);
				if(canUseDay == null){
					logger.warn(String.format("The canUseDay of [drugName] %s is blank!", chuFangDrug.getDrugCombinationName()));
					continue;
				}
				//2.校验是否符合疗程天数
				ChuFangCheckRecord checkResult = checkDaysIsMatchCourseOfTreatment(canUseDay,chuFangDrug,instructionUse);
				checkRecords.add(checkResult);
			}
			if(checkRecords.size()!=0){
				VerifyUtil.appendDrugAndErrorMsg(checkRecords,chuFangDrug,this,errMsgBuffer,verifyResult,VerifyTypeEnums.INVALID_COURSE_OF_TREATMENT);
			}
		}
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}
	public String appendErrors(Drug chuFangDrug,
			List<ChuFangCheckRecord> errors) {
		StringBuffer resultMsg = new StringBuffer(String.format("药品 “%s” 疗程应在",
				chuFangDrug.getDrugCombinationName()));
		resultMsg.append("（");
		for (ChuFangCheckRecord chuFangErrRecord : errors) {
			String rangeEach = chuFangErrRecord.getInstructionUse().getCourseControl();
			resultMsg.append(rangeEach+",");
		}
		resultMsg = StringBufferUtil.removeEnd(resultMsg, ",");
		resultMsg.append("）范围内");
		return resultMsg.toString();
	}
	
	/**
	 * 校验可使用天数是否符合疗程天数
	 * @param canUseDay
	 * @param instructionUse 
	 * @param chuFangDrug 
	 * @return 
	 */
	private ChuFangCheckRecord checkDaysIsMatchCourseOfTreatment(Integer canUseDay, Drug chuFangDrug, InstructionUse instructionUse) {
		ChuFangCheckRecord checkRecord = new ChuFangCheckRecord();
		checkRecord.setValid(true);
		
		
		ChuFangCheckRecord medicalInsuranceValid = checkMedicalInsuranceIsValid(canUseDay);//医保
		medicalInsuranceValid.setChuFangDrug(chuFangDrug);
		medicalInsuranceValid.setInstructionUse(instructionUse);
		if(!medicalInsuranceValid.getValid()){
			return medicalInsuranceValid;
		}
		ChuFangCheckRecord courseOfTreatmentValid = courseOfTreatmentIsValid(canUseDay,chuFangDrug,instructionUse);//普通疗程
		courseOfTreatmentValid.setChuFangDrug(chuFangDrug);
		courseOfTreatmentValid.setInstructionUse(instructionUse);
		if(!courseOfTreatmentValid.getValid()){
			return courseOfTreatmentValid;
		}
		return checkRecord;
	}

	private ChuFangCheckRecord courseOfTreatmentIsValid(Integer canUseDay, Drug chuFangDrug, InstructionUse instructionUse) {
		ChuFangCheckRecord chuFangCheckRecord = new ChuFangCheckRecord();
		chuFangCheckRecord.setValid(true);
		if(StringUtils.isBlank(instructionUse.getCourseControl())){
//			logger.warn(String.format("The courseControl of drug “%s” is blank!", chuFangDrug.getDrugCombinationName()));
			return chuFangCheckRecord;
		}
		String dayOrDayRange = RegexUtils.getByRegex(COURSE_OF_TREATMENT_REGEX, instructionUse.getCourseControl());
		if(StringUtils.isBlank(dayOrDayRange)){
			logger.warn(String.format("The courseControl of drug “%s” is not match COURSE_OF_TREATMENT_REGEX", chuFangDrug.getDrugCombinationName()));
			return chuFangCheckRecord;
		}
		if(dayOrDayRange.contains("-") || dayOrDayRange.contains("~")){
			String[] rangeArr = dayOrDayRange.split("-|~");
			String dayStart = rangeArr[0];
			String dayEnd = rangeArr[1];
			if(StringUtils.isNotBlank(dayStart) || StringUtils.isNotBlank(dayEnd)){
				logger.warn(String.format("The dayStart or dayEnd of drug “%s” is blank!", chuFangDrug.getDrugCombinationName()));
				return chuFangCheckRecord;
			}
			if(!(canUseDay>=Integer.parseInt(dayStart)
					&&canUseDay<=Integer.parseInt(dayEnd))){
				chuFangCheckRecord.setValid(false);
			}
		}else{//非范围直接匹配
			if(canUseDay>Integer.parseInt(dayOrDayRange)){
				chuFangCheckRecord.setValid(false);
			}
		}
		return chuFangCheckRecord;
	}
	private ChuFangCheckRecord checkMedicalInsuranceIsValid(Integer canUseDay) {
		ChuFangCheckRecord chuFangCheckRecord = new ChuFangCheckRecord();
		chuFangCheckRecord.setValid(true);
		return chuFangCheckRecord;
	}
	private Integer getCanUseDays(Drug chuFangDrug) {
		String chuFangStandard = chuFangDrug.getStandard();
		List<String> mqRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, chuFangStandard, 1);
		List<String> muRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, chuFangStandard, 2);
		List<String> fqRegex = RegexUtils.getByGroup(DrugInfoEnum.standardRegex, chuFangStandard, 3);
		//计算每盒的有效成分量
		if(mqRegex.size() == 0 || fqRegex.size() == 0 || muRegex.size() == 0){
			System.out.println("mqRegex.size() == 0 || fqRegex.size() == 0 || muRegex.size() == 0");
			return null;
		}
		String mq = mqRegex.get(0);
		String mu = muRegex.get(0);
		String fq = fqRegex.get(0);
		double doubleMq = DoubleUtil.parseStr2Double(mq, 3);
		Integer intFq = Integer.parseInt(fq);
		double containsCfEach = doubleMq*intFq;//计算每盒药有效成分量
		
		//每次用量
		String cfEachTimeUse = chuFangDrug.getDosage();
		String cfEachTimeUseUnit = chuFangDrug.getDosageUnit();
		int totalPack = Integer.parseInt(chuFangDrug.getDrugQuantity());
		String dosingFrequency = chuFangDrug.getDosingFrequency().trim();
		// 进行包装单位转换
		String[] standardDosageParse = VerifyUtil.parseDosagePackUnit(chuFangStandard, containsCfEach+"", mu);
		String[] eachTimeUseDosageParse = VerifyUtil.parseDosagePackUnit(chuFangStandard, cfEachTimeUse, cfEachTimeUseUnit);
		if(eachTimeUseDosageParse == null || standardDosageParse == null){
			return null;
		}
		
		// 进行剂量单位转换
		String[] standardDosageStandard = VerifyUtil.parseDosageUnitToStandard(
				standardDosageParse[0], standardDosageParse[1]);
		String[] eachTimeUseDosageStandard = VerifyUtil.parseDosageUnitToStandard(eachTimeUseDosageParse[0],
				eachTimeUseDosageParse[1]);
		if(standardDosageStandard == null || eachTimeUseDosageStandard == null){
			return null;
		}		
		
		double doubleStandardDosageStandard = DoubleUtil.parseStr2Double(standardDosageStandard[0], 3);//包装总剂量
		double doubleEachTimeUse = DoubleUtil.parseStr2Double(eachTimeUseDosageStandard[0], 3);//每次剂量
		//一盒的次数 * 总盒数 = 一共可以吃几次
		int allCanUseTimeEachPack = (int)(doubleStandardDosageStandard/doubleEachTimeUse);
		//包装总剂量/每次剂量 = 一盒可以吃几次 
		int allCanUseTimeAllPack = allCanUseTimeEachPack*totalPack;
		String[] dayTimeArr = DosingFrequencyUtil.getDosingFrequency(dosingFrequency);
		if(dayTimeArr == null){
			return null;
		}
		int day = Integer.parseInt(dayTimeArr[0]);
		int time = Integer.parseInt(dayTimeArr[1]);
		
		//一共可以吃的次数/频率(一天几次 / 2天一次 ) 算出一共可以吃几天。
		int totalCanUseDay = (int)Math.ceil((double)(allCanUseTimeAllPack/time*day));
		System.out.println("处方规格:"+chuFangStandard+",一共"+totalPack+"盒,"+day+"天/"+time+"次,"+"每次用量"+cfEachTimeUse+cfEachTimeUseUnit);
		System.out.println("一盒共可以吃"+allCanUseTimeEachPack+"次");
		System.out.println("所有盒共可以吃"+allCanUseTimeAllPack+"次");
		System.out.println("一共可吃"+totalCanUseDay+"天");
		return totalCanUseDay;
	}

}
