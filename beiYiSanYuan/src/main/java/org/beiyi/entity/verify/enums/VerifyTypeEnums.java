package org.beiyi.entity.verify.enums;
/**
 * 用量审核时用到的错误类型
 * @author 2bu
 *
 */
public interface VerifyTypeEnums {
	/**
	 * 通过
	 */
	public static final int SUCCESS = 100;
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
	 * 无效的用法
	 */
	public static final int INVALID_USAGE = 5;
	
	/**
	 * 转换用量单位时出现错误
	 */
	public static final int ERROR_PARSE_DOSAGE_UNIT = 6;
	
	/**
	 * 重复给药
	 */
	public static final int REPEATED_PRESCRIPTIONS = 7;
	/**
	 * 禁忌症/禁用人群
	 */
	public static final int CONTRAINDICATIONS = 8;
	/**
	 * 性别审核不通过
	 */
	public static final int SEX_INVALID = 9;
	/**
	 * 统一单位失败
	 */
	public static final int INVALID_UNIT = 10;
	/**
	 * 用量超出日剂量上限
	 */
	public static final int INVALID_DOSAGE_GT_DAY_LIMIT = 11;
	/**
	 * 无效的疗程
	 */
	public static final int INVALID_COURSE_OF_TREATMENT = 12;
}
