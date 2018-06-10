package org.beiyi.entity.verify;

public class DrugVerifyInfo{
	/**
	 * 药品
	 */
	private Drug drug;
	/**
	 * 药品校验结果的类型
	 */
	private int verifyResultType;

	
	public DrugVerifyInfo() {
		super();
	}

	public DrugVerifyInfo(Drug drug) {
		super();
		this.drug = drug;
	}

	public DrugVerifyInfo(Drug drug, int verifyResultType) {
		super();
		this.drug = drug;
		this.verifyResultType = verifyResultType;
	}

	public int getVerifyResultType() {
		return verifyResultType;
	}

	public void setVerifyResultType(int verifyResultType) {
		this.verifyResultType = verifyResultType;
	}

	public Drug getDrug() {
		return drug;
	}

	public void setDrug(Drug drug) {
		this.drug = drug;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((drug == null) ? 0 : drug.hashCode());
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
		DrugVerifyInfo other = (DrugVerifyInfo) obj;
		if (drug == null) {
			if (other.drug != null)
				return false;
		} else if (!drug.equals(other.drug))
			return false;
		return true;
	}
	
}
