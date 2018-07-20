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
	/**
	 * 错误的消息
	 */
	private String errMessage;

	
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

	public String getErrMessage() {
		return errMessage;
	}

	public void setErrMessage(String errMessage) {
		this.errMessage = errMessage;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((drug == null) ? 0 : drug.hashCode());
		result = prime * result
				+ ((errMessage == null) ? 0 : errMessage.hashCode());
		result = prime * result + verifyResultType;
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
		if (errMessage == null) {
			if (other.errMessage != null)
				return false;
		} else if (!errMessage.equals(other.errMessage))
			return false;
		if (verifyResultType != other.verifyResultType)
			return false;
		return true;
	}
}
