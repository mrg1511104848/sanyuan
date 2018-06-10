package org.beiyi.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * 适应症综合的一个类
 * 
 * @author 2bu
 *
 */
public class BigAdaptationDisease {
	private List<AdaptationDisease> adaptationDiseases = new ArrayList<AdaptationDisease>();

	public List<AdaptationDisease> getAdaptationDiseases() {
		return adaptationDiseases;
	}

	public void setAdaptationDiseases(List<AdaptationDisease> adaptationDiseases) {
		this.adaptationDiseases = adaptationDiseases;
	}

}
