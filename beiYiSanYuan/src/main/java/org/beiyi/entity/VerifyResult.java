package org.beiyi.entity;

import java.util.ArrayList;
import java.util.List;

import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugVerifyInfo;

/**
 * 处方审核结果  - 封装
 * @author 2bu
 *
 */
public class VerifyResult {
	/**
	 * 结果
	 */
	private String resultMsg;
	/**
	 * 通过/未通过
	 */
	private boolean success;
	/**
	 * 错误的药品列表
	 */
	private List<DrugVerifyInfo> errorDrugs = new ArrayList<DrugVerifyInfo>();
	/**
	 * 正确的药品列表
	 */
	private List<DrugVerifyInfo> successDrugs = new ArrayList<DrugVerifyInfo>();
	
	/**
	 * 是否将错误药品传递到下一个审核流程中去，为false的话表示不传递错误药品，下一流程仍然审核该药品
	 */
	private boolean transmitErrorDrugs;
	
	public VerifyResult() {
		super();
	}
	public VerifyResult(boolean transmitErrorDrugs) {
		super();
		this.transmitErrorDrugs = transmitErrorDrugs;
	}
	public static VerifyResult success(){
		VerifyResult result = new VerifyResult();
		result.success = true;
		result.resultMsg = "审核通过";
		return result;
	}
	public static VerifyResult success(String resultMsg){
		VerifyResult result = new VerifyResult();
		result.success = true;
		result.resultMsg = resultMsg;
		return result;
	}
	public static VerifyResult fail(String resultMsg){
		VerifyResult result = new VerifyResult();
		result.success = false;
		result.resultMsg = resultMsg;
		return result;
	}
	public static VerifyResult fail(String resultMsg,List<DrugVerifyInfo> errorDrugs,List<DrugVerifyInfo> successDrugs){
		VerifyResult result = new VerifyResult();
		result.success = false;
		result.resultMsg = resultMsg;
		result.errorDrugs = errorDrugs;
		result.successDrugs = successDrugs;
		return result;
	}
	
	public static VerifyResult fail(String resultMsg, List<DrugVerifyInfo> errorDrugs,
			List<DrugVerifyInfo> successDrugs, boolean transmitErrorDrugs) {
		VerifyResult result = new VerifyResult();
		result.resultMsg = resultMsg;
		result.errorDrugs = errorDrugs;
		result.successDrugs = successDrugs;
		result.transmitErrorDrugs = transmitErrorDrugs;
		return result;
	}
	/**
	 * 查看上一步审核过程中（适应症）是否包含这个错误的drug
	 * 如果上一审核流程的transmitErrorDrugs(错误药品可传递标识)为false，则在判断是否包含这个drug时，默认返回false；
	 */
	public static boolean drugContainsInErrorDrugs(VerifyResult lastStepVerifyResult,Drug drug){
		if(lastStepVerifyResult == null){
			return false;
		}
		if(drug == null)
			throw new RuntimeException("When the method drugContainsInErrorDrugs() is called, the passed argument drug is null");
		List<DrugVerifyInfo> errDrugVerifyInfos = lastStepVerifyResult.getErrorDrugs();
		//drugContainsInErrorDrugs执行的时候，判断是否包含这个错误药品，如果包含，则不审核这个药品，而
		//transmitErrorDrugs(错误药品可传递标识)如果为true，代表将上一流程的错误药品传递下去，该错误药品不需要下一流程审核，
		for (DrugVerifyInfo errDrugVerifyInfo : errDrugVerifyInfos) {
			if(errDrugVerifyInfo.getDrug().equals(drug) ){
				return true;
			}
		}
		return false;
	}
	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}
	public List<DrugVerifyInfo> getErrorDrugs() {
		return errorDrugs;
	}
	public void setErrorDrugs(List<DrugVerifyInfo> errorDrugs) {
		this.errorDrugs = errorDrugs;
	}
	public List<DrugVerifyInfo> getSuccessDrugs() {
		return successDrugs;
	}
	public void setSuccessDrugs(List<DrugVerifyInfo> successDrugs) {
		this.successDrugs = successDrugs;
	}
	public boolean isTransmitErrorDrugs() {
		return transmitErrorDrugs;
	}
	public void setTransmitErrorDrugs(boolean transmitErrorDrugs) {
		this.transmitErrorDrugs = transmitErrorDrugs;
	}
}
