package org.beiyi.entity.verify;

/**
 * 剂量封装
 * 
 * @author 2bu
 *
 */
public class JiLiang extends InstructionUse {

	private String oprator;// 操作符 >= <= =
	private String type;// 次/日 1/2

	public JiLiang() {
		super();
	}

	public JiLiang(String dosage, String dosingFrequency, String doseSelection) {
		super(dosage, dosingFrequency, doseSelection);
	}

	public JiLiang(String dosage, String dosingFrequency) {
		super(dosage, dosingFrequency);
	}

	public String getOprator() {
		return oprator;
	}

	public void setOprator(String oprator) {
		this.oprator = oprator;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
