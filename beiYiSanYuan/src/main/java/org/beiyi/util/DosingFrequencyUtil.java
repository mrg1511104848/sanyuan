package org.beiyi.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.beiyi.reource.Resources;

/**
 * 用药频率工具类
 * @author 2bu
 *
 */
public class DosingFrequencyUtil {
	private static Logger log = Logger.getLogger(DosingFrequencyUtil.class);
	/**
	 * 根据提供的dosingFrequency转换成单日n次
	 * @param dosingFrequency
	 * @return
	 */
	public static Integer parseDosingFrequency(String dosingFrequency){
		String oneDayTime = Resources.dddsCalculateMap.get(dosingFrequency);//一天几次
		if(StringUtils.isBlank(oneDayTime)){
			log.warn("Can't parse The dosingFrequency of "+dosingFrequency);
			return null;
		}
		oneDayTime = oneDayTime.trim();
		return Integer.parseInt(oneDayTime);
	}
}
