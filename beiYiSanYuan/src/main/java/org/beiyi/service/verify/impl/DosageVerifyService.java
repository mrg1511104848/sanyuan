package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
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
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.InstructionsReadUtil;
import org.beiyi.util.VerifyUtil;
import org.skynet.frame.util.DoubleUtil;
import org.skynet.frame.util.StringBufferUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 剂量审核第二版
 * 
 * @author 2bu
 *
 */
@Service
public class DosageVerifyService implements IDrugVeryfy {
	private Logger log = Logger.getLogger(DosageVerifyService.class);
	@Autowired
	IndicationTherapeuticRegimenMapper indicationTherapeuticRegimenMapper;
	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
//		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行计量审核
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			/*String chuFangDrugCombinationName = chuFangDrug
					.getDrugCombinationName(); // 药品名称
			String chuFangDrugDosage = chuFangDrug.getDosage(); // 用量
			String chuFangDrugDosageUnit = chuFangDrug.getDosageUnit(); // 用量单位
			String chuFangDrugDosingFrequency = chuFangDrug
					.getDosingFrequency(); // 用药频率*/
			if (checkChuFangElementsIsBlank(chuFangDrug)) {
				continue;
			}
			// 获取整理好的说明书的药品
//			Instruction instructionDrug = InstructionsReadUtil.get(chuFangDrug.getDrugCombinationName());
//			if (instructionDrug == null) {
//				notExistsDrugs.add(chuFangDrug);
//				continue;
//			}
			boolean containsInVerifyResultErrorDrugs = VerifyUtil.chuFangDrugContainsInVerifyResultErrorDrugs(verifyResult, chuFangDrug);
			if(containsInVerifyResultErrorDrugs){ continue;}
			// 用来存放剂量审核的记录，最后进行最终剂量评判的标准
			List<ChuFangCheckRecord> dosageCheckRecords = new ArrayList<ChuFangCheckRecord>();
			/*List<InstructionUse> instructionUses = instructionDrug.getInstructionUses();
			// 遍历 整理好的说明书 - 药品使用相关信息
			for (InstructionUse instructionUse : instructionUses) {*/
			List<String> diagnosises = chuFang.getDiagnosises();
			IndicationTherapeuticRegimenCondition condition = new IndicationTherapeuticRegimenCondition();
			DrugCombinationName drugCombinationName = new DrugCombinationName(chuFangDrug.getDrugCombinationName());
			condition.setCommodityName(drugCombinationName.getShangPinName());
			condition.setCommonName(drugCombinationName.getTongYongName());
			condition.setIndications(diagnosises);
			
			List<IndicationTherapeuticRegimen> results = indicationTherapeuticRegimenMapper.selectByCondition(condition);
			for (IndicationTherapeuticRegimen instructionUse : results) {
				String instructionPatientStatusText = instructionUse.getPatientStatus();// 患者状态
				String instructionDoseSelection = instructionUse.getDoseSelection();// 剂量选择
//				String instructionDosage = instructionUse.getDosage();// 1 or 1；2
//				String instructionDosageUnit = instructionUse.getDosageUnit(); // 粒 片 次/日
				instructionDoseSelection = VerifyUtil.parseDoseSelection(instructionDoseSelection); //转换一下说明书中的剂量选择
//				String instructionDosingFrequency = instructionUse.getDosingFrequency(); // BID Q6H 次
				if (checkInstructionElementsIsBlank(instructionUse.getCommodityName()+"("+instructionUse.getCommonName()+")",instructionUse)) {
					continue;
				}
				// 0.筛选人群
				boolean crowdValid = VerifyUtil.crowdIsValid(chuFang,instructionPatientStatusText);
				if (!crowdValid) {// 不属于该人群的话，continue;
					continue;
				}
				ChuFangCheckRecord dosageCheckRecord = new ChuFangCheckRecord();
				dosageCheckRecord.setChuFangDrug(chuFangDrug);
				dosageCheckRecord.setInstructionUse(instructionUse);
				dosageCheckRecords.add(dosageCheckRecord);
				
				// 判断是否是复方制剂，如果是，转换时需要另处理
				boolean compoundFlag = VerifyUtil
						.isCompoundDrug(chuFangDrug);
				//根据剂量选择比较剂量
				DosageCheckResult dosageIsValid = null;
				if(compoundFlag){//复方制剂，直接用包装单位
					dosageIsValid = compoundDosageIsValid(chuFangDrug,instructionUse,instructionDoseSelection);
				}else{
					// 2.比较每次用量
					//统一单位
					String[] standardDosageAndUnit = VerifyUtil.parseUnitToStandard(chuFangDrug,drugCombinationName,instructionUse,errMsgBuffer,verifyResult);
					if(standardDosageAndUnit == null){
						dosageCheckRecord.setInValidText("统一单位失败");
						dosageCheckRecord.setInvalidDosageType(VerifyTypeEnums.INVALID_UNIT);
						continue;
					}
					//根据剂量选择比较剂量
					dosageIsValid = nonCompoundDosageIsValid(standardDosageAndUnit,instructionDoseSelection);
				}
				if(!dosageIsValid.isValid()){
					dosageCheckRecord.setInValidText("剂量不适宜");
					dosageCheckRecord.setInvalidDosageType(VerifyTypeEnums.INVALID_DOSAGE);
					continue;
				}
				dosageCheckRecord.setValid(true);
			}
			List<ChuFangCheckRecord> dosageErrors = getErrorCheckRecords(dosageCheckRecords);
			if(dosageErrors.size()>0){
				String errorMsg = appendDosageErrors(chuFangDrug,dosageErrors);
				errMsgBuffer.append(errorMsg);
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrug, VerifyTypeEnums.INVALID_DOSAGE);
			}else{
				VerifyUtil.addSuccessDrugToVerifyResult(verifyResult, chuFangDrug);
			}
		}
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}
	private DosageCheckResult compoundDosageIsValid(Drug chuFangDrug,
			IndicationTherapeuticRegimen instructionUse, String instructionDoseSelection) {
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
		return dosageIsValid(doubleCFDosage, doubleInstDosage, instructionDoseSelection);
	}
	private String appendDosageErrors(Drug chuFangDrug,
			List<ChuFangCheckRecord> dosageErrors) {
		StringBuffer resultMsg = new StringBuffer(String.format("药品 “%s” 用量 “%s%s” 应在",
				chuFangDrug.getDrugCombinationName(),chuFangDrug.getDosage(),chuFangDrug.getDosageUnit()));
		resultMsg.append("（");
		Set<String> dosageAndUnitSets = new HashSet<String>();
		for (ChuFangCheckRecord chuFangErrRecord : dosageErrors) {
			String cfDosage = chuFangErrRecord.getInstructionUse().getDosage();
			String[] cfDosageArr = cfDosage.split(";|；");
			for (String cfDsg : cfDosageArr) {
				String cfDosageUnit = chuFangErrRecord.getInstructionUse().getDosageUnit();
//				resultMsg.append(String.format("%s%s,", cfDsg,cfDosageUnit));
				dosageAndUnitSets.add(String.format("%s%s", cfDsg,cfDosageUnit));
			}
		}
		for (String dosageAndUnit : dosageAndUnitSets) {
			resultMsg.append(String.format("%s,", dosageAndUnit));
		}
		resultMsg = StringBufferUtil.removeEnd(resultMsg, ",");
		resultMsg.append("）范围内");
		return resultMsg.toString();
	}
	private List<ChuFangCheckRecord> getErrorCheckRecords(
			List<ChuFangCheckRecord> dosageCheckRecords) {
		/*if(dosageCheckRecords== null || dosageCheckRecords.size() == 0){
			throw new RuntimeException("The dosageCheckRecords is blank!");
		}*/
		List<ChuFangCheckRecord> errorResults = new ArrayList<ChuFangCheckRecord>();
		
		for (ChuFangCheckRecord dosageCheckRecord : dosageCheckRecords) {
			if(!dosageCheckRecord.getValid()){
				if(dosageCheckRecord.getInvalidDosageType() != VerifyTypeEnums.INVALID_DOSAGE_GT_DAY_LIMIT)
					errorResults.add(dosageCheckRecord);
			}
		}
		return errorResults;
	}
	/**
	 * 根据剂量选择判断处方和说明书的剂量是否适宜
	 * @param standardDosageAndUnit
	 * @param instructionDoseSelection
	 * @param instructionDosingFrequency 
	 * @return
	 */
	private DosageCheckResult dosageIsValid(double doubleCFDosage,double[] doubleInstDosage, String instructionDoseSelection) {
		DosageCheckResult dosageCheckResult = new DosageCheckResult();
		dosageCheckResult.setDoseSelection(instructionDoseSelection);
		if(instructionDoseSelection.matches("常规剂量|起始剂量|负荷剂量|维持剂量|剂量调整")){
			if(doubleCFDosage >= doubleInstDosage[0] && doubleCFDosage <= doubleInstDosage[1]){
				dosageCheckResult.setValid(true);
			}else{
				dosageCheckResult.setValid(false);
			}
		}else if(instructionDoseSelection.matches("单次剂量上限")){
			if(doubleCFDosage >= doubleInstDosage[0] && doubleCFDosage <= doubleInstDosage[1]){
				dosageCheckResult.setValid(true);
			}else{
				dosageCheckResult.setValid(false);
			}
		}else if(instructionDoseSelection.matches("单次剂量下限")){
			if(doubleCFDosage >= doubleInstDosage[0] && doubleCFDosage <= doubleInstDosage[1]){
				dosageCheckResult.setValid(true);
			}else{
				dosageCheckResult.setValid(false);
			}
		}
		return dosageCheckResult;
	}
	/**
	 * 根据剂量选择判断处方和说明书的剂量是否适宜
	 * @param standardDosageAndUnit
	 * @param instructionDoseSelection
	 * @param instructionDosingFrequency 
	 * @return
	 */
	private DosageCheckResult dosageIsValid(double doubleCFDosage,double doubleInstDosage, String instructionDoseSelection) {
		DosageCheckResult dosageCheckResult = new DosageCheckResult();
		dosageCheckResult.setDoseSelection(instructionDoseSelection);
		if(instructionDoseSelection.matches("常规剂量|起始剂量|负荷剂量|维持剂量|剂量调整")){
			if(doubleCFDosage == doubleInstDosage){
				dosageCheckResult.setValid(true);
			}else{
				dosageCheckResult.setValid(false);
			}
		}else if(instructionDoseSelection.matches("单次剂量上限")){
			if(doubleCFDosage <= doubleInstDosage){
				dosageCheckResult.setValid(true);
			}else{
				dosageCheckResult.setValid(false);
			}
		}else if(instructionDoseSelection.matches("单次剂量下限")){
			if(doubleCFDosage >= doubleInstDosage){
				dosageCheckResult.setValid(true);
			}else{
				dosageCheckResult.setValid(false);
			}
		}
		return dosageCheckResult;
	}
	
	
	/**
	 * 非复方制剂 - 根据剂量选择判断处方和说明书的剂量是否适宜 
	 * @param standardDosageAndUnit
	 * @param instructionDoseSelection
	 * @param instructionDosingFrequency 
	 * @return
	 */
	private DosageCheckResult nonCompoundDosageIsValid(String[] standardDosageAndUnit, String instructionDoseSelection) {
		
		String chuFangDrugDosageStandard = standardDosageAndUnit[0];
		String instructionDosageStandard = standardDosageAndUnit[2];
		boolean isRangeDosage = VerifyUtil.isRange(instructionDosageStandard);
		double doubleCFDosage = DoubleUtil.parseStr2Double(chuFangDrugDosageStandard,3);
		
		if(isRangeDosage){
			String[] rangeArr = VerifyUtil.getRange(instructionDosageStandard);
			String rangeStart = rangeArr[0];
			String rangeEnd = rangeArr[1];
			double doubleInstDosageStart = DoubleUtil.parseStr2Double(rangeStart,3);
			double doubleInstDosageEnd = DoubleUtil.parseStr2Double(rangeEnd,3);
			double[] doubleInstDosageArr = {doubleInstDosageStart,doubleInstDosageEnd};
			return dosageIsValid(doubleCFDosage, doubleInstDosageArr, instructionDoseSelection);
		}
		
		double doubleInstDosage = DoubleUtil.parseStr2Double(instructionDosageStandard,3);
		return dosageIsValid(doubleCFDosage, doubleInstDosage, instructionDoseSelection);
		
	}
	
	static class DosageCheckResult{
		private boolean valid;
		private String doseSelection;
		public boolean isValid() {
			return valid;
		}
		public void setValid(boolean valid) {
			this.valid = valid;
		}
		public String getDoseSelection() {
			return doseSelection;
		}
		public void setDoseSelection(String doseSelection) {
			this.doseSelection = doseSelection;
		}
	}
	
	
	
	
	
	
	
	
	
	private boolean checkInstructionElementsIsBlank(String drugCombinationName,
			IndicationTherapeuticRegimen instructionUse) {
		String instructionDosage = instructionUse.getDosage();// 1 or 1；2
		String instructionDosageUnit = instructionUse.getDosageUnit(); // 粒 片 次/日
		String instructionDosingFrequency = instructionUse.getDosageFrequency(); // BID Q6H 次
		String[] instructionBlankElement = getBlankElement(
				new String[] {
						instructionDosageUnit,
						" [整理好的说明书] "
								+ drugCombinationName
								+ " “每次用量单位”为空!" },
				new String[] {
						instructionDosage,
						" [整理好的说明书] "
								+ drugCombinationName
								+ " “每次用量”为空!" },
				new String[] {
						instructionDosingFrequency,
						" [整理好的说明书] "
								+ drugCombinationName
								+ " “用药频率”为空!" });
		if (instructionBlankElement != null) {
			return true;
		}
		return false;
	}
	
	private boolean checkChuFangElementsIsBlank(Drug chuFangDrug) {
		String chuFangDrugCombinationName = chuFangDrug
				.getDrugCombinationName(); // 药品名称
		String chuFangDrugDosageUnit = chuFangDrug.getDosageUnit(); // 用量单位
		String chuFangDrugDosage = chuFangDrug.getDosage(); // 用量
		String chuFangDrugDosingFrequency = chuFangDrug.getDosingFrequency(); // 用药频率
		String[] blankElement = getBlankElement(new String[] {
				chuFangDrugDosageUnit,
				" [处方] " + chuFangDrugCombinationName + " “每次用量单位”为空!" },
				new String[] { chuFangDrugDosage,
						" [处方] " + chuFangDrugCombinationName + " “每次用量”为空!" },
				new String[] { chuFangDrugDosingFrequency,
						" [处方] " + chuFangDrugCombinationName + " “用药频率”为空!" });
		if (blankElement != null) {
			return true;
		}
		return false;
	}

	/**
	 * 获取为空的元素，此方法用于校验blank的元素，ps : 校验每次用量是否为空，如果为空，记录日志并返回为空的元素...
	 * 
	 * @param blankChecks
	 *            [0] 元素值 [1] 元素为空时的说明
	 * @return 返回为空的元素和元素为空时的说明
	 */
	private String[] getBlankElement(String[]... blankChecks) {
		for (String[] check : blankChecks) {
			String key = check[0];
			if (StringUtils.isBlank(key)) {
				log.error(check[1]);
				return check;
			}
		}
		return null;
	}
	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}
}
