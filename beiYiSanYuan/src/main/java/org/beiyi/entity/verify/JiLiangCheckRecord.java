package org.beiyi.entity.verify;
/**
 * 剂量审核用到的类
 * @author 2bu
 *
 */
public class JiLiangCheckRecord {
	private JiLiang sourceJiLiang ;
	private JiLiang targetJiLiang ;
	private Boolean valid = new Boolean(true);
	private String inValidText ;
	private int invalidDosageType;
	
	public JiLiangCheckRecord(JiLiang sourceJiLiang, JiLiang targetJiLiang) {
		super();
		this.sourceJiLiang = sourceJiLiang;
		this.targetJiLiang = targetJiLiang;
	}
	public JiLiang getSourceJiLiang() {
		return sourceJiLiang;
	}
	public void setSourceJiLiang(JiLiang sourceJiLiang) {
		this.sourceJiLiang = sourceJiLiang;
	}
	public JiLiang getTargetJiLiang() {
		return targetJiLiang;
	}
	public void setTargetJiLiang(JiLiang targetJiLiang) {
		this.targetJiLiang = targetJiLiang;
	}
	public Boolean isValid() {
		return valid;
	}
	public void setValid(Boolean valid) {
		this.valid = valid;
	}
	public String getInValidText() {
		return inValidText;
	}
	public void setInValidText(String inValidText) {
		this.inValidText = inValidText;
	}
	public int getInvalidDosageType() {
		return invalidDosageType;
	}
	public void setInvalidDosageType(int invalidDosageType) {
		this.invalidDosageType = invalidDosageType;
	}
	
}
