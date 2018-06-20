package org.beiyi.service.verify.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.VerifyUtil;
/**
 * 药品不存在审核
 * @author 2bu
 *
 */
public class DrugNotExistsVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult(true);
		StringBuffer errMsgBuffer = new StringBuffer();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品
		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			Instruction instruction = VerifyUtil
					.getInstructionOfChuFangDrug(chuFangDrug);
			if (instruction == null) {// 药品不存在于说明书
				notExistsDrugs.add(chuFangDrug);
			}else{
				continue;
			}
		}
		for (Drug drug : notExistsDrugs) {
			errMsgBuffer.append(String.format("药品“%s” 不存在；", drug.getDrugCombinationName()));
			VerifyUtil.addErrorDrugToVerifyResult(verifyResult, drug, VerifyTypeEnums.NO_DRUG);
		}
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		return null;
	}

}