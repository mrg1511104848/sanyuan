package org.beiyi.service.verify.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
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
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			
			if(VerifyResult.drugContainsInErrorDrugs(lastStepVerifyResult, chuFangDrug)){
				continue;
			}
			
			String chuFangRouteOfMedication = chuFangDrug.getRouteOfMedication();
			if(StringUtils.isBlank(chuFangRouteOfMedication)){
				String errorMsg = String.format(" %s 药品 ", chuFangDrug.getDrugCombinationName());
				errMsgBuffer.append(String.format("%s【药品】 %s 用法不适宜，具体原因为 ： %s",ExcelUtil.NEW_LINE, chuFangDrug.getDrugCombinationName(),errorMsg));
				continue;
			}
			// 获取整理好的说明书的药品
			Instruction instruction = InstructionsReadUtil.get(chuFangDrug.getDrugCombinationName());
			if(instruction == null){
				String errorMsg = String.format(" %s 在说明书中不存在！", chuFangDrug.getDrugCombinationName());
				errMsgBuffer.append(String.format("%s【药品】 %s 用法不适宜，具体原因为 ： %s",ExcelUtil.NEW_LINE, chuFangDrug.getDrugCombinationName(),errorMsg));
				continue;
			}
			
			List<InstructionUse> instructionUses = instruction.getInstructionUses();
			//遍历  整理好的说明书 - 药品使用相关信息
			for (InstructionUse instructionUse : instructionUses) {
				String instructionRouteOfMedication = instructionUse.getRouteOfMedication();
				if(org.apache.commons.lang3.StringUtils.isBlank(instructionRouteOfMedication)){ //说明书中如果用法是空，直接略过
					continue;
				}
				if(instructionRouteOfMedication.equals(chuFangRouteOfMedication)){//相等表示可以用，药品通过此项审核
					//TODO 封装到verifyResult
				}
					
					
			}
		}
		return null;
	}
	
}
