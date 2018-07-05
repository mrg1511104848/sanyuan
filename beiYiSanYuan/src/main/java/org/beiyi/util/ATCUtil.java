package org.beiyi.util;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.db.AtcCode;
import org.beiyi.entity.verify.ATCCode;

/**
 * ATC加载工具类
 * @author 2bu
 *
 */
public class ATCUtil {
	public static void main(String[] args) {
	}
	/**
	 * 根据ATCCode获取父ATCCodes
	 * @return
	 */
	public static Map<Integer, ATCCode> getATCCodeParentsByAtcCode(String atcNo){
		Map<Integer, ATCCode> atcLevelAndCodeMap = new HashMap<Integer, ATCCode>();
		if(StringUtils.isBlank(atcNo)){
			throw new RuntimeException(" The atcCode can't be blank!");
		}
		atcNo = atcNo.trim();
		int level = 1;
		for (int i = 0; i < atcNo.length(); i+=2) {
			String atcNoNew = atcNo.substring(0,i+1);
			ATCCode atcCode = new ATCCode();
			atcCode.setAtcNo(atcNoNew);
			atcCode.setLevel(level);
			atcLevelAndCodeMap.put(level, atcCode);
			level++;
		}
		return atcLevelAndCodeMap;
	}
	/**
	 * 根据ATCCode获取父ATCCodes
	 * @return
	 */
	public static Map<Integer, ATCCode> getATCCodeParentsByAtcCode(ATCCode atcCode){
		if(atcCode!=null && StringUtils.isBlank(atcCode.getAtcNo())){
			return null;
		}
		String atcNo = atcCode.getAtcNo();
		return getATCCodeParentsByAtcCode(atcNo);
	}
	/**
	 * 根据ATCCode获取父ATCCode
	 * @return
	 */
	public static String getATCCodeParentByAtcCode(String atcNo){
		atcNo = atcNo.trim();  // AB022
		if(atcNo.length() - 2 < 1){
			return null; 
		}
		String atcParentNo = atcNo.substring(0,atcNo.length() - 2);
		return atcParentNo;
	}
	
	public static int getAtcNoLevel(String atcNo){
		return atcNo.length()/2;
	}
}
