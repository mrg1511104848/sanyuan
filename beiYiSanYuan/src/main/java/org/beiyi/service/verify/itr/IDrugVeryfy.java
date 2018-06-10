package org.beiyi.service.verify.itr;

import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.VerifyResult;

/***
 * 抽象观察者
 * 定义了一个verify(ChuFang chuFang)方法，当被观察者调用notifyObservers()方法时，观察者的update()方法会被回调。
 * @author 
 */
public interface IDrugVeryfy {
	/**
	 * 审核
	 * @param chuFang 处方
	 * @param lastStepVerifyResult 上一步骤审核的结果。供下一步骤使用
	 * @return
	 */
	VerifyResult verify(ChuFang chuFang,VerifyResult lastStepVerifyResult);
}
