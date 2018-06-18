package org.beiyi.util;

import java.util.List;
import java.util.Set;

import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;

public class VerifyUtil {
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
	
	
}
