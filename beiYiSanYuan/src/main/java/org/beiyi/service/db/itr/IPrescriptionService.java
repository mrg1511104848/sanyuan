package org.beiyi.service.db.itr;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.db.PrescriptionDrugs;
import org.beiyi.entity.db.PrescriptionVerifyRecord;
import org.beiyi.entity.db.PrescriptionVerifyRecordDetail;
import org.beiyi.entity.db.pageBean.Prescription;
import org.beiyi.entity.verify.ChuFang;

/**
 * 处方service
 * @author 2bu
 *
 */
public interface IPrescriptionService {
	public void save(ChuFang chuFang);
	public void updateResult(VerifyResult verifyResult,ChuFang chuFang);
	public void updateVerifyProgressByPrescriptionNo(PrescriptionVerifyRecord record);
	public List<PrescriptionVerifyRecord> getPagedList(
			Map<String, Object> params);
	public List<Prescription> getPrescriptionPagedList(
			Map<String, Object> params);
	public List<PrescriptionDrugs> getPrescriptionDrugsList(
			Map<String, Object> params);
	public PrescriptionVerifyRecord getById(String prescriptionVerifyRecordId);
	public void savePrescriptionVerifyRecordDetail(PrescriptionVerifyRecordDetail prescriptionVerifyRecordDetail);
	
	public List<PrescriptionVerifyRecordDetail> getPrescriptionVerifyRecordDetailPagedList(Map<String, Object> params);
}
