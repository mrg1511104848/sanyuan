package org.beiyi.service;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.beiyi.entity.db.pageBean.PrescriptionVerifyRecord;

public class Test {
	public static void main(String[] args) {
		/*Integer a = 1;
		Integer b = 1;
		System.out.println(a==b);
		a = 200;
		b = 200;
		System.out.println(a==b);
		
		PrescriptionVerifyRecord prescriptionVerifyRecord = new PrescriptionVerifyRecord();
		Map params = new HashMap();
		params.put("xxx", "xxxxx");
		params.put("prescriptionNo", "prescriptionNo1111");
		try {
			BeanUtils.populate(prescriptionVerifyRecord, params);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		System.out.println();*/
		int i = 5;
		int temp = 0;
		i=i++;
		System.out.println(temp);
		System.out.println(i);
	}
}
