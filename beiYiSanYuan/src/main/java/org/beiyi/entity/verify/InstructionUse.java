package org.beiyi.entity.verify;
/**
 * 药品使用相关信息
 * @author 2bu
 *
 */
public class InstructionUse {
	/**
	 * 剂量选择
	 */
	private String doseSelection;
	/**
	 * 患者状态
	 */
	private String patientStatus;
	/**
	 * 每次用量
	 */
	private String dosage;
	/**
	 * 每次用量单位
	 */
	private String dosageUnit;
	/**
	 * 给药频率
	 */
	private String dosingFrequency;
	/**
	 * 给药途径
	 */
	private String routeOfMedication;
	/**
	 * 疗程控制
	 */
	private String courseControl;
	
	
	public InstructionUse() {
		super();
	}

	public InstructionUse(String dosage,
			String dosingFrequency,String doseSelection) {
		super();
		this.dosage = dosage;
		this.dosingFrequency = dosingFrequency;
		this.doseSelection = doseSelection;
	}
	
	public InstructionUse(String dosage, String dosingFrequency) {
		super();
		this.dosage = dosage;
		this.dosingFrequency = dosingFrequency;
	}


	public String getPatientStatus() {
		return patientStatus;
	}
	public void setPatientStatus(String patientStatus) {
		this.patientStatus = patientStatus;
	}
	public String getDoseSelection() {
		return doseSelection;
	}
	public void setDoseSelection(String doseSelection) {
		this.doseSelection = doseSelection;
	}
	public String getDosage() {
		return dosage;
	}
	public void setDosage(String dosage) {
		this.dosage = dosage;
	}
	public String getDosageUnit() {
		return dosageUnit;
	}
	public void setDosageUnit(String dosageUnit) {
		this.dosageUnit = dosageUnit;
	}
	public String getDosingFrequency() {
		return dosingFrequency;
	}
	/**
	 * 给药频率
	 */
	public void setDosingFrequency(String dosingFrequency) {
		this.dosingFrequency = dosingFrequency;
	}
	public String getRouteOfMedication() {
		return routeOfMedication;
	}
	public void setRouteOfMedication(String routeOfMedication) {
		this.routeOfMedication = routeOfMedication;
	}
	public String getCourseControl() {
		return courseControl;
	}
	public void setCourseControl(String courseControl) {
		this.courseControl = courseControl;
	}
}
