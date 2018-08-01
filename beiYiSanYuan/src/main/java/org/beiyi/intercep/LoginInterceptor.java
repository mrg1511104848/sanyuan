package org.beiyi.intercep;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.controller.base.SessionData;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	System.out.println("in preHandle ->"+request.getRequestURI());
        Object user = request.getSession().getAttribute(SessionData.USER);
        String type = request.getHeader("X-Requested-With");// XMLHttpRequest
        if (user == null) {
        	String path = request.getContextPath();
        	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
        	if (StringUtils.equals("XMLHttpRequest", type)) {
                // ajax请求
                response.setHeader("SESSIONSTATUS", "TIMEOUT");
                response.setHeader("CONTEXTPATH", basePath+"/user/toLogin.htm");
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);//403 禁止
                return false;
            } else {
            	System.out.println("--start 尚未登录，调到登录页面");
                response.sendRedirect("/beiYiSanYuan/user/toLogin.htm");
                System.out.println("--end 尚未登录，调到登录页面");
                System.out.println("out preHandle ->"+request.getRequestURI());
                return false;
            }
        }
        System.out.println("out preHandle ->"+request.getRequestURI());
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle");
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("afterCompletion");
    }

}
