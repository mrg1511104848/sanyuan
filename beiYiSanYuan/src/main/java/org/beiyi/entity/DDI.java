package org.beiyi.entity;

public class DDI {
	private String dxyDrugATongYongMing ;
	private String dxyDrugAShangPinMing ;
	private String dxyDrugBTongYongMing ;
	private String dxyDrugBShangPinMing ;
	private String level ;
	public String getDxyDrugATongYongMing() {
		return dxyDrugATongYongMing;
	}
	public void setDxyDrugATongYongMing(String dxyDrugATongYongMing) {
		this.dxyDrugATongYongMing = dxyDrugATongYongMing;
	}
	public String getDxyDrugAShangPinMing() {
		return dxyDrugAShangPinMing;
	}
	public void setDxyDrugAShangPinMing(String dxyDrugAShangPinMing) {
		this.dxyDrugAShangPinMing = dxyDrugAShangPinMing;
	}
	public String getDxyDrugBTongYongMing() {
		return dxyDrugBTongYongMing;
	}
	public void setDxyDrugBTongYongMing(String dxyDrugBTongYongMing) {
		this.dxyDrugBTongYongMing = dxyDrugBTongYongMing;
	}
	public String getDxyDrugBShangPinMing() {
		return dxyDrugBShangPinMing;
	}
	public void setDxyDrugBShangPinMing(String dxyDrugBShangPinMing) {
		this.dxyDrugBShangPinMing = dxyDrugBShangPinMing;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public DDI(String dxyDrugATongYongMing, String dxyDrugAShangPinMing,
			String dxyDrugBTongYongMing, String dxyDrugBShangPinMing,
			String level) {
		super();
		this.dxyDrugATongYongMing = dxyDrugATongYongMing;
		this.dxyDrugAShangPinMing = dxyDrugAShangPinMing;
		this.dxyDrugBTongYongMing = dxyDrugBTongYongMing;
		this.dxyDrugBShangPinMing = dxyDrugBShangPinMing;
		this.level = level;
	}
}
