package org.beiyi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.beiyi.controller.base.WebUtils;
import org.beiyi.entity.db.PrescriptionDrugs;
import org.beiyi.entity.db.PrescriptionVerifyRecord;
import org.beiyi.entity.db.PrescriptionVerifyRecordDetail;
import org.beiyi.entity.db.PrescriptionVerifyRecordHistory;
import org.beiyi.service.db.itr.IPrescriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

@Controller
@RequestMapping("/prescription")
public class PrescriptionController {
	@Autowired
	IPrescriptionService prescriptionService;

	@RequestMapping("/listProcessed.htm")
	public ModelAndView listProcessed() {
		ModelAndView modelAndView = new ModelAndView("html/ajax/list-processed");
		return modelAndView;
	}

	@RequestMapping("/mechineListProcessed.htm")
	public ModelAndView mechineListProcessed(String verifyProgressStr) {
		ModelAndView modelAndView = new ModelAndView(
				"html/ajax/mechine-list-processed");
		modelAndView.addObject("verifyProgressStr", verifyProgressStr);
		return modelAndView;
	}

	@RequestMapping("/prescriptionDetail.htm")
	public ModelAndView detail(String prescriptionVerifyRecordId) {
		ModelAndView modelAndView = new ModelAndView(
				"html/ajax/modal-content/prescription-detail");
		return modelAndView;
	}

	@RequestMapping("/getPrescriptionDetail.htm")
	@ResponseBody
	public Map<Object, Object> getPrescriptionDetail(
			String prescriptionVerifyRecordId) {
		Map<Object, Object> object = new HashMap<Object, Object>();
		PrescriptionVerifyRecord prescriptionVerifyRecord = prescriptionService
				.getById(prescriptionVerifyRecordId);
		object.put("resultBean", prescriptionVerifyRecord);
		return object;
	}

	@RequestMapping(value = "/getPrescriptionPagedList")
	@ResponseBody
	public Map<Object, Object> getPrescriptionPagedList(
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam Map<String, Object> params) {
		try {
			// User currentUser =
			// (User)request.getSession().getAttribute("currentUser");''
			// if(currentUser.getIsAdmin()==null||currentUser.getIsAdmin()!=1){
			// params.put("eq_userId", currentUser.getId());
			// }
			int length = Integer.parseInt(params.get("iDisplayLength")
					.toString());
			int start = Integer
					.parseInt(params.get("iDisplayStart").toString())
					/ length
					+ 1;
			Page page = PageHelper.startPage(start, length, true);
			List<PrescriptionVerifyRecord> list = prescriptionService
					.getPagedList(params);
			Map<Object, Object> object = new HashMap<Object, Object>();
			object.put("iTotalRecords", page.getTotal());
			object.put("iTotalDisplayRecords", page.getTotal());
			object.put("aaData", list);
			return object;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/getPrescriptionDrugsList")
	@ResponseBody
	public Map<Object, Object> getPrescriptionDrugsList(
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam Map<String, Object> params) {
		try {
			// User currentUser =
			// (User)request.getSession().getAttribute("currentUser");''
			// if(currentUser.getIsAdmin()==null||currentUser.getIsAdmin()!=1){
			// params.put("eq_userId", currentUser.getId());
			// }
			int length = Integer.parseInt(params.get("iDisplayLength")
					.toString());
			int start = Integer
					.parseInt(params.get("iDisplayStart").toString())
					/ length
					+ 1;
			Page page = PageHelper.startPage(start, length, true);
			List<PrescriptionDrugs> list = prescriptionService
					.getPrescriptionDrugsList(params);
			Map<Object, Object> object = new HashMap<Object, Object>();
			object.put("iTotalRecords", page.getTotal());
			object.put("iTotalDisplayRecords", page.getTotal());
			object.put("aaData", list);
			return object;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/getPrescriptionVerifyRecordDetailPagedList.htm")
	@ResponseBody
	public Map<Object, Object> getPrescriptionVerifyRecordDetailPagedList(
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam Map<String, Object> params) {
		try {
			// User currentUser =
			// (User)request.getSession().getAttribute("currentUser");''
			// if(currentUser.getIsAdmin()==null||currentUser.getIsAdmin()!=1){
			// params.put("eq_userId", currentUser.getId());
			// }
			int length = Integer.parseInt(params.get("iDisplayLength")
					.toString());
			int start = Integer
					.parseInt(params.get("iDisplayStart").toString())
					/ length
					+ 1;
			Page page = PageHelper.startPage(start, length, true);
			List<PrescriptionVerifyRecordDetail> list = prescriptionService
					.getPrescriptionVerifyRecordDetailPagedList(params);
			Map<Object, Object> object = new HashMap<Object, Object>();
			object.put("iTotalRecords", page.getTotal());
			object.put("iTotalDisplayRecords", page.getTotal());
			object.put("aaData", list);
			return object;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping("/verify.htm")
	@ResponseBody
	public JSONObject verify(
			PrescriptionVerifyRecordHistory record) {
		try {
			prescriptionService.changeVerifyHistory(record);
			return WebUtils.createSuccResult();
		} catch (Exception e) {
			e.printStackTrace();
			return WebUtils.createErrorResult();
		}
	}
	
}
