package org.beiyi.entity.verify;

public class ChuFangCheckRecord {
	private Drug chuFangDrug;
	private InstructionUse instructionUse;
	private Boolean valid = new Boolean(false);
	private String inValidText ;
	private int invalidDosageType;
	public Drug getChuFangDrug() {
		return chuFangDrug;
	}
	public void setChuFangDrug(Drug chuFangDrug) {
		this.chuFangDrug = chuFangDrug;
	}
	public InstructionUse getInstructionUse() {
		return instructionUse;
	}
	public void setInstructionUse(InstructionUse instructionUse) {
		this.instructionUse = instructionUse;
	}
	public Boolean getValid() {
		return valid;
	}
	public void setValid(Boolean valid) {
		this.valid = valid;
	}
	public String getInValidText() {
		return inValidText;
	}
	public void setInValidText(String inValidText) {
		this.inValidText = inValidText;
	}
	public int getInvalidDosageType() {
		return invalidDosageType;
	}
	public void setInvalidDosageType(int invalidDosageType) {
		this.invalidDosageType = invalidDosageType;
	}
}
