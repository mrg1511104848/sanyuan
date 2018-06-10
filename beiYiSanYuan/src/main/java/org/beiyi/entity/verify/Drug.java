package org.beiyi.entity.verify;
/**
 * 药品信息
 * @author 2bu
 *
 */
public class Drug {
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
	 * 包装
	 */
	private String pack;
	/**
	 * 给药途径
	 */
	private String routeOfMedication;
	/**
	 * 生产企业
	 */
	private String company;
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
	 * 发药数量
	 */
	private String drugQuantity;
	
	/**
	 * 发药数量单位
	 */
	private String drugQuantityUnit;


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

	public String getPack() {
		return pack;
	}

	public void setPack(String pack) {
		this.pack = pack;
	}

	public String getRouteOfMedication() {
		return routeOfMedication;
	}

	public void setRouteOfMedication(String routeOfMedication) {
		this.routeOfMedication = routeOfMedication;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
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

	public void setDosingFrequency(String dosingFrequency) {
		this.dosingFrequency = dosingFrequency;
	}

	public String getDrugQuantity() {
		return drugQuantity;
	}

	public void setDrugQuantity(String drugQuantity) {
		this.drugQuantity = drugQuantity;
	}

	public String getDrugQuantityUnit() {
		return drugQuantityUnit;
	}

	public void setDrugQuantityUnit(String drugQuantityUnit) {
		this.drugQuantityUnit = drugQuantityUnit;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((company == null) ? 0 : company.hashCode());
		result = prime
				* result
				+ ((drugCombinationName == null) ? 0 : drugCombinationName
						.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Drug other = (Drug) obj;
		if (company == null) {
			if (other.company != null)
				return false;
		} else if (!company.equals(other.company))
			return false;
		if (drugCombinationName == null) {
			if (other.drugCombinationName != null)
				return false;
		} else if (!drugCombinationName.equals(other.drugCombinationName))
			return false;
		return true;
	}
	
}
