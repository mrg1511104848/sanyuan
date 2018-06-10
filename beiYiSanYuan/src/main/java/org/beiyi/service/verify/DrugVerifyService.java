package org.beiyi.service.verify;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.service.verify.itr.IDrugVerifyObserverable;
import org.beiyi.service.verify.itr.IDrugVeryfy;
/**
 * 被观察者
 * 实现了IDrugVerifyObserverable接口，对IDrugVerifyObserverable接口的三个方法进行了具体实现
 * @author 
 *
 */
public class DrugVerifyService  implements IDrugVerifyObserverable{
	private List<IDrugVeryfy> drugVerifies;
	
	
	public DrugVerifyService() {
		this.drugVerifies = new ArrayList<IDrugVeryfy>();
	}
	@Override
	public void registerDrugVerify(IDrugVeryfy o) {
		drugVerifies.add(o);
	}
	@Override
	public void removeDrugVerify(IDrugVeryfy o) {
		drugVerifies.remove(o);
	}
	@Override
	public VerifyResult notifyObserver(ChuFang cf) {
		VerifyResult verifyResult = new VerifyResult();
		String allResultMsg = verifyResult.getResultMsg();
		if(StringUtils.isBlank(allResultMsg)){
			allResultMsg = "";
		}
		VerifyResult lastStepVerifyResult = null;
		for (IDrugVeryfy iDrugVeryfy : drugVerifies) {
			lastStepVerifyResult = iDrugVeryfy.verify(cf,lastStepVerifyResult);
			if(!lastStepVerifyResult.isSuccess()){
				if(StringUtils.isBlank(lastStepVerifyResult.getResultMsg())){
					throw new RuntimeException(iDrugVeryfy.getClass().getName()+" 步骤出错时，未设置错误信息！");
				}
				
				allResultMsg += lastStepVerifyResult.getResultMsg() + " \n ";//只要是失败的，就将错误的返回信息拼装记录一下。
				
				//只要是审核不适宜的药品，就将不适宜的药品拼装到总的verifyResult的不适宜药品中。
				List<DrugVerifyInfo> allErrorDrugs = verifyResult.getErrorDrugs();
				List<DrugVerifyInfo> lastStepVerifyErrorDrugs = lastStepVerifyResult.getErrorDrugs();
				for (DrugVerifyInfo lastStepVerifyErrorDrug : lastStepVerifyErrorDrugs) {
					if(!allErrorDrugs.contains(lastStepVerifyErrorDrug)){
						allErrorDrugs.add(lastStepVerifyErrorDrug);
					}
				}
				verifyResult.setSuccess(false);
				verifyResult.setResultMsg(allResultMsg);
				
				if(lastStepVerifyResult.getSuccessDrugs().size() == 0){//全部失败，直接返回审核的结果，不进行下一流程的审核
					return verifyResult;
				}else{//部分失败，继续审核其他药的其他流程
					
				}
			}
		}
		if(verifyResult.getErrorDrugs().size() == 0){
			verifyResult.setSuccess(true);
		}
		return verifyResult;
	}
}
