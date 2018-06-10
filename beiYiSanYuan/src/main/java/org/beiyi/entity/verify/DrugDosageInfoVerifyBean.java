package org.beiyi.entity.verify;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.beiyi.entity.DrugCombinationName;

/**
 * 针对处方中的剂量审核封装的关于审核结果的bean
 * @author 2bu
 *
 */
public class DrugDosageInfoVerifyBean {
	private Drug drug;
	private Set<String> validInstructionDosages = new HashSet<String>();//合适的用药剂量列表
	private Set<String> validInstructionDosFrequencys = new HashSet<String>();//合适的用药频率列表
	private Set<String> invalidInstructionDosages = new HashSet<String>();//不符合用药剂量列表
	private Set<String> invalidInstructionDosFrequencys = new HashSet<String>();//用药频率列表
	public Drug getDrug() {
		return drug;
	}
	public void setDrug(Drug drug) {
		this.drug = drug;
	}
	
	public Set<String> getInvalidInstructionDosages() {
		return invalidInstructionDosages;
	}
	public void setInvalidInstructionDosages(Set<String> invalidInstructionDosages) {
		this.invalidInstructionDosages = invalidInstructionDosages;
	}
	public Set<String> getInvalidInstructionDosFrequencys() {
		return invalidInstructionDosFrequencys;
	}
	public void setInvalidInstructionDosFrequencys(
			Set<String> invalidInstructionDosFrequencys) {
		this.invalidInstructionDosFrequencys = invalidInstructionDosFrequencys;
	}
	public Set<String> getValidInstructionDosages() {
		return validInstructionDosages;
	}
	public void setValidInstructionDosages(Set<String> validInstructionDosages) {
		this.validInstructionDosages = validInstructionDosages;
	}
	public Set<String> getValidInstructionDosFrequencys() {
		return validInstructionDosFrequencys;
	}
	public void setValidInstructionDosFrequencys(
			Set<String> validInstructionDosFrequencys) {
		this.validInstructionDosFrequencys = validInstructionDosFrequencys;
	}
}
