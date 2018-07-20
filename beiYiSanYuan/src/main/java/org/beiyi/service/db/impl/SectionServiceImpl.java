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
		return sectionMapper.getPagedList(null);
	}

}
