package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.beiyi.changliang.DrugInfoEnum;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.DosingFrequencyUtil;
import org.beiyi.util.InstructionsReadUtil;
import org.beiyi.util.VerifyUtil;
import org.skynet.frame.util.DoubleUtil;
import org.skynet.frame.util.RegexUtils;

/**
 * 疗程审核
 * 
 * @author mrg
 *
 */
public class CourseOfTreatmentVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行计量审核
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			// 获取整理好的说明书的药品
			Instruction instructionDrug = InstructionsReadUtil.get(chuFangDrug
					.getDrugCombinationName());
			if (instructionDrug == null) {
				notExistsDrugs.add(chuFangDrug);
				continue;
			}
			boolean containsInVerifyResultErrorDrugs = VerifyUtil
					.chuFangDrugContainsInVerifyResultErrorDrugs(verifyResult,
							chuFangDrug);
			if (containsInVerifyResultErrorDrugs) {
				continue;
			}
			// 用来存放剂量审核的记录，最后进行最终剂量评判的标准
			List<ChuFangCheckRecord> dosageCheckRecords = new ArrayList<ChuFangCheckRecord>();
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
				Integer canUseDay = getCanUseDays(chuFangDrug);
				if(canUseDay == null){
					logger.warn(String.format("The canUseDay of [drugName] %s is blank!", chuFangDrug.getDrugCombinationName()));
					continue;
				}
				
			}
		}
		return verifyResult;
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
		String dosingFrequency = chuFangDrug.getDosingFrequency();
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
