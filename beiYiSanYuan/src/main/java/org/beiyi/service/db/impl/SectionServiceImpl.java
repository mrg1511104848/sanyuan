package org.beiyi.service.db.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.dao.SectionMapper;
import org.beiyi.entity.db.Section;
import org.beiyi.service.db.itr.ISectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class SectionServiceImpl implements ISectionService{
	@Autowired
	SectionMapper sectionMapper;
	@Override
	public void save(Section section) {
		if(StringUtils.isBlank(section.getId())){
			sectionMapper.insert(section);
		}else{
			sectionMapper.updateByPrimaryKeySelective(section);
		}
	}

	@Override
	public void delete(String id) {
		sectionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Section> getPagedList(Map<String, Object> params) {
		Section section = new Section();
		if(params!=null){
			if(params.containsKey("sectionName")){
				section.setName(params.get("sectionName").toString());
			}
		}
		return sectionMapper.getPagedList(section);
	}

	@Override
	public Section get(String id) {
		return sectionMapper.selectByPrimaryKey(id);
	}

}
