package org.beiyi.entity.verify.enums;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.verify.AgeRange;
import org.beiyi.entity.verify.Disease;
import org.beiyi.entity.verify.Patient;
import org.beiyi.entity.verify.PatientCore;
import org.beiyi.entity.verify.PatientStatus;
import org.beiyi.entity.verify.WeightRange;

public class PatientEnums {
	public static PatientCore PATIENT_ADULT; //成人
	public static PatientCore PATIENT_ADULT_AND_AGE_GT_12; //成人及12岁以上儿童
	static{
		initPatient();
	}
	private static void initPatient(){
		//成人
		PATIENT_ADULT = new PatientCore();
		PatientStatus patientStatus = new PatientStatus();
		patientStatus.setAge(AgeRangeEnums.AGE_RANGE_ADULT);
		
		List<Patient> patients = new ArrayList<Patient>();
		Patient firstPatient = new Patient();
		firstPatient.getPatientStatus()[0] = patientStatus;
		PATIENT_ADULT.setPatients(patients);
		//
	}
	public static void main(String[] args) {
		boolean isMatch = isMatch(PATIENT_ADULT, 11, 50, null);
		System.out.println(isMatch);
	}
	private static boolean isMatch(PatientCore patient,Integer age,Integer weight,String disease){
		if(patient == null){
			throw new RuntimeException("Patient can't be null ！");
		}
		List<Patient> patients = patient.getPatients();
		if(patients == null){
			throw new RuntimeException("Patient's can't be null ！");
		}
		if(age == null && weight == null && disease == null){
			throw new RuntimeException("Age ,Weight, Disease can't not all empty!");
		}
		for (Patient patit : patients) {
			PatientStatus[] patientStatus = patit.getPatientStatus();
			for (PatientStatus patientStat : patientStatus) {
				AgeRange ageRange = patientStat.getAge();
				WeightRange weightRange = patientStat.getWeight();
				Disease patientStatDis = patientStat.getDisease();
				if(ageRange!=null && age == null){
					System.out.println("Age can't match ageRange,because of age is null");
					return false;
				}
				if(weightRange!=null && weight==null){
					System.out.println("Weight can't match weightRange,because of weight is null");
					return false;
				}
				if(patientStatDis!=null && StringUtils.isBlank(disease)){
					System.out.println("Disease can't match patientStatDis,because of disease is null");
					return false;
				}
				if(ageRange!=null && age!=null){
					if(!(age>=ageRange.getStart() && age<=ageRange.getEnd())){
						return false;
					}
				}
				if(weightRange!=null && weight!=null){
					if(!(weight>=weightRange.getStart() && weight<=weightRange.getEnd())){
						return false;
					}
				}
			}
		}
		return false;
	}
}
