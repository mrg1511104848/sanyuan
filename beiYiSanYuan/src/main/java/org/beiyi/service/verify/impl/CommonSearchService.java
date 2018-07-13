package org.beiyi.service.verify.impl;

import java.util.List;

import org.beiyi.dao.IndicationTherapeuticRegimenMapper;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.db.IndicationTherapeuticRegimen;
import org.beiyi.entity.db.condition.IndicationTherapeuticRegimenCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonSearchService {
	@Autowired
	IndicationTherapeuticRegimenMapper indicationTherapeuticRegimenMapper;
	public List<IndicationTherapeuticRegimen> getIndicationTherapeuticRegimens(String combinationName,List<String> diagnosises){
		IndicationTherapeuticRegimenCondition condition = new IndicationTherapeuticRegimenCondition();
		DrugCombinationName drugCombinationName = new DrugCombinationName(combinationName);
		condition.setCommodityName(drugCombinationName.getShangPinName());
		condition.setCommonName(drugCombinationName.getTongYongName());
		condition.setIndications(diagnosises);
		
		List<IndicationTherapeuticRegimen> indicationTherapeuticRegimens = indicationTherapeuticRegimenMapper.selectByCondition(condition);
		return indicationTherapeuticRegimens;
	}
}
