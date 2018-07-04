package org.beiyi.controller;

import java.util.HashMap;
import java.util.Map;

import org.beiyi.entity.Drug;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {
	/*@Autowired
	MongoTemplate testMongoTemplate;*/
	/**
	 * 到用户录入界面
	 * 
	 * @return
	 */
	@RequestMapping("/index.htm")
	public ModelAndView index(String id) {
		ModelAndView modelAndView = new ModelAndView("html/index");
		return modelAndView;
	}
	/**
	 * 到用户录入界面
	 * 
	 * @return
	 */
	@RequestMapping("/toInput.htm")
	public ModelAndView toIndex(String id) {
		ModelAndView modelAndView = new ModelAndView("html/drug/index");
		if(!StringUtils.isEmpty(id)){
			modelAndView.addObject("id", id);
		}
		return modelAndView;
	}
	@ResponseBody
	@RequestMapping("/getDrugOne.htm")
	public Map<String, Object> getDrugOne(String id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		/*try {
			if(!StringUtils.isEmpty(id)){
				ObjectId objectId = new ObjectId(id);
				Drug drug = testMongoTemplate.findById(objectId, Drug.class,"bysy_drug_user_input");
//				Criteria criteria = new Criteria("contraindicatedInPregnancy");
//				criteria.is("孕妇禁用标记【孕妇及哺乳期用药】");
//				Query query = new Query();
//				query.addCriteria(criteria);
				resultMap.put("data", drug);
				resultMap.put("msg", "success");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", "error");
		}*/
		return resultMap;
	}
	@ResponseBody
	@RequestMapping("/save.htm")
	public Map<String, Object> save(Drug drug) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		/*try {
			List<BigAdaptationDisease> bigAdaptationDiseases = drug
					.getBigAdaptationDiseases();
			Iterator<BigAdaptationDisease> bigAdaptationDiseaseItr = bigAdaptationDiseases
					.iterator();
			while (bigAdaptationDiseaseItr.hasNext()) {
				BigAdaptationDisease bigAdaptationDisease = bigAdaptationDiseaseItr
						.next();
				List<AdaptationDisease> adaptationDiseases = bigAdaptationDisease
						.getAdaptationDiseases();
				Iterator<AdaptationDisease> adaptationDiseaseItr = adaptationDiseases
						.iterator();
				while (adaptationDiseaseItr.hasNext()) {
					AdaptationDisease adaptationDisease = adaptationDiseaseItr
							.next();
					if (StringUtils.isEmpty(adaptationDisease.getFieldValue())) {
						adaptationDiseaseItr.remove();
					}
				}
			}
			testMongoTemplate.save(drug, "bysy_drug_user_input");
			resultMap.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", "error");
		}*/
		return resultMap;
	}

	@RequestMapping("/toList.htm")
	public String toList() {
		return "html/drug/list";
	}
	
	@ResponseBody
	@RequestMapping("/list.htm")
	public Map<String, Object> list(Drug drug) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		/*try {
			List<Drug> drugs = testMongoTemplate.findAll(Drug.class, "bysy_drug_user_input");
			resultMap.put("data", drugs);
			resultMap.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", "error");
		}*/
		return resultMap;
	}
}
