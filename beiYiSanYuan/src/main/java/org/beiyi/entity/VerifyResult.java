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
	/**
	 * 查看上一步审核过程中（适应症）是否包含这个错误的drug
	 */
	public static boolean drugContainsInErrorDrugs(VerifyResult lastStepVerifyResult,Drug drug){
		if(lastStepVerifyResult == null){
			return false;
		}
		if(drug == null)
			throw new RuntimeException("When the method drugContainsInErrorDrugs() is called, the passed argument drug is null");
		return lastStepVerifyResult.getErrorDrugs().contains(drug);
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
}
