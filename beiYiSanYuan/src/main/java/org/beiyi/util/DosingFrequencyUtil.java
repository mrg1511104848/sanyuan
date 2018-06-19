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
		String dayTimeInfo = Resources.dddsCalculateMap.get(dosingFrequency);//一天几次
		if(StringUtils.isBlank(dayTimeInfo)){
			log.warn("Can't parse The dosingFrequency of "+dosingFrequency);
			return null;
		}
		
		dayTimeInfo = dayTimeInfo.trim();
		String time = dayTimeInfo.split("_")[1];//index0 时间(1天为单位) index1 次数
		return Integer.parseInt(time);
	}
	/**
	 * 根据提供的dosingFrequency转换成单日n次
	 * @param dosingFrequency
	 * @return
	 */
	public static String[] getDosingFrequency(String dosingFrequency){
		String dayTimeInfo = Resources.dddsCalculateMap.get(dosingFrequency);//一天几次
		if(StringUtils.isBlank(dayTimeInfo)){
			log.warn("Can't parse The dosingFrequency of "+dosingFrequency);
			return null;
		}
		return dayTimeInfo.split("_");
	}
}
