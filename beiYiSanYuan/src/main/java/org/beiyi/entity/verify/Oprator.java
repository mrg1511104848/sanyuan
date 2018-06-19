package org.beiyi.entity.verify;

import java.util.List;

public class Oprator {
	private List<Double> toCompareNums;// 数值，可能是个范围
	private String type;// 比较的类型

	public List<Double> getToCompareNums() {
		return toCompareNums;
	}

	public void setToCompareNums(List<Double> toCompareNums) {
		this.toCompareNums = toCompareNums;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
