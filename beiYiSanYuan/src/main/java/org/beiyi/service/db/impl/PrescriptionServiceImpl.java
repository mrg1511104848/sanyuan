package org.beiyi.service.db.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.beiyi.dao.PrescriptionDrugsMapper;
import org.beiyi.dao.PrescriptionVerifyRecordDetailMapper;
import org.beiyi.dao.PrescriptionVerifyRecordHistoryMapper;
import org.beiyi.dao.PrescriptionVerifyRecordMapper;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.db.PrescriptionDrugs;
import org.beiyi.entity.db.PrescriptionVerifyRecord;
import org.beiyi.entity.db.PrescriptionVerifyRecordDetail;
import org.beiyi.entity.db.PrescriptionVerifyRecordHistory;
import org.beiyi.entity.db.pageBean.Prescription;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.service.db.itr.IPrescriptionService;
import org.skynet.frame.util.date.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class PrescriptionServiceImpl implements IPrescriptionService {
	@Autowired
	PrescriptionVerifyRecordMapper prescriptionVerifyRecordMapper;
	@Autowired
	PrescriptionDrugsMapper prescriptionDrugsMapper;
	@Autowired
	PrescriptionVerifyRecordDetailMapper prescriptionVerifyRecordDetailMapper;
	@Autowired
	PrescriptionVerifyRecordHistoryMapper prescriptionVerifyRecordHistoryMapper;
	@Override
	public void save(ChuFang chuFang) throws Exception{
		List<String> diagnosises = chuFang.getDiagnosises();
		StringBuffer diagnosisesBuffer = new StringBuffer();
		for (String diagnosis : diagnosises) {
			diagnosisesBuffer.append(diagnosis+";");
		}
		PrescriptionVerifyRecord prescriptionVerifyRecord = new PrescriptionVerifyRecord();
		prescriptionVerifyRecord.setDiagnosis(diagnosisesBuffer.toString());
		prescriptionVerifyRecord.setPatientBornDate(chuFang.getHuanZhe().getBornDate());
		prescriptionVerifyRecord.setPatientSex(chuFang.getHuanZhe().getSex());
		prescriptionVerifyRecord.setPrescriptionNo(chuFang.getChuFangNo());
		prescriptionVerifyRecord.setUploadTime(new SimpleDateFormat(DateUtil.DATE_FORMAT_01).format(new Date()));
		prescriptionVerifyRecordMapper.insert(prescriptionVerifyRecord);
		
		List<Drug> drugs = chuFang.getDrugs();
		for (Drug drug : drugs) {
			PrescriptionDrugs prescriptionDrugs = new PrescriptionDrugs();
			prescriptionDrugs.setDosage(drug.getDosage());
			prescriptionDrugs.setDosageFrequency(drug.getDosingFrequency());
			prescriptionDrugs.setDosageUnit(drug.getDosageUnit());
//			prescriptionDrugs.setDrugGroup();
			prescriptionDrugs.setDrugName(drug.getDrugCombinationName());
//			prescriptionDrugs.setDrugNo();
//			prescriptionDrugs.setDrugOrder(drugOrder);
			prescriptionDrugs.setDrugQuantity(drug.getDrugQuantity());
			prescriptionDrugs.setDrugQuantityUnit(drug.getDrugQuantityUnit());
			prescriptionDrugs.setForm(drug.getForm());
//			prescriptionDrugs.setHisNo(hisNo);
//			prescriptionDrugs.setMedicalInsuranceCode(medicalInsuranceCode);
//			prescriptionDrugs.setMoney(money);
			prescriptionDrugs.setPack(drug.getPack());
			prescriptionDrugs.setPrescriptionVerifyRecordId(prescriptionVerifyRecord.getId());
//			prescriptionDrugs.setReimbursementMoney(reimbursementMoney);
			prescriptionDrugs.setRouteMedication(drug.getRouteOfMedication());
//			prescriptionDrugs.setSeaRainbowCode(seaRainbowCode);
			prescriptionDrugs.setStandard(drug.getStandard());
			prescriptionDrugsMapper.insert(prescriptionDrugs);
		}
	}
	@Override
	public void updateResult(VerifyResult verifyResult,ChuFang chuFang) {
		String verifyTime =new SimpleDateFormat(DateUtil.DATE_FORMAT_01).format(new Date());
		PrescriptionVerifyRecord prescriptionVerifyRecord = new PrescriptionVerifyRecord();
		prescriptionVerifyRecord.setPrescriptionNo(chuFang.getChuFangNo());
		prescriptionVerifyRecord.setVerifyTime(verifyTime);
		prescriptionVerifyRecord.setVerifyResult(verifyResult.getResultMsg());
		prescriptionVerifyRecord.setVerifyProgress(1);//
		prescriptionVerifyRecord.setVerifyPerson("机器人");
		prescriptionVerifyRecordMapper.updateByPrescriptionNo(prescriptionVerifyRecord);
		
//		PrescriptionVerifyRecord record = new PrescriptionVerifyRecord();
//		record.setPrescriptionNo(chuFang.getChuFangNo());
//		record.setVerifyProgress(1);//
//		record.setVerifyPerson("机器人");
//		this.updateVerifyProgressByPrescriptionNo(record);
		
		PrescriptionVerifyRecordHistory verifyHistory = new PrescriptionVerifyRecordHistory();
		verifyHistory.setPrescriptionNo(chuFang.getChuFangNo());
		verifyHistory.setVerifyPerson("机器人");
		verifyHistory.setVerifyTime(verifyTime);
		verifyHistory.setVerifyProgress(1);
		this.savePrescriptionVerifyRecordHistory(verifyHistory);
	}
	@Override
	public void updateVerifyProgressByPrescriptionNo(
			PrescriptionVerifyRecord record) {
		prescriptionVerifyRecordMapper.updateVerifyProgressByPrescriptionNo(record);
	}
	@Override
	public List<PrescriptionVerifyRecord> getPagedList(
			Map<String, Object> params) {
		return prescriptionVerifyRecordMapper.getPagedList(null);
	}
	@Override
	public List<Prescription> getPrescriptionPagedList(
			Map<String, Object> params) {
		return prescriptionVerifyRecordMapper.getPrescriptionPagedList();
	}
	@Override
	public List<PrescriptionDrugs> getPrescriptionDrugsList(
			Map<String, Object> params) {
		PrescriptionDrugs condition = new PrescriptionDrugs();
		String id = params.get("id").toString();
		condition.setPrescriptionVerifyRecordId(id);
		return prescriptionDrugsMapper.getPagedList(condition);
	}
	@Override
	public PrescriptionVerifyRecord getById(String prescriptionVerifyRecordId) {
		return prescriptionVerifyRecordMapper.selectByPrimaryKey(prescriptionVerifyRecordId);
	}
	@Override
	public void savePrescriptionVerifyRecordDetail(
			PrescriptionVerifyRecordDetail prescriptionVerifyRecordDetail) {
		prescriptionVerifyRecordDetailMapper.insert(prescriptionVerifyRecordDetail);
	}
	@Override
	public List<PrescriptionVerifyRecordDetail> getPrescriptionVerifyRecordDetailPagedList(
			Map<String, Object> params) {
		return prescriptionVerifyRecordDetailMapper.getPagedList(params.get("prescriptionNo").toString());
	}
	@Override
	public void savePrescriptionVerifyRecordHistory(
			PrescriptionVerifyRecordHistory record) {
		prescriptionVerifyRecordHistoryMapper.insertSelective(record);
	}
	@Override
	public void insistSubmit(PrescriptionVerifyRecordHistory record) {
		record.setVerifyTime(new SimpleDateFormat(DateUtil.DATE_FORMAT_01).format(new Date()));
		
		savePrescriptionVerifyRecordHistory(record);
		
		PrescriptionVerifyRecord verifyRecord = new PrescriptionVerifyRecord();
		verifyRecord.setPrescriptionNo(record.getPrescriptionNo());
		verifyRecord.setVerifyTime(record.getVerifyTime());
		verifyRecord.setVerifyPerson(record.getVerifyPerson());
		verifyRecord.setVerifyPersonUniqueNo(record.getVerifyPersonUniqueNo());
		verifyRecord.setVerifyProgress(record.getVerifyProgress());
		updateVerifyProgressByPrescriptionNo(verifyRecord);
	}
	@Override
	public int getCountByPrescriptionNo(String prescriptionNo){
		return prescriptionVerifyRecordMapper.getCountByPrescriptionNo(prescriptionNo);
	}
}
