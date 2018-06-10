package org.beiyi.entity;


/**
 * 适应症
 * @author 2bu
 *
 */
public class AdaptationDisease {
	private int type; // 1:成人 2:儿童
	private String fieldName;//【常规用法用量】/【肝功能不全剂量调整】/...
	private String fieldValue;//值
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldValue() {
		return fieldValue;
	}
	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}
}
