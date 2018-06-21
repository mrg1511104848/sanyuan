package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.reource.Resources;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.InstructionsReadUtil;
import org.beiyi.util.VerifyUtil;
import org.skynet.frame.util.StringBufferUtil;

/**
 * 用药频率审核
 * @author 2bu
 *
 */
public class DDDSVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
//		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行计量审核
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			if(chuFangDrug.getDrugCombinationName().contains("布洛芬缓释胶囊")){
				System.out.println();
			}
			// 获取整理好的说明书的药品
			Instruction instructionDrug = InstructionsReadUtil.get(chuFangDrug.getDrugCombinationName());
//			if (instructionDrug == null) {
//				notExistsDrugs.add(chuFangDrug);
//				continue;
//			}
			String chuFangDrugDosingFrequency = chuFangDrug.getDosingFrequency(); // 用药频率
			List<InstructionUse> instructionUses = instructionDrug.getInstructionUses();
			// 用来存放剂量审核的记录，最后进行最终剂量评判的标准
			List<ChuFangCheckRecord> dosageCheckRecords = new ArrayList<ChuFangCheckRecord>();
			// 遍历 整理好的说明书 - 药品使用相关信息
			for (InstructionUse instructionUse : instructionUses) {
				String instructionPatientStatusText = instructionUse.getPatientStatus();// 患者状态
				
				boolean containsInVerifyResultErrorDrugs = VerifyUtil.chuFangDrugContainsInVerifyResultErrorDrugs(verifyResult, chuFangDrug);
				if(containsInVerifyResultErrorDrugs){ continue;}
				
				String instructionDosingFrequency = instructionUse.getDosingFrequency(); // BID Q6H 次
				// 0.筛选人群
				boolean crowdValid = VerifyUtil.crowdIsValid(chuFang,instructionPatientStatusText);
				if (!crowdValid) {// 不属于该人群的话，continue;
					continue;
				}
				ChuFangCheckRecord dosageCheckRecord = new ChuFangCheckRecord();
				dosageCheckRecord.setChuFangDrug(chuFangDrug);
				dosageCheckRecord.setInstructionUse(instructionUse);
				dosageCheckRecords.add(dosageCheckRecord);
				//比较用药频率
				boolean frequencyIsValid = compareFrequency(chuFangDrugDosingFrequency, instructionDosingFrequency);
				if(!frequencyIsValid){
					dosageCheckRecord.setInValidText("用药频率不适宜");
					dosageCheckRecord.setInvalidDosageType(VerifyTypeEnums.INVALID_DOSING_FREQUENCY);
					continue;
				}else{
					dosageCheckRecord.setValid(true);
				}
			}
			List<ChuFangCheckRecord> dddsErrors = getErrorCheckRecords(dosageCheckRecords);
			if(dddsErrors!=null&&dddsErrors.size()>0){
				String errorMsg = appendDDDSErrors(chuFangDrug,dddsErrors);
				errMsgBuffer.append(errorMsg);
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrug, VerifyTypeEnums.INVALID_DOSING_FREQUENCY);
			}else{
				VerifyUtil.addSuccessDrugToVerifyResult(verifyResult, chuFangDrug);
			}
		}
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}
	private String appendDDDSErrors(Drug chuFangDrug, List<ChuFangCheckRecord> dddsErrors) {
		StringBuffer resultMsg = new StringBuffer(String.format("药品 “%s” 用药频率 “%s” 应在",
				chuFangDrug.getDrugCombinationName(),chuFangDrug.getDosingFrequency().trim()));
		resultMsg.append("（");
		Set<String> dddsSets = new HashSet<String>();
		for (ChuFangCheckRecord chuFangErrRecord : dddsErrors) {
			String dosingFrequency = chuFangErrRecord.getInstructionUse().getDosingFrequency();
//			resultMsg.append(dosingFrequency+",");
			if(StringUtils.isNotBlank(dosingFrequency))
				dddsSets.add(dosingFrequency.trim());
		}
		for (String ddds : dddsSets) {
			resultMsg.append(ddds+",");
		}
		resultMsg = StringBufferUtil.removeEnd(resultMsg, ",");
		resultMsg.append("）范围内");
		return resultMsg.toString();
	}
	private List<ChuFangCheckRecord> getErrorCheckRecords(
			List<ChuFangCheckRecord> dosageCheckRecords) {
		if(dosageCheckRecords== null || dosageCheckRecords.size() == 0){
//			throw new RuntimeException("The dosageCheckRecords is blank!");
			return null;
		}
		List<ChuFangCheckRecord> errorResults = new ArrayList<ChuFangCheckRecord>();
		for (ChuFangCheckRecord dosageCheckRecord : dosageCheckRecords) {
			if(dosageCheckRecord.getValid()){
				return new ArrayList<ChuFangCheckRecord>(0);
			}
		}
		
		for (ChuFangCheckRecord dosageCheckRecord : dosageCheckRecords) {
			if(!dosageCheckRecord.getValid()){
				errorResults.add(dosageCheckRecord);
			}
		}
		return errorResults;
	}
	/**
	 * 比较用药频率
	 * 
	 * @param dosingFrequency
	 * @param instructionDosingFrequency
	 * @return
	 */
	private boolean compareFrequency(String chuFangDrugDosingFrequency,String instructionDosingFrequency) {
		chuFangDrugDosingFrequency = chuFangDrugDosingFrequency.trim();
		instructionDosingFrequency = instructionDosingFrequency.trim();
		if (chuFangDrugDosingFrequency.equalsIgnoreCase(instructionDosingFrequency)) {
			return true;
		}
		return dddsEq(chuFangDrugDosingFrequency, instructionDosingFrequency);
	}
	/**
	 * 比较ddds是否相等
	 * @param sourceDosingFrequency
	 * @param targetDosingFrequency
	 * @return
	 */
	private boolean dddsEq(String sourceDosingFrequency,String targetDosingFrequency){
		for (List<String> dddsList :  Resources.dddsList) {
			if(dddsList.contains(sourceDosingFrequency) && dddsList.contains(targetDosingFrequency) ){
				return true;
			}
		}
		return false;
	}
	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}
}
