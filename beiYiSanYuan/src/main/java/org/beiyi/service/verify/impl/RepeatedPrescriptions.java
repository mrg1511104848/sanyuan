package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ATCCode;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugCategory;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.ATCUtil;
import org.beiyi.util.InstructionsReadUtil;

/**
 * 重复给药审核
 * 
 * @author 2bu
 *
 */
public class RepeatedPrescriptions implements IDrugVeryfy {
	public static void main(String[] args) {
	}

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行用法审核
		for (int i = 0; i < chuFangDrugVerifingList.size(); i++) {
			Drug chuFangDrugI = chuFangDrugVerifingList.get(i);
			Instruction instructionI = getInstructionOfChuFangDrug(chuFangDrugI);
			if (instructionI == null) {
				notExistsDrugs.add(chuFangDrugI);
				continue;
			}
			for (int j = i + 1; j < chuFangDrugVerifingList.size(); j++) {
				Drug chuFangDrugJ = chuFangDrugVerifingList.get(j);
				Instruction instructionJ = getInstructionOfChuFangDrug(chuFangDrugJ);
				if (instructionJ == null) {
					notExistsDrugs.add(chuFangDrugJ);
					continue;
				}
				if (instructionI.getAtcCode() == null
						|| (instructionI.getAtcCode() != null && StringUtils
								.isBlank(instructionI.getAtcCode().getAtcNo()))
						|| instructionJ.getAtcCode() == null
						|| (instructionJ.getAtcCode() != null && StringUtils
						.isBlank(instructionJ.getAtcCode().getAtcNo()))) {
					// 当a与b药其中某个药的atcCode为空时，则直接去yiMaiTongFinalStandard数据库查找医脉通的分类，查看是否属于同一分类。
					DrugCategory category = getSameCategory(instructionI,
							instructionJ);
					if (category != null) {
						// 属于同一分类，
						DrugVerifyInfo drugVerifyInfoI = new DrugVerifyInfo(
								chuFangDrugI,
								VerifyTypeEnums.REPEATED_PRESCRIPTIONS);
						DrugVerifyInfo drugVerifyInfoJ = new DrugVerifyInfo(
								chuFangDrugJ,
								VerifyTypeEnums.REPEATED_PRESCRIPTIONS);
						verifyResult.getErrorDrugs().add(drugVerifyInfoI);
						verifyResult.getErrorDrugs().add(drugVerifyInfoJ);
						errMsgBuffer.append(String.format(
								"药品“%s”与 药品 “%s” 存在重复用药，原因：他们存在同一类别“%s”下",
								drugVerifyInfoI.getDrug()
										.getDrugCombinationName(),
								drugVerifyInfoJ.getDrug()
										.getDrugCombinationName(), category
										.getCategoryName()));
					}
				} else {
					ATCCode atcCode = getSameAtcCode(instructionI, instructionJ);
					if (atcCode != null) {
						// 属于同一分类，
						DrugVerifyInfo drugVerifyInfoI = new DrugVerifyInfo(
								chuFangDrugI,
								VerifyTypeEnums.REPEATED_PRESCRIPTIONS);
						DrugVerifyInfo drugVerifyInfoJ = new DrugVerifyInfo(
								chuFangDrugJ,
								VerifyTypeEnums.REPEATED_PRESCRIPTIONS);

						verifyResult.getErrorDrugs().add(drugVerifyInfoI);
						verifyResult.getErrorDrugs().add(drugVerifyInfoJ);
						errMsgBuffer.append(String.format(
								"药品“%s”与 药品 “%s” 存在重复用药，原因：他们存在同一ATC编码“%s”下",
								drugVerifyInfoI.getDrug()
										.getDrugCombinationName(),
								drugVerifyInfoJ.getDrug()
										.getDrugCombinationName(), atcCode
										.getAtcNo()));
					}
				}
			}
		}
		if (notExistsDrugs.size() > 0) {
			for (Drug notExistsDrug : notExistsDrugs) {
				DrugVerifyInfo notExistsDrugVerifyInfo = new DrugVerifyInfo(
						notExistsDrug, VerifyTypeEnums.NO_DRUG);
				verifyResult.getErrorDrugs().add(notExistsDrugVerifyInfo);
				errMsgBuffer.append(String.format("药品“%s” 不存在。",
						notExistsDrug.getDrugCombinationName()));
			}
		}
		if (verifyResult.getErrorDrugs().size() > 0) {
			verifyResult.setSuccess(false);
			verifyResult.setResultMsg(errMsgBuffer.toString());
		} else {
			verifyResult.setSuccess(true);
		}
		return verifyResult;
	}

	private DrugCategory getSameCategory(Instruction instructionI,
			Instruction instructionJ) {
		if (instructionI.getCategory() != null && instructionJ != null) {
			if (instructionI.getCategory().equals(instructionJ.getCategory())) {
				return instructionI.getCategory();
			}
		}
		return null;
	}

	private ATCCode getSameAtcCode(Instruction instructionI,
			Instruction instructionJ) {
		// 直接判断四级编码是否一致，若不一致，进行atc库的三级编码查询。
		Map<Integer, ATCCode> insIAtcLevelCodeMap = ATCUtil
				.getATCCodeParentsByAtcCode(instructionI.getAtcCode());
		Map<Integer, ATCCode> insJAtcLevelCodeMap = ATCUtil
				.getATCCodeParentsByAtcCode(instructionJ.getAtcCode());
		if (insIAtcLevelCodeMap == null || insJAtcLevelCodeMap == null) {
			return null;
		}
		for (int level = 4; level >= 3; level--) {
			if (insIAtcLevelCodeMap.get(level).equals(
					insJAtcLevelCodeMap.get(level))) {
				return insIAtcLevelCodeMap.get(level);
			}
		}
		return null;
	}

	private Instruction getInstructionOfChuFangDrug(Drug chuFangDrug) {
		// 获取整理好的说明书的药品
		Instruction instruction = InstructionsReadUtil.get(chuFangDrug
				.getDrugCombinationName());
		return instruction;
	}
}
