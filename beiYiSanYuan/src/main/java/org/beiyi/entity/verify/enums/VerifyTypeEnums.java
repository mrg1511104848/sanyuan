package org.beiyi.entity.verify.enums;
/**
 * 用量审核时用到的错误类型
 * @author 2bu
 *
 */
public interface VerifyTypeEnums {
	/**
	 * 不合适的用量
	 */
	public static final int INVALID_DOSAGE = 1;
	/**
	 * 不合适的用药频率
	 */
	public static final int INVALID_DOSING_FREQUENCY = 2;
	
	/**
	 * 说明书无此药
	 */
	public static final int NO_DRUG = 3;
	/**
	 * 无效的适应症
	 */
	public static final int INVALID_INDICATION = 4;
	
	/**
	 * 通过
	 */
	public static final int SUCCESS = 100;
	
}
