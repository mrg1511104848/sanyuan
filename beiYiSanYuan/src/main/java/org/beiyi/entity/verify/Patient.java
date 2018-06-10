package org.beiyi.entity.verify;


/**
 * 人群
 * @author 2bu
 *
 */
public class Patient {
	private PatientStatus[] patientStatus = new PatientStatus[2];
	private String oprator; // and ; or ;
	
	public PatientStatus[] getPatientStatus() {
		return patientStatus;
	}
	public void setPatientStatus(PatientStatus[] patientStatus) {
		this.patientStatus = patientStatus;
	}
	public String getOprator() {
		return oprator;
	}
	public void setOprator(String oprator) {
		this.oprator = oprator;
	}
}
