package org.beiyi.entity.verify;

import java.util.List;

/**
 * 
 * 整理好的说明书 数据库封装
 * @author 2bu
 *
 */
public class Instruction {
	/**
	 * 药品名称
	 */
	private String drugCombinationName;
	/**
	 * 剂型
	 */
	private String form;
	/**
	 * 规格
	 */
	private String standard;
	/**
	 * 药品使用
	 */
	private List<InstructionUse> instructionUses;
	
	/**
	 * 多个诊断/适应症
	 */
	private List<String> diagnosises;
	
	public String getDrugCombinationName() {
		return drugCombinationName;
	}
	public void setDrugCombinationName(String drugCombinationName) {
		this.drugCombinationName = drugCombinationName;
	}
	public String getForm() {
		return form;
	}
	public void setForm(String form) {
		this.form = form;
	}
	public String getStandard() {
		return standard;
	}
	public void setStandard(String standard) {
		this.standard = standard;
	}
	public List<InstructionUse> getInstructionUses() {
		return instructionUses;
	}
	public void setInstructionUses(List<InstructionUse> instructionUses) {
		this.instructionUses = instructionUses;
	}
	public List<String> getDiagnosises() {
		return diagnosises;
	}
	public void setDiagnosises(List<String> diagnosises) {
		this.diagnosises = diagnosises;
	}
	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Instruction) {  
			Instruction instruction = (Instruction) obj;  
			return this.drugCombinationName.equals(instruction.drugCombinationName);
		}
		return super.equals(obj);
	}
	@Override
	public int hashCode() {
		return super.hashCode();
	}
	
}
