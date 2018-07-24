package org.beiyi.changliang;
/**
 * 审核流程/状态
 * @author 2bu
 *
 */
public class VerifyProgressEnum {
	/**
	 * 0 : 机器未审核 
	 */
	public static final int MECHINE_UN_AUDITED = 0;
	/**
	 * 1 : 机器已审核-未通过
	 */
	public static final int MECHINE_AUDITED_UNPASSED = 1;
	/**
	 *  2: 机器已审核 - 已通过
	 */
	public static final int MECHINE_AUDITED_PASSED = 2;
	/**
	 * 3: 医师强制提交 - 药师未审核
	 */
	public static final int INSISTSUBMIT_UN_AUDITED = 3;
	/**
	 * 4: 医师强制提交 - 药师已审核 - 未通过
	 */
	public static final int INSISTSUBMIT_AUDITED_UNPASSED = 4;
	/**
	 * 5: 医师强制提交 - 药师已审核 - 已通过
	 */
	public static final int INSISTSUBMIT_AUDITED_PASSED = 5;
}
