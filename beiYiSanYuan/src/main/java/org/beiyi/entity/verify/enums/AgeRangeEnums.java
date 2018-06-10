package org.beiyi.entity.verify.enums;

import org.beiyi.entity.verify.AgeRange;

public class AgeRangeEnums {
	public static AgeRange AGE_RANGE_ADULT;
	static{
		initAgeRange();
	}
	private static void initAgeRange() {
		AGE_RANGE_ADULT = new AgeRange();
		AGE_RANGE_ADULT.setStart(18);
		AGE_RANGE_ADULT.setEnd(50);
	}
}
