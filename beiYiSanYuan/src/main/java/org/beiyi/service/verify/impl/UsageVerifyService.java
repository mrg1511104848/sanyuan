package org.beiyi.service.verify.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.InstructionsReadUtil;
import org.skynet.frame.util.excel.ExcelUtil;

/**
 * 用法审核
 * @author mrg
 *
 */
public class UsageVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行用法审核
		Set<String> suggestUseageSet = new HashSet<String>(); //建议的药品用法，从说明书中提取。
		
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			boolean chuFangDrugRouteOfMedicationIsValid = false;
			
			String chuFangRouteOfMedication = chuFangDrug.getRouteOfMedication();
			if(StringUtils.isBlank(chuFangRouteOfMedication)){
				String errorMsg = String.format(" %s 药品 ", chuFangDrug.getDrugCombinationName());
				errMsgBuffer.append(String.format("%s【药品】 %s 用法不适宜，具体原因为 ： %s",ExcelUtil.NEW_LINE, chuFangDrug.getDrugCombinationName(),errorMsg));
				
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug,VerifyTypeEnums.INVALID_USAGE);
				verifyResult.getErrorDrugs().add(drugVerifyInfo);
				
				continue;
			}else{
				chuFangRouteOfMedication = chuFangRouteOfMedication.trim();
				chuFangDrug.setRouteOfMedication(chuFangRouteOfMedication);
			}
			// 获取整理好的说明书的药品
			Instruction instruction = InstructionsReadUtil.get(chuFangDrug.getDrugCombinationName());
			if(instruction == null){
				String errorMsg = String.format(" %s 在说明书中不存在！", chuFangDrug.getDrugCombinationName());
				errMsgBuffer.append(String.format("%s【药品】 %s 用法不适宜，具体原因为 ： %s",ExcelUtil.NEW_LINE, chuFangDrug.getDrugCombinationName(),errorMsg));
				
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug,VerifyTypeEnums.NO_DRUG);
				verifyResult.getErrorDrugs().add(drugVerifyInfo);
				
				continue;
			}
			
			List<InstructionUse> instructionUses = instruction.getInstructionUses();
			
			//遍历  整理好的说明书 - 药品使用相关信息
			for (InstructionUse instructionUse : instructionUses) {
				String instructionRouteOfMedication = instructionUse.getRouteOfMedication();
				if(org.apache.commons.lang3.StringUtils.isBlank(instructionRouteOfMedication)){ //说明书中如果用法是空，直接略过
					continue;
				}
				instructionRouteOfMedication = instructionRouteOfMedication.trim();
				if(instructionRouteOfMedication.equals(chuFangRouteOfMedication.trim())){//相等表示可以用，药品通过此项审核
					chuFangDrugRouteOfMedicationIsValid = true;
				}else{
					//加入到建议的药品用法。
					suggestUseageSet.add(instructionRouteOfMedication);
				}
			}
			if(!chuFangDrugRouteOfMedicationIsValid){
				String errorMsg = String.format(" 用法不适宜 处方中用法 “%s” ，推荐用法“%s”！", chuFangRouteOfMedication,suggestUseageSet);
				errMsgBuffer.append(String.format("%s【药品】 %s 用法不适宜，具体原因为 ： %s",ExcelUtil.NEW_LINE, chuFangDrug.getDrugCombinationName(),errorMsg));
				
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug,VerifyTypeEnums.INVALID_USAGE);
				verifyResult.getErrorDrugs().add(drugVerifyInfo);
			}else{
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug,VerifyTypeEnums.SUCCESS);
				verifyResult.getSuccessDrugs().add(drugVerifyInfo);
			}
		}
		
		if(verifyResult.getErrorDrugs().size() > 0){
			verifyResult.setSuccess(false);
			verifyResult.setResultMsg(errMsgBuffer.toString());
		}else{
			verifyResult.setSuccess(true);
		}
		return verifyResult;
	}
	
}
