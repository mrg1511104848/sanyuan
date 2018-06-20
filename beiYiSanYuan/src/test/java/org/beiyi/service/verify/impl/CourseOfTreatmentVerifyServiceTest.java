package org.beiyi.service.verify.impl;

import org.beiyi.entity.VerifyResult;

public class CourseOfTreatmentVerifyServiceTest {
	public static void main(String[] args) {
		CourseOfTreatmentVerifyService verifyService = new CourseOfTreatmentVerifyService();
		VerifyResult verifyResult = verifyService.verify(CommonResourceForVerify.getChuFang(), null);
		System.out.println(verifyResult);
	}
}
