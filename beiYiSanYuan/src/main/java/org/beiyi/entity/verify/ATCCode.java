package org.beiyi.entity.verify;


public class ATCCode {
	private String atcNo;
	private String chName;
	private String enName;
	private String dosage;
	private String unit;
	private String wayOfTaking;
	private int level;
	public ATCCode() {
		super();
	}
	public ATCCode(String atcNo, String chName, String enName) {
		super();
		this.atcNo = atcNo;
		this.chName = chName;
		this.enName = enName;
	}

	public ATCCode(String atcNo) {
		super();
		this.atcNo = atcNo;
	}
	public String getAtcNo() {
		return atcNo;
	}
	public void setAtcNo(String atcNo) {
		this.atcNo = atcNo;
	}
	public String getChName() {
		return chName;
	}
	public void setChName(String chName) {
		this.chName = chName;
	}
	public String getEnName() {
		return enName;
	}
	public void setEnName(String enName) {
		this.enName = enName;
	}
	public String getDosage() {
		return dosage;
	}
	public void setDosage(String dosage) {
		this.dosage = dosage;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getWayOfTaking() {
		return wayOfTaking;
	}
	public void setWayOfTaking(String wayOfTaking) {
		this.wayOfTaking = wayOfTaking;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((atcNo == null) ? 0 : atcNo.hashCode());
		result = prime * result + level;
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
		ATCCode other = (ATCCode) obj;
		if (atcNo == null) {
			if (other.atcNo != null)
				return false;
		} else if (!atcNo.equals(other.atcNo))
			return false;
		if (level != other.level)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "[atcNo=" + atcNo + "]";
	}
	
}
