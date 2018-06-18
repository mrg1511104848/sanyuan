package org.beiyi.service.verify.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.VerifyUtil;

public class SexVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		String sex = chuFang.getHuanZhe().getSex();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			String drugCombinationName = chuFangDrug.getDrugCombinationName();
			
			Instruction instruction = VerifyUtil
					.getInstructionOfChuFangDrug(chuFangDrug);
			if (instruction == null) {// 药品不存在于说明书
				notExistsDrugs.add(chuFangDrug);
				continue;
			}
			
			boolean canUsedForSex = drugCanUsedForSex(drugCombinationName,sex);
			if(!canUsedForSex){
				errMsgBuffer.append(String.format("药品 “%s” 不适用于患者的性别；", drugCombinationName));
				
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult,
						chuFangDrug, VerifyTypeEnums.SEX_INVALID);
				continue;
			}
		}
		VerifyUtil.addNotExistsDrugToVerifyResult(verifyResult, notExistsDrugs,
				errMsgBuffer);
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}
	
	private boolean drugCanUsedForSex(String drugCombinationName, String sex) {
		return false;
	}
	
}
