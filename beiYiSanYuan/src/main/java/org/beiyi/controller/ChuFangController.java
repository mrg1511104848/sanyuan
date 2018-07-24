package org.beiyi.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.lang3.StringUtils;
import org.beiyi.changliang.VerifyProgressEnum;
import org.beiyi.controller.base.ResponseEnum;
import org.beiyi.controller.base.WebUtils;
import org.beiyi.entity.ChuFang;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.db.PrescriptionVerifyRecordDetail;
import org.beiyi.entity.db.PrescriptionVerifyRecordHistory;
import org.beiyi.entity.db.Section;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.service.db.itr.IPrescriptionService;
import org.beiyi.service.verify.DrugVerifyService;
import org.beiyi.service.verify.impl.ContraindicationVerifyService;
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
import org.beiyi.util.VerifyUtil;
import org.beiyi.util.ZipUtils;
import org.skynet.frame.util.excel.ExcelBean;
import org.skynet.frame.util.excel.ExcelReadUtil;
import org.skynet.frame.util.excel.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

@Controller
@RequestMapping("/chufang")
public class ChuFangController {
	/*@Autowired
	MongoTemplate testMongoTemplate;*/
	
	@Autowired
	IPrescriptionService prescriptionService;
	
	
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

	/**
	 * 1.根据提供的关键词和药品名称，到两周处方中查找对应的疾病的功能
	 * 
	 * @return
	 */
	@RequestMapping("/toSearch.htm")
	public ModelAndView toSearch() {
		ModelAndView modelAndView = new ModelAndView("html/chufang/index");
		return modelAndView;
	}

	/**
	 * 1.根据提供的关键词和药品名称，到两周处方中查找对应的疾病的功能
	 * 
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/search.htm")
	public void search(ChuFang chuFang, HttpServletResponse response)
			throws IOException {
	}
	/**
	 * 去处方审核界面
	 * 
	 * @return
	 */
	@RequestMapping("/toVerify.htm")
	public ModelAndView toVerify() {
		ModelAndView modelAndView = new ModelAndView("html/chufang/verify");
		return modelAndView;
	}
	
	/**
	 * 处方审核
	 * 
	 * @return
	 * @throws Exception 
	 * @throws RuntimeException 
	 */
	@RequestMapping("/verify.htm")
	public void verify(HttpServletRequest request,HttpServletResponse response,@RequestParam("file") CommonsMultipartFile file){
		//如果文件不为空，写入上传路径
		InputStream is = null;
        if(!file.isEmpty()) {
            try {
				DiskFileItem fi = (DiskFileItem)file.getFileItem(); 
				List<List<String>> records = ExcelReadUtil.getRecords(fi.getInputStream());
				List<org.beiyi.entity.verify.ChuFang> chuFangList = VerifyUtil.read2ChuFangList(records);
				
				for (org.beiyi.entity.verify.ChuFang cf : chuFangList) {
					prescriptionService.save(cf);
				}
				
				List<String> titles = records.get(0);
				String[] exportZipFilePathInfo = verify(request,titles,chuFangList);
				
		        this.downloadFile(new File(exportZipFilePathInfo[0]), response, true);
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				if(is!=null){
					try {
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
        } else {
        }
	}
	
	@RequestMapping(value = "/insistSubmit.htm")
	@ResponseBody
	public JSONObject insistSubmit(HttpServletResponse response,
			HttpServletRequest request, PrescriptionVerifyRecordHistory record) {
		try {
			// User currentUser =
			// (User)request.getSession().getAttribute("currentUser");''
			// if(currentUser.getIsAdmin()==null||currentUser.getIsAdmin()!=1){
			// params.put("eq_userId", currentUser.getId());
			// }
			int prescriptionCount = prescriptionService.getCountByPrescriptionNo(record.getPrescriptionNo());
			if(prescriptionCount == 0){
				return WebUtils.createErrorResult(ResponseEnum.INVALID_PARAMS, "该处方不存在");
			}
			if(StringUtils.isBlank(record.getVerifyPerson())){
				return WebUtils.createErrorResult(ResponseEnum.INVALID_PARAMS, "药师姓名不能为空");
			}
			if(StringUtils.isBlank(record.getVerifyPersonUniqueNo())){
				return WebUtils.createErrorResult(ResponseEnum.INVALID_PARAMS, "药师唯一编码不能为空");
			}
			record.setVerifyProgress(VerifyProgressEnum.INSISTSUBMIT_UN_AUDITED);
			prescriptionService.insistSubmit(record);
			return WebUtils.createSuccResult();
		} catch (Exception e) {
			e.printStackTrace();
			return WebUtils.createErrorResult();
		}
	}
	
	public void downloadFile(File file,HttpServletResponse response,boolean isDelete) {
        try {
            // 以流的形式下载文件。
            BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file.getPath()));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + new String(file.getName().getBytes("UTF-8"),"ISO-8859-1"));
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
            if(isDelete)
            {
                file.delete();        //是否将生成的服务器端文件删除
            }
         } 
         catch (IOException ex) {
            ex.printStackTrace();
        }
    } 
	private String[] verify(HttpServletRequest request,List<String> titles,List<org.beiyi.entity.verify.ChuFang> chuFangList) throws RuntimeException, Exception{
		DrugVerifyService drugVerifyService = new DrugVerifyService();
		List<IDrugVeryfy> drugVerifyServices = new ArrayList<IDrugVeryfy>();
		drugVerifyServices.add(drugNotExistsVerifyService);
		drugVerifyServices.add(repeatedPrescriptionsService);
//		drugVerifyServices.add(new DrugEffectVerifyService());
		drugVerifyServices.add(sexVerifyService);
		drugVerifyServices.add(dddsVerifyService);
		drugVerifyServices.add(shiYingZhengVerifyService);
		drugVerifyServices.add(contraindicationVerifyService);
		drugVerifyServices.add(dosageMaxLimitVerifyService);
		drugVerifyServices.add(dosageVerifyService);
		drugVerifyServices.add(courseOfTreatmentVerifyService);
		drugVerifyServices.add(usageVerifyService);
		
		for (IDrugVeryfy iDrugVeryfy : drugVerifyServices) {
			drugVerifyService.registerDrugVerify(iDrugVeryfy);
		}
		
		List<String> cells = new ArrayList<String>();
		List<List<String>> successValues = new ArrayList<List<String>>();
		List<List<String>> errorValues = new ArrayList<List<String>>();
		cells.addAll(titles);
		cells.add("描述");
		for (org.beiyi.entity.verify.ChuFang chuFang : chuFangList) {
			VerifyResult result = drugVerifyService.notifyObserver(chuFang);
			String text = result.getResultMsg();
			List<DrugVerifyInfo> errorDrugs = result.getErrorDrugs();
			for (DrugVerifyInfo errDrug : errorDrugs) {
				PrescriptionVerifyRecordDetail prescriptionVerifyRecordDetail = new PrescriptionVerifyRecordDetail();
				prescriptionVerifyRecordDetail.setPrescriptionNo(chuFang.getChuFangNo());
				prescriptionVerifyRecordDetail.setErrorDesc(errDrug.getErrMessage());
				prescriptionVerifyRecordDetail.setDrugName(errDrug.getDrug().getDrugCombinationName());
				prescriptionService.savePrescriptionVerifyRecordDetail(prescriptionVerifyRecordDetail);
			}
			prescriptionService.updateResult(result, chuFang);
			
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
		
		String chufangsExportPath = request.getServletContext().getRealPath(File.separator+"chufangs_export");
		String currDate = new SimpleDateFormat(org.skynet.frame.util.date.DateUtil.DATE_FORMAT_07).format(new Date());
		String basePath = chufangsExportPath+File.separator+currDate;
		File basePathCheck = new File(basePath+File.separator);
		if(!basePathCheck.exists()) {
			basePathCheck.mkdirs();
		}
        ExcelUtil.export(basePath+File.separator, excelBeans);
        
        String exportZipFileName = chufangsExportPath+File.separator+currDate+".zip";
        ZipUtils.toZip(basePath, exportZipFileName, true);
        
		return new String[]{basePath+".zip",currDate+".zip"};
	}
}
