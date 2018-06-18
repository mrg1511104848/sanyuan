package org.beiyi.service.verify.impl;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.beiyi.service.verify.impl.ContraindicationVerifyService.ContraindicationICD10VerifyResult;
import org.junit.Test;

public class ContraindicationVerifyServiceTest {
	@Test
	public void testCompareContraindicationICD10Match(){
        
        Object invokeResult;
		try {
			ContraindicationVerifyService test = new ContraindicationVerifyService();  
			Class<ContraindicationVerifyService> clazz = ContraindicationVerifyService.class;  
			Method declaredMethod = clazz.getDeclaredMethod("compareContraindicationICD10Match", List.class,List.class);  
			declaredMethod.setAccessible(true);  
			
			List<String> instructionContraindications = new ArrayList<String>();
			instructionContraindications.add("心脏肿物");
			instructionContraindications.add("心脏病的并发症和不明确表述");
			instructionContraindications.add("后天性心间隔缺损");
			List<String> chuFangAlldiagnosises = new ArrayList<String>();
			chuFangAlldiagnosises.add("心脏肿物");
			chuFangAlldiagnosises.add("后天性心间隔缺损");
//			chuFangAlldiagnosises.add("心脏病");
			invokeResult = declaredMethod.invoke(test, instructionContraindications,chuFangAlldiagnosises);
			@SuppressWarnings("unchecked")
			Set<ContraindicationICD10VerifyResult> results = (Set<ContraindicationICD10VerifyResult>)invokeResult;
			
			for (ContraindicationICD10VerifyResult contraindicationICD10VerifyResult : results) {
				System.out.println(contraindicationICD10VerifyResult);
			}
			declaredMethod.setAccessible(false);  
		} catch (Exception e) {
			e.printStackTrace();
		}  
	}
}
