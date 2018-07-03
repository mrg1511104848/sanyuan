package org.beiyi.controller.base;

public enum ResponseEnum {
	/**
	 * ===================================== 0-99
	 * =====================================
	 */
	SUCCESS("0", "操作成功"), FAILURE("1", "操作失败"), INVALID_PARAMS("2", "非法参数"), INVALID_SIGN(
			"3", "非法签名"), UNKNOWN_ERROR("4", "未知错误");

	private String code;
	private String message;

	// 构造方法
	private ResponseEnum(String code, String message) {
		this.code = code;
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}
}
