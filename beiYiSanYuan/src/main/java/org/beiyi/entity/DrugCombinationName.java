package org.beiyi.entity;

import org.beiyi.util.DrugInfoParseToStandard;

/**
 * 药品商品名，通用名组合类
 * @author 2bu
 *
 */
public class DrugCombinationName {
	private String shangPinName;
	private String tongYongName;
	private String standardCombinationName;
	public DrugCombinationName(String shangPinName, String tongYongName) {
		super();
		this.shangPinName = shangPinName.replace(" ", "");
		this.tongYongName = tongYongName.replace(" ", "");
	}
	public DrugCombinationName(String combinationName) {
		super();
		this.shangPinName = DrugInfoParseToStandard.getDrugName(combinationName, 1).replace(" ", "");
		this.tongYongName = DrugInfoParseToStandard.getDrugName(combinationName, 2).replace(" ", "");
		this.standardCombinationName = getCombinationStandardName();
	}
	public String getShangPinName() {
		return shangPinName;
	}
	public void setShangPinName(String shangPinName) {
		this.shangPinName = shangPinName;
	}
	public String getTongYongName() {
		return tongYongName;
	}
	public void setTongYongName(String tongYongName) {
		this.tongYongName = tongYongName;
	}
	public String getCombinationName(){
		return this.shangPinName+"("+this.tongYongName+")";
	}
	public String getStandardShangPinName(){
		return DrugInfoParseToStandard.shangPinNameParseToStandard(this.shangPinName);
	}
	public String getCombinationStandardName(){
		return DrugInfoParseToStandard.shangPinNameParseToStandard(this.shangPinName)+"("+this.tongYongName+")";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((shangPinName == null) ? 0 : shangPinName.hashCode());
		result = prime * result
				+ ((tongYongName == null) ? 0 : tongYongName.hashCode());
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
		DrugCombinationName other = (DrugCombinationName) obj;
		if(standardCombinationName == null){
			if (other.standardCombinationName != null)
				return false;
		}else if (!standardCombinationName.equals(other.standardCombinationName)){
			return false;
		}
		return true;
	}
	
}
