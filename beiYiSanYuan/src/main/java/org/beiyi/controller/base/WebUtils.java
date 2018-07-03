package org.beiyi.controller.base;

import net.sf.json.JSONObject;

public class WebUtils {
	public static final String CODE = "code";
    public static final String MSG = "message";
    public static final String DATA = "data";

    //成功，无message
    public static JSONObject createSuccResult() {
        return createResp(ResponseEnum.SUCCESS);
    }
    //成功，有message
    public static JSONObject createSuccResult(Object data) {
        JSONObject result = createSuccResult();
        result.put(DATA, data);
        return result;
    }
    //成功，引用某个ResponseEnum类常量来实现
    private static JSONObject createResp(ResponseEnum responseEnum) {
        JSONObject result = new JSONObject();
        result.put(CODE, responseEnum.getCode());
        result.put(MSG, responseEnum.getMessage());
        return result;
    }

    //失败：没有message
    public static JSONObject createErrorResult() {
        return createResp(ResponseEnum.UNKNOWN_ERROR);
    }
    //失败：引用ResponseEnum类常量
    public static JSONObject createErrorResult(ResponseEnum responseEnum) {
        return createResp(responseEnum);
    }
    //失败，引用某个ResponseEnum类常量，和数据
    public static JSONObject createErrorResult(ResponseEnum responseEnum, Object data) {
        JSONObject resp = createResp(responseEnum);
        resp.put(DATA, data);
        return resp;
    }

}
