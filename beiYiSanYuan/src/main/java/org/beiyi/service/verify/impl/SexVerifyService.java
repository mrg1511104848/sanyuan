package org.beiyi.service.verify.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.dao.InstructionsCrowdMapper;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.db.InstructionsCrowd;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.VerifyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
/**
 * 性别审核
 * @author 2bu
 *
 */
@Service
public class SexVerifyService implements IDrugVeryfy {
	@Autowired
	InstructionsCrowdMapper instructionsCrowdMapper;
	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
//		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		String sex = chuFang.getHuanZhe().getSex();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			String drugCombinationName = chuFangDrug.getDrugCombinationName();
			
//			Instruction instruction = VerifyUtil
//					.getInstructionOfChuFangDrug(chuFangDrug);
//			if (instruction == null) {// 药品不存在于说明书
//				notExistsDrugs.add(chuFangDrug);
//				continue;
//			}
			boolean containsInVerifyResultErrorDrug = VerifyUtil.chuFangDrugContainsInVerifyResultErrorDrugs(verifyResult, chuFangDrug);
			if(containsInVerifyResultErrorDrug){
				continue;
			}
			
			Boolean canUsedForSex = drugCanUsedForSex(drugCombinationName,sex);
			if(canUsedForSex == null){
				errMsgBuffer.append(String.format("药品 “%s” 性别未审核，处方中该药品性别为空；", drugCombinationName));
				
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult,
						chuFangDrug, VerifyTypeEnums.SEX_INVALID);
				continue;
			}
			if(!canUsedForSex){
				errMsgBuffer.append(String.format("药品 “%s” 不适用于患者的性别；", drugCombinationName));
				
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult,
						chuFangDrug, VerifyTypeEnums.SEX_INVALID);
				continue;
			}
		}
//		VerifyUtil.addNotExistsDrugToVerifyResult(verifyResult, notExistsDrugs,
//				errMsgBuffer);
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}
	
	private Boolean drugCanUsedForSex(String drugCombinationName, String sex) {
		if(StringUtils.isBlank(sex)){
			return null;
		}
		sex = sex.trim();
		int sexConvert = -1;
		if(sex.equals("男")){
			sexConvert = 1;
		}else if(sex.equals("女")){
			sexConvert = 2;
		}
		DrugCombinationName combinationName = new DrugCombinationName(drugCombinationName);
		InstructionsCrowd condition = new InstructionsCrowd();
		condition.setSexLimitLimit(sexConvert);
		condition.setCommodityName(combinationName.getShangPinName());
		condition.setCommonName(combinationName.getTongYongName());
		InstructionsCrowd instructionsCrowd = instructionsCrowdMapper.findByCondition(condition);
		if(instructionsCrowd != null && instructionsCrowd.getForbiddenFlag() != null && instructionsCrowd.getForbiddenFlag() == 1 ){
			return false;
		}
		return true;
	}

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
