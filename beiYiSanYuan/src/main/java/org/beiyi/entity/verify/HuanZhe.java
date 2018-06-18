package org.beiyi.entity.verify;
/**
 * 患者信息
 * @author 2bu
 *
 */
public class HuanZhe {
	/**
	 * 出生日期
	 */
	private String bornDate;
	/**
	 * 就诊日期
	 */
	private String jiuZhenDate;
	/**
	 * 性别
	 */
	private String sex;
	
	public String getBornDate() {
		return bornDate;
	}

	public void setBornDate(String bornDate) {
		this.bornDate = bornDate;
	}

	public String getJiuZhenDate() {
		return jiuZhenDate;
	}

	public void setJiuZhenDate(String jiuZhenDate) {
		this.jiuZhenDate = jiuZhenDate;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
}
