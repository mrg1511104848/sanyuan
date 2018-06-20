package org.beiyi.service.verify.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.beiyi.changliang.DrugInfoEnum;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.InstructionsReadUtil;
import org.skynet.frame.util.RegexUtils;

/**
 * 适应症相关业务类
 * 
 * @author 2bu
 *
 */
public class ShiYingZhengVerifyService implements IDrugVeryfy{
	private static Logger logger = Logger.getLogger(ShiYingZhengVerifyService.class);
	
	/**
	 * 判定药品对应的适应症是否合理
	 * @param combinationName 组合名称      商品名(通用名)
	 * @param srcShiYingZheng 适应症
	 * @return
	 */
	public static Boolean match( DrugCombinationName combinationName,String srcShiYingZheng) {
		if(combinationName == null || srcShiYingZheng == null) {
			return false;
		}
		srcShiYingZheng = srcShiYingZheng.trim();
		if(!InstructionsReadUtil.contains(combinationName.getCombinationStandardName())){
			return false;
		}
		Instruction instruction = InstructionsReadUtil.get(combinationName.getCombinationStandardName());
		List<String> shiYingZheng = instruction.getDiagnosises();
		if (shiYingZheng == null || shiYingZheng.size() == 0) {
			return false;
		}
		boolean matchResult = shiYingZheng.contains(srcShiYingZheng);
		if (matchResult){
			return matchResult;
		}
		for (String syzRegex : DrugInfoEnum.shiYingZhengRegex) {
			List<String> syzGroupResult = RegexUtils.getByGroup(syzRegex,srcShiYingZheng, 1);
			if (syzGroupResult != null && syzGroupResult.size() > 0) {
				matchResult = shiYingZheng.contains(syzGroupResult.get(0).trim());
				if (matchResult){
					return matchResult;
				}
			}
		}
		return matchResult;
	}
	
	public static void main(String[] args) {
//		Boolean result = match("", "布洛芬缓释胶囊(芬必得)", "偏头痛");
//		System.out.println(result);
	}
	@Override
	public VerifyResult verify(ChuFang chuFang,VerifyResult lastStepVerifyResult) {
		List<Drug> drugs = chuFang.getDrugs();
		List<String> shiYingZhengs = chuFang.getDiagnosises();
		int chuFangDrugInBaseDBCount = 0;
		boolean chuFangIsValid = true;
		VerifyResult verifyResult = new VerifyResult(true);
		StringBuilder errorSb = new StringBuilder();
		for (Drug drug : drugs) {
			String drugCombinationName = drug.getDrugCombinationName();
//			if(!InstructionsReadUtil.contains(drugCombinationName)){
//				errorSb.append("说明书不包含此药品> "+drugCombinationName+"，");
//				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(drug,VerifyTypeEnums.NO_DRUG);
//				verifyResult.getErrorDrugs().add(drugVerifyInfo);
//				continue;
//			}
			chuFangDrugInBaseDBCount++;
			//判断这个药在所有的适应症中是否有能治疗的适应症(是否能够匹配)
			boolean drugMatchShiYingZheng = false;
			for (String syz : shiYingZhengs) {
				Boolean matchResult = ShiYingZhengVerifyService.match(new DrugCombinationName(drugCombinationName), syz);
				if (matchResult == true) {
					drugMatchShiYingZheng = true;
					break;
				}
			}
			//药品不匹配某些适应症
			if (!drugMatchShiYingZheng) {
				chuFangIsValid = false;
				errorSb.append(String.format("药品不包含此适应症 > [药品名] %s [适应症列表] %s ，", drugCombinationName,shiYingZhengs));
				
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(drug,VerifyTypeEnums.INVALID_INDICATION);
				verifyResult.getErrorDrugs().add(drugVerifyInfo);
			}else{
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(drug,VerifyTypeEnums.SUCCESS);
				verifyResult.getSuccessDrugs().add(drugVerifyInfo);
			}
		}
		/*if(chuFangDrugInBaseDBCount == 0){
			return VerifyResult.fail("无此药 , 原因 :"+errorSb.toString(),verifyResult.getErrorDrugs(),verifyResult.getSuccessDrugs(),verifyResult.isTransmitErrorDrugs());
		}*/
		if(chuFangDrugInBaseDBCount!=drugs.size()){
			return VerifyResult.fail("未审核 , 原因 :"+errorSb.toString(),verifyResult.getErrorDrugs(),verifyResult.getSuccessDrugs(),verifyResult.isTransmitErrorDrugs());
		}else if(chuFangIsValid){
			return VerifyResult.success("适应证用药");
		}else{
			return VerifyResult.fail("无适应证用药 , 原因 : "+errorSb.toString(),verifyResult.getErrorDrugs(),verifyResult.getSuccessDrugs(),verifyResult.isTransmitErrorDrugs());
		}
	}

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}
}
