package org.beiyi.service.db.itr;

import java.util.List;
import java.util.Map;

import org.beiyi.entity.db.Section;

public interface ISectionService {
	public Section get(String id);
	public void save(Section section);
	public void delete(String id);
	public List<Section> getPagedList(Map<String, Object> params);
}
