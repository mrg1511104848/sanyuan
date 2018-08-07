package org.beiyi.service.db.itr;

import java.util.List;

public interface IPrescriptionDistributionRecordService {
	/**
	 * 随机分配
	 * @param prescriptionNo
	 */
	void savePrescriptionDistributionRecord(String prescriptionNo);
	/**
	 * 药师审核情况统计
	 * @param distributionPersonId
	 * @return
	 */
	List<Integer> getDistributionStatistics(String distributionPersonId);
}
