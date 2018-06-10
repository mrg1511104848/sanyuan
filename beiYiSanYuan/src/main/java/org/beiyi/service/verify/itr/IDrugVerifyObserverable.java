package org.beiyi.service.verify.itr;

import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;

/***
 * 抽象被观察者接口
 * 声明了添加、删除、通知观察者方法
 * @author 
 *
 */
public interface IDrugVerifyObserverable {
	void registerDrugVerify(IDrugVeryfy o);
	void removeDrugVerify(IDrugVeryfy o);
    VerifyResult notifyObserver(ChuFang o);
}
