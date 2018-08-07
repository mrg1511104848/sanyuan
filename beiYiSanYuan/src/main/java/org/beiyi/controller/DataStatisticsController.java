package org.beiyi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.beiyi.controller.base.WebUtils;
import org.beiyi.service.db.itr.IPrescriptionDistributionRecordService;
import org.beiyi.service.db.itr.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/dataStatistics")
public class DataStatisticsController {
	@Autowired
	private IPrescriptionDistributionRecordService prescriptionDistributionRecordService;
	@RequestMapping("/statistics.htm")
	@ResponseBody
	public JSONObject loginOut(HttpSession httpSession) {
		Map<String, Object> data = new HashMap<String, Object>();
		String distributionPersonId = null;
		List<Integer> distributionStatistics = prescriptionDistributionRecordService.getDistributionStatistics(distributionPersonId);
		return WebUtils.createSuccResult(data);
	}
}
