package org.beiyi.entity.verify;

import java.util.List;

/**
 * 审核用的处方
 * @author 2bu
 *
 */
public class ChuFang {
	/**
	 * 处方号
	 */
	private String chuFangNo;
	/**
	 * 患者信息
	 */
	private HuanZhe huanZhe;
	/**
	 * 多个诊断
	 */
	private List<String> diagnosises;
	/**
	 * 多个药品
	 */
	private List<Drug> drugs;
	
	private List<List<String>> chuFangOldRows;
	public String getChuFangNo() {
		return chuFangNo;
	}
	public void setChuFangNo(String chuFangNo) {
		this.chuFangNo = chuFangNo;
	}
	public HuanZhe getHuanZhe() {
		return huanZhe;
	}
	public void setHuanZhe(HuanZhe huanZhe) {
		this.huanZhe = huanZhe;
	}
	public List<String> getDiagnosises() {
		return diagnosises;
	}
	public void setDiagnosises(List<String> diagnosises) {
		this.diagnosises = diagnosises;
	}
	public List<Drug> getDrugs() {
		return drugs;
	}
	public void setDrugs(List<Drug> drugs) {
		this.drugs = drugs;
	}
	public List<List<String>> getChuFangOldRows() {
		return chuFangOldRows;
	}
	public void setChuFangOldRows(List<List<String>> chuFangOldRows) {
		this.chuFangOldRows = chuFangOldRows;
	}
}
