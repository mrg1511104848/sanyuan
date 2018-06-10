package org.beiyi.entity;

public class ChuFang {
	private String drugName;
	private String diseaseKeyword;
	private String disease;
	
	public String getDrugName() {
		return drugName;
	}
	public void setDrugName(String drugName) {
		this.drugName = drugName;
	}
	public String getDiseaseKeyword() {
		return diseaseKeyword;
	}
	public void setDiseaseKeyword(String diseaseKeyword) {
		this.diseaseKeyword = diseaseKeyword;
	}
	
	public String getDisease() {
		return disease;
	}
	public void setDisease(String disease) {
		this.disease = disease;
	}
	@Override
	public String toString() {
		return "ChuFang [drugName=" + drugName + ", disease="
				+ disease + "]";
	}
	
}
