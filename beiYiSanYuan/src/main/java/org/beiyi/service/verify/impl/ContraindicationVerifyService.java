package org.beiyi.service.verify.impl;

import java.util.HashSet;
import java.util.Set;

import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.service.verify.itr.IDrugVeryfy;

/**
 * 禁忌症审核
 * @author 2bu
 *
 */
public class ContraindicationVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		
		
		return null;
	}
	
}
