package org.beiyi.entity.verify;
/**
 * 人群属性
 * @author 2bu
 *
 */
public class PatientStatus {
	private AgeRange age;
	private WeightRange weight;
	private Disease disease;
	
	public AgeRange getAge() {
		return age;
	}
	public void setAge(AgeRange age) {
		this.age = age;
	}
	public WeightRange getWeight() {
		return weight;
	}
	public void setWeight(WeightRange weight) {
		this.weight = weight;
	}
	public Disease getDisease() {
		return disease;
	}
	public void setDisease(Disease disease) {
		this.disease = disease;
	}
}
