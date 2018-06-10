package org.beiyi.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.beiyi.entity.ChuFang;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/chufang")
public class ChuFangController {
	@Autowired
	MongoTemplate testMongoTemplate;

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
		String[] keywords = chuFang.getDiseaseKeyword().split(" ");
		String drugName = chuFang.getDrugName();

		StringBuffer diseasePtn = new StringBuffer();
		for (String k : keywords) {
			diseasePtn.append(".*" + k + ".*|");
		}
		String strDiseasePtn = diseasePtn.substring(0, diseasePtn.length() - 1);

		Criteria criteria = Criteria.where("drugName").regex(".*" +drugName+ ".*");
		Criteria criteria1 = Criteria.where("disease").regex(strDiseasePtn);
		Query query = new Query();
		query.addCriteria(criteria);
		query.addCriteria(criteria1);
		List<ChuFang> chufangList = testMongoTemplate.find(query,
				ChuFang.class, "bysy_chufang_drug_disease");
		StringBuffer resultBuffer = new StringBuffer();
		for (ChuFang c : chufangList) {
			resultBuffer.append(c.getDrugName());
			resultBuffer.append(" ");
			resultBuffer.append(c.getDisease());
			resultBuffer.append("\r\n");
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", String
				.format("attachment; filename=\"" + "prescription.txt" + "\""));
		ServletOutputStream out = response.getOutputStream();
		out.write(resultBuffer.toString().getBytes());
		out.close();
	}
}
