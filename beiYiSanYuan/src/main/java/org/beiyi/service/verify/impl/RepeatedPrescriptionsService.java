package org.beiyi.service.verify.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.dao.InstructionsAtcMapper;
import org.beiyi.dao.InstructionsCategoryMapper;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.db.InstructionsAtc;
import org.beiyi.entity.db.InstructionsCategory;
import org.beiyi.entity.verify.ATCCode;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugCategory;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.ATCUtil;
import org.beiyi.util.VerifyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 重复给药审核
 * 
 * @author 2bu
 *
 */
@Service
public class RepeatedPrescriptionsService implements IDrugVeryfy {
	@Autowired
	InstructionsAtcMapper instructionsAtcMapper;
	@Autowired
	InstructionsCategoryMapper InstructionsCategoryMapper;
	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
//		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		List<Drug> chuFangDrugVerifingList = chuFang.getOldDrugs();// 需要遍历处方中的药品，挨个进行审核
		for (int i = 0; i < chuFangDrugVerifingList.size(); i++) {
			Drug chuFangDrugI = chuFangDrugVerifingList.get(i);
//			Instruction instructionI = VerifyUtil.getInstructionOfChuFangDrug(chuFangDrugI);
			
			DrugCombinationName drugCombinationNameI = new DrugCombinationName(chuFangDrugI.getDrugCombinationName());
			InstructionsAtc instructionsAtcI = instructionsAtcMapper.findByInstructionsAtc(new InstructionsAtc(
					drugCombinationNameI.getTongYongName(), drugCombinationNameI.getShangPinName()));
			
			for (int j = i + 1; j < chuFangDrugVerifingList.size(); j++) {
				Drug chuFangDrugJ = chuFangDrugVerifingList.get(j);
				
				DrugCombinationName drugCombinationNameJ = new DrugCombinationName(chuFangDrugJ.getDrugCombinationName());
				InstructionsAtc instructionsAtcJ = instructionsAtcMapper.findByInstructionsAtc(new InstructionsAtc(
						drugCombinationNameJ.getTongYongName(), drugCombinationNameJ.getShangPinName()));
				
//				Instruction instructionJ = VerifyUtil.getInstructionOfChuFangDrug(chuFangDrugJ);
//				if (instructionJ == null) {
//					notExistsDrugs.add(chuFangDrugJ);
//					continue;
//				}
				if(chuFangDrugI.getDrugCombinationName().equals(chuFangDrugJ.getDrugCombinationName())){
					VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrugI, VerifyTypeEnums.REPEATED_PRESCRIPTIONS);
					VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrugJ, VerifyTypeEnums.REPEATED_PRESCRIPTIONS);
					errMsgBuffer.append(String.format(
							"药品“%s”与 药品 “%s” 存在重复用药，原因：药品相同",
							chuFangDrugI
									.getDrugCombinationName(),
									chuFangDrugJ
									.getDrugCombinationName()));
				}else if (instructionsAtcI==null || instructionsAtcJ == null || StringUtils.isBlank(instructionsAtcI.getAtcNo()) 
						|| StringUtils.isBlank(instructionsAtcJ.getAtcNo())) {
					List<InstructionsCategory> chuFangDrugICatagories = InstructionsCategoryMapper.selectByCombinationStandardName(drugCombinationNameI.getCombinationStandardName());
					List<InstructionsCategory> chuFangDrugJCatagories = InstructionsCategoryMapper.selectByCombinationStandardName(drugCombinationNameJ.getCombinationStandardName());
					// 当a与b药其中某个药的atcCode为空时，则直接去yiMaiTongFinalStandard数据库查找医脉通的分类，查看是否属于同一分类。
					String category = isSameCategory(chuFangDrugICatagories,
							chuFangDrugJCatagories);
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
										.getDrugCombinationName(), category));
					}
				} else {
					ATCCode atcCode = getSameAtcCode(instructionsAtcI, instructionsAtcJ);
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
//		if (notExistsDrugs.size() > 0) {
//			for (Drug notExistsDrug : notExistsDrugs) {
//				DrugVerifyInfo notExistsDrugVerifyInfo = new DrugVerifyInfo(
//						notExistsDrug, VerifyTypeEnums.NO_DRUG);
//				verifyResult.getErrorDrugs().add(notExistsDrugVerifyInfo);
//				errMsgBuffer.append(String.format("药品“%s” 不存在。",
//						notExistsDrug.getDrugCombinationName()));
//			}
//		}
		if (verifyResult.getErrorDrugs().size() > 0) {
			verifyResult.setSuccess(false);
			verifyResult.setResultMsg(errMsgBuffer.toString());
		} else {
			verifyResult.setSuccess(true);
		}
		return verifyResult;
	}

	
	private String isSameCategory(List<InstructionsCategory> chuFangDrugICatagories,
			List<InstructionsCategory> chuFangDrugJCatagories) {
		if(chuFangDrugICatagories == null || chuFangDrugJCatagories == null){
			return null;
		}
		for (InstructionsCategory chuFangDrugJCatagory : chuFangDrugJCatagories) {
			for (InstructionsCategory chuFangDrugICatagory : chuFangDrugICatagories) {
				if(chuFangDrugJCatagory.getCategory().equals(chuFangDrugICatagory.getCategory())){
					return chuFangDrugJCatagory.getCategory();
				}
			}
		}
		return null;
	}
	private ATCCode getSameAtcCode(InstructionsAtc instructionsAtcI,
			InstructionsAtc instructionsAtcJ) {
		// 直接判断四级编码是否一致，若不一致，进行atc库的三级编码查询。
		Map<Integer, ATCCode> insIAtcLevelCodeMap = ATCUtil
				.getATCCodeParentsByAtcCode(instructionsAtcI.getAtcNo());
		Map<Integer, ATCCode> insJAtcLevelCodeMap = ATCUtil
				.getATCCodeParentsByAtcCode(instructionsAtcJ.getAtcNo());
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

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}

}
