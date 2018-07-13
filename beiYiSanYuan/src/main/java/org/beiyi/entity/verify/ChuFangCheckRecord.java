package org.beiyi.entity.verify;

import org.beiyi.entity.db.IndicationTherapeuticRegimen;

public class ChuFangCheckRecord {
	private Drug chuFangDrug;
	private IndicationTherapeuticRegimen instructionUse;
	private Boolean valid = new Boolean(false);
	private String inValidText ;
	private int invalidDosageType;
	public Drug getChuFangDrug() {
		return chuFangDrug;
	}
	public void setChuFangDrug(Drug chuFangDrug) {
		this.chuFangDrug = chuFangDrug;
	}
	public IndicationTherapeuticRegimen getInstructionUse() {
		return instructionUse;
	}
	public void setInstructionUse(IndicationTherapeuticRegimen instructionUse) {
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
