package org.beiyi.service.db.itr;

public interface IPrescriptionDistributionRecordService {
	/**
	 * 随机分配
	 * @param prescriptionNo
	 */
	void savePrescriptionDistributionRecord(String prescriptionNo);
}
