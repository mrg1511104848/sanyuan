package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.dao.IndicationTherapeuticRegimenMapper;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.db.IndicationTherapeuticRegimen;
import org.beiyi.entity.db.condition.IndicationTherapeuticRegimenCondition;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.impl.DosageVerifyService.DosageCheckResult;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.DosingFrequencyUtil;
import org.beiyi.util.InstructionsReadUtil;
import org.beiyi.util.VerifyUtil;
import org.skynet.frame.util.DoubleUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 最大日剂量审核
 * 
 * @author 2bu
 *
 */
@Service
public class DosageMaxLimitVerifyService implements IDrugVeryfy {
	@Autowired
	IndicationTherapeuticRegimenMapper indicationTherapeuticRegimenMapper;
	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
		// Set<Drug> notExistsDrugs = new HashSet<Drug>();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行计量审核
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			// 获取整理好的说明书的药品
//			Instruction instructionDrug = InstructionsReadUtil.get(chuFangDrug
//					.getDrugCombinationName());
			List<ChuFangCheckRecord> dosageCheckRecords = new ArrayList<ChuFangCheckRecord>();
//			List<InstructionUse> instructionUses = instructionDrug
//					.getInstructionUses();
			if(chuFangDrug.getDrugCombinationName().contains("泰诺")){
				System.out.println();
			}
			List<String> diagnosises = chuFang.getDiagnosises();
			IndicationTherapeuticRegimenCondition condition = new IndicationTherapeuticRegimenCondition();
			DrugCombinationName drugCombinationName = new DrugCombinationName(chuFangDrug.getDrugCombinationName());
			condition.setCommodityName(drugCombinationName.getShangPinName());
			condition.setCommonName(drugCombinationName.getTongYongName());
			condition.setIndications(diagnosises);
			
			List<IndicationTherapeuticRegimen> results = indicationTherapeuticRegimenMapper.selectByCondition(condition);
			for (IndicationTherapeuticRegimen instructionUse : results) {
				String instructionPatientStatusText = instructionUse
						.getPatientStatus();// 患者状态
				// 0.筛选人群
				boolean crowdValid = VerifyUtil.crowdIsValid(chuFang,
						instructionPatientStatusText);
				if (!crowdValid) {// 不属于该人群的话，continue;
					continue;
				}
				String instructionDoseSelection = instructionUse
						.getDoseSelection();// 剂量选择
				instructionDoseSelection = VerifyUtil
						.parseDoseSelection(instructionDoseSelection); // 转换一下说明书中的剂量选择
				String instructionDosingFrequency = instructionUse
						.getDosageFrequency(); // BID Q6H 次
				if (instructionDoseSelection
						.matches("单日最大剂量/最大日剂量|单日最大剂量|最大日剂量")) {
					// 判断是否是复方制剂，如果是，转换时需要另处理
					boolean compoundFlag = VerifyUtil
							.isCompoundDrug(chuFangDrug);
					ChuFangCheckRecord dosageCheckRecord = new ChuFangCheckRecord();
					dosageCheckRecord.setChuFangDrug(chuFangDrug);
					dosageCheckRecord.setInstructionUse(instructionUse);
					ChuFangCheckRecord checkResult = null;
					if (compoundFlag) {
						checkResult = compoundDrugOverstepMaxDayDosageLimit(chuFangDrug,instructionUse,instructionDoseSelection,instructionDosingFrequency,
								dosageCheckRecord,dosageCheckRecords);
						
					} else {
						checkResult = nonCompoundDrugOverstepMaxDayDosageLimit(chuFangDrug,drugCombinationName, instructionUse, 
								verifyResult, errMsgBuffer, instructionDoseSelection, 
								instructionDosingFrequency, dosageCheckRecord, dosageCheckRecords);
					}
					if(checkResult.getValid()==false && 
							checkResult.getInvalidDosageType() == VerifyTypeEnums.INVALID_DOSAGE_GT_DAY_LIMIT){
						break;
					}
				}
			}
			if (dosageCheckRecords.size() > 0) {
				ChuFangCheckRecord chuFangCheckRecord = dosageCheckRecords
						.get(0);
				String cfDrugCombinationName = chuFangCheckRecord
						.getChuFangDrug().getDrugCombinationName();
				String cfDosage = chuFangCheckRecord.getChuFangDrug()
						.getDosage();
				String cfDosageUnit = chuFangCheckRecord.getChuFangDrug()
						.getDosageUnit();
				String doseSelection = chuFangCheckRecord.getInstructionUse()
						.getDoseSelection();
				String insDosage = chuFangCheckRecord.getInstructionUse()
						.getDosage();
				String insDosageUnit = chuFangCheckRecord.getInstructionUse()
						.getDosageUnit();
				String errorMsg = String.format(
						"药品 “%s” 剂量为 “%s%s” ，超出【%s】 “%s%s”",
						cfDrugCombinationName, cfDosage, cfDosageUnit,
						doseSelection, insDosage, insDosageUnit);
				errMsgBuffer.append(errorMsg);
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrug, VerifyTypeEnums.INVALID_DOSAGE_GT_DAY_LIMIT,errorMsg);
			} else {
				VerifyUtil.addSuccessDrugToVerifyResult(verifyResult,
						chuFangDrug);
			}
		}
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}
	private ChuFangCheckRecord compoundDrugOverstepMaxDayDosageLimit(Drug chuFangDrug, IndicationTherapeuticRegimen instructionUse, String instructionDoseSelection, 
			String instructionDosingFrequency, ChuFangCheckRecord dosageCheckRecord, List<ChuFangCheckRecord> dosageCheckRecords){
		// 比较单日剂量上限
		DosageCheckResult dosageIsMatchDayLimit = dosageIsMatchDayLimitForCompoundDrug(
				chuFangDrug, instructionUse,
				instructionDoseSelection,
				instructionDosingFrequency);
		if (!dosageIsMatchDayLimit.isValid()) {
			dosageCheckRecord.setValid(false);
			dosageCheckRecord.setInValidText("超出最大日剂量");
			dosageCheckRecord
					.setInvalidDosageType(VerifyTypeEnums.INVALID_DOSAGE_GT_DAY_LIMIT);
			dosageCheckRecords.add(dosageCheckRecord);
			return dosageCheckRecord;
		}
		dosageCheckRecord.setValid(true);
		return dosageCheckRecord;
	}
	private ChuFangCheckRecord nonCompoundDrugOverstepMaxDayDosageLimit(Drug chuFangDrug, DrugCombinationName drugCombinationName,IndicationTherapeuticRegimen instructionUse,
			VerifyResult verifyResult,StringBuffer errMsgBuffer,String instructionDoseSelection, 
			String instructionDosingFrequency, ChuFangCheckRecord dosageCheckRecord, List<ChuFangCheckRecord> dosageCheckRecords){
		// 统一单位
		String[] standardDosageAndUnit = VerifyUtil
				.parseUnitToStandard(chuFangDrug,drugCombinationName, instructionUse,
						errMsgBuffer, verifyResult);
		if (standardDosageAndUnit == null) {
			dosageCheckRecord.setValid(false);
			dosageCheckRecord.setInValidText("统一单位失败");
			dosageCheckRecord
					.setInvalidDosageType(VerifyTypeEnums.INVALID_UNIT);
			return dosageCheckRecord;
		}
		// 比较单日剂量上限
		DosageCheckResult dosageIsMatchDayLimit = dosageIsMatchDayLimit(
				standardDosageAndUnit,
				instructionDoseSelection,
				instructionDosingFrequency);
		if (!dosageIsMatchDayLimit.isValid()) {
			dosageCheckRecord.setValid(false);
			dosageCheckRecord.setInValidText("超出最大日剂量");
			dosageCheckRecord
					.setInvalidDosageType(VerifyTypeEnums.INVALID_DOSAGE_GT_DAY_LIMIT);
			dosageCheckRecords.add(dosageCheckRecord);
			return dosageCheckRecord;
		}else{
			dosageCheckRecord.setValid(true);
			return dosageCheckRecord;
		}
	}
	private DosageCheckResult dosageIsMatchDayLimitForCompoundDrug(
			Drug chuFangDrug, IndicationTherapeuticRegimen instructionUse,
			String instructionDoseSelection, String instructionDosingFrequency) {
		if (StringUtils.isBlank(chuFangDrug.getDosageUnit())
				|| StringUtils.isBlank(instructionUse.getDosageUnit())
				|| !chuFangDrug.getDosageUnit().trim()
						.equals(instructionUse.getDosageUnit().trim())) {
			logger.error(String.format("<%s>处方药品的用量单位<%s>或者说明书药品的用量单位<%s>为空或者不相同", chuFangDrug.getDrugCombinationName(),chuFangDrug.getDosageUnit(),instructionUse.getDosageUnit()));
			return null;
		}
		String chuFangDrugDosageStandard = chuFangDrug.getDosage();
		String instructionDosageStandard = instructionUse.getDosage();
		double doubleCFDosage = DoubleUtil.parseStr2Double(
				chuFangDrugDosageStandard, 3);
		double doubleInstDosage = DoubleUtil.parseStr2Double(
				instructionDosageStandard, 3);
		DosageCheckResult dosageCheckResult = new DosageCheckResult();
		dosageCheckResult.setDoseSelection(instructionDoseSelection);
		if (instructionDoseSelection.matches("单日最大剂量/最大日剂量|单日最大剂量|最大日剂量")) {
			Integer oneDayTime = DosingFrequencyUtil
					.parseDosingFrequency(instructionDosingFrequency);
			if (oneDayTime == null) {
				dosageCheckResult.setValid(true);// 如果转换不了，默认通过
			} else {
				double oneDayTotalDosage = doubleCFDosage * oneDayTime;// 一天的总用量
				if (oneDayTotalDosage <= doubleInstDosage) {
					dosageCheckResult.setValid(true);
				} else {
					dosageCheckResult.setValid(false);
				}
			}
		}
		return dosageCheckResult;

	}

	private DosageCheckResult dosageIsMatchDayLimit(
			String[] standardDosageAndUnit, String instructionDoseSelection,
			String instructionDosingFrequency) {
		String chuFangDrugDosageStandard = standardDosageAndUnit[0];
		String instructionDosageStandard = standardDosageAndUnit[2];
		double doubleCFDosage = DoubleUtil.parseStr2Double(
				chuFangDrugDosageStandard, 3);
		double doubleInstDosage = DoubleUtil.parseStr2Double(
				instructionDosageStandard, 3);
		DosageCheckResult dosageCheckResult = new DosageCheckResult();
		dosageCheckResult.setDoseSelection(instructionDoseSelection);
		if (instructionDoseSelection.matches("单日最大剂量/最大日剂量|单日最大剂量|最大日剂量")) {
			Integer oneDayTime = DosingFrequencyUtil
					.parseDosingFrequency(instructionDosingFrequency);
			if (oneDayTime == null) {
				dosageCheckResult.setValid(true);// 如果转换不了，默认通过
			} else {
				double oneDayTotalDosage = doubleCFDosage * oneDayTime;// 一天的总用量
				if (oneDayTotalDosage <= doubleInstDosage) {
					dosageCheckResult.setValid(true);
				} else {
					dosageCheckResult.setValid(false);
				}
			}
		}
		return dosageCheckResult;
	}

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}
}
