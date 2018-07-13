package org.beiyi.service.verify;

import java.util.ArrayList;
import java.util.List;

import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.service.BaseJunit4Test;
import org.beiyi.service.verify.impl.ContraindicationVerifyService;
import org.beiyi.service.verify.impl.ContraindicationVerifyService.ContraindicationICD10VerifyResult;
import org.beiyi.service.verify.impl.CourseOfTreatmentVerifyService;
import org.beiyi.service.verify.impl.DDDSVerifyService;
import org.beiyi.service.verify.impl.DosageMaxLimitVerifyService;
import org.beiyi.service.verify.impl.DosageVerifyService;
import org.beiyi.service.verify.impl.DrugNotExistsVerifyService;
import org.beiyi.service.verify.impl.RepeatedPrescriptionsService;
import org.beiyi.service.verify.impl.SexVerifyService;
import org.beiyi.service.verify.impl.ShiYingZhengVerifyService;
import org.beiyi.service.verify.impl.UsageVerifyService;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.PrescriptionReadUtil;
import org.junit.Test;
import org.skynet.frame.util.excel.ExcelBean;
import org.skynet.frame.util.excel.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;

public class DrugVerifyServiceTest  extends BaseJunit4Test{
//	private static Logger logger = Logger.getLogger(DrugVerifyServiceTest.class);
	@Autowired
	DrugNotExistsVerifyService drugNotExistsVerifyService;
	@Autowired
	ShiYingZhengVerifyService shiYingZhengVerifyService;
	@Autowired
	RepeatedPrescriptionsService repeatedPrescriptionsService;
//	@Autowired
//	DrugEffectVerifyService drugEffectVerifyService;
	@Autowired
	SexVerifyService sexVerifyService;
	@Autowired
	ContraindicationVerifyService contraindicationVerifyService;
	@Autowired
	DosageMaxLimitVerifyService dosageMaxLimitVerifyService;
	@Autowired
	DosageVerifyService dosageVerifyService;
	@Autowired
	CourseOfTreatmentVerifyService courseOfTreatmentVerifyService;
	@Autowired
	UsageVerifyService usageVerifyService;
	@Autowired
	DDDSVerifyService dddsVerifyService;
	@Test
	public void testVerify(){
		DrugVerifyService drugVerifyService = new DrugVerifyService();
		List<IDrugVeryfy> drugVerifyServices = new ArrayList<IDrugVeryfy>();
//		drugVerifyServices.add(drugNotExistsVerifyService);

//		drugVerifyServices.add(repeatedPrescriptionsService);
//		drugVerifyServices.add(new DrugEffectVerifyService());
//		drugVerifyServices.add(sexVerifyService);
//		drugVerifyServices.add(dddsVerifyService);
//		drugVerifyServices.add(shiYingZhengVerifyService);
//		drugVerifyServices.add(contraindicationVerifyService);
		
		
//		drugVerifyServices.add(dosageMaxLimitVerifyService);
//		drugVerifyServices.add(dosageVerifyService);
//		drugVerifyServices.add(courseOfTreatmentVerifyService);
//		drugVerifyServices.add(usageVerifyService);
		for (IDrugVeryfy iDrugVeryfy : drugVerifyServices) {
			drugVerifyService.registerDrugVerify(iDrugVeryfy);
		}
		
		List<ChuFang> chuFangList = PrescriptionReadUtil.chuFangList;
		
		List<String> cells = new ArrayList<String>();
		List<List<String>> successValues = new ArrayList<List<String>>();
		List<List<String>> errorValues = new ArrayList<List<String>>();
		cells.addAll(PrescriptionReadUtil.cellsList);
		cells.add("描述");
		for (ChuFang chuFang : chuFangList) {
			VerifyResult result = drugVerifyService.notifyObserver(chuFang);
			String text = result.getResultMsg();
			for (List<String> list : chuFang.getChuFangOldRows()) {
				List<String> subValues = new ArrayList<String>();
				subValues.addAll(list);
				subValues.add("");
				subValues.add(text);
				if(result.isSuccess()){
					successValues.add(subValues);
				}else{
					errorValues.add(subValues);
				}
			}
		}
		List<ExcelBean> excelBeans = new ArrayList<ExcelBean>();
		ExcelBean excelBean = new ExcelBean(cells, successValues, "正确处方.xls");
		excelBeans.add(excelBean);
		excelBean = new ExcelBean(cells, errorValues, "错误处方.xls");
		excelBeans.add(excelBean);
		
		String exportTestResultPath = "D://logs/错误处方模拟_其他测试/";
//		exportTestResultPath = "C://公司/北医三院/错误处方模拟_其他测试/";
		ExcelUtil.export(exportTestResultPath, excelBeans);
	}
	@Test
	public void t(){
		ContraindicationICD10VerifyResult result = contraindicationVerifyService.checkICD10CodeEq("高血压", "高血压", "5");
		System.out.println(result);
	}
}
