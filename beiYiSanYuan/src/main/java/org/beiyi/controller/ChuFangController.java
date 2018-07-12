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
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.beiyi.entity.ChuFang;
import org.beiyi.entity.VerifyResult;
import org.beiyi.service.verify.DrugVerifyService;
import org.beiyi.service.verify.impl.ContraindicationVerifyService;
import org.beiyi.service.verify.impl.CourseOfTreatmentVerifyService;
import org.beiyi.service.verify.impl.DDDSVerifyService;
import org.beiyi.service.verify.impl.DosageMaxLimitVerifyService;
import org.beiyi.service.verify.impl.DosageVerifyService;
import org.beiyi.service.verify.impl.DrugEffectVerifyService;
import org.beiyi.service.verify.impl.DrugNotExistsVerifyService;
import org.beiyi.service.verify.impl.RepeatedPrescriptionsService;
import org.beiyi.service.verify.impl.SexVerifyService;
import org.beiyi.service.verify.impl.ShiYingZhengVerifyService;
import org.beiyi.service.verify.impl.UsageVerifyService;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.PrescriptionReadUtil;
import org.beiyi.util.VerifyUtil;
import org.beiyi.util.ZipUtils;
import org.skynet.frame.util.excel.ExcelBean;
import org.skynet.frame.util.excel.ExcelReadUtil;
import org.skynet.frame.util.excel.ExcelUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/chufang")
public class ChuFangController {
	/*@Autowired
	MongoTemplate testMongoTemplate;*/

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
		drugVerifyServices.add(new DrugNotExistsVerifyService());
		drugVerifyServices.add(new RepeatedPrescriptionsService());
		drugVerifyServices.add(new DrugEffectVerifyService());
		drugVerifyServices.add(new SexVerifyService());
		drugVerifyServices.add(new DDDSVerifyService());
		drugVerifyServices.add(new ShiYingZhengVerifyService());
		drugVerifyServices.add(new ContraindicationVerifyService());
		drugVerifyServices.add(new DosageMaxLimitVerifyService());
		drugVerifyServices.add(new DosageVerifyService());
		drugVerifyServices.add(new CourseOfTreatmentVerifyService());
		drugVerifyServices.add(new UsageVerifyService());
		
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
