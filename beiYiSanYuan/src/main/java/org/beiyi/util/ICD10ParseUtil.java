package org.beiyi.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.skynet.frame.util.RegexUtils;

public class ICD10ParseUtil {
	/**
	 * 根据icd10疾病名称，自动转换 缓解疼痛(骨探查剂) -> [缓解疼痛, 骨探查剂]
	 * 
	 * @param icd10DiseaseName
	 * @return
	 */
	public static List<String> getDiseaseNames(String icd10DiseaseName) {
		if(StringUtils.isBlank(icd10DiseaseName)) return null;
		String icdDiseaseNameAllRegex = "([^（\\(]+)([\\(（].+?[）\\)])?";
		String icdDiseaseSimilarNameAllRegex = "([^（\\(]+)[\\(（](.+?)[）\\)]";
		List<String> allDiseaseNameList = new ArrayList<String>();
		List<String> diseaseByRegex = RegexUtils.getByGroup(icdDiseaseNameAllRegex,
				icd10DiseaseName, 1);
		String oldDisease = null;
		if(diseaseByRegex.size()>0){
			oldDisease = diseaseByRegex.get(0);
		}else{
			System.err.println(icd10DiseaseName);
		}
		oldDisease = diseaseByRegex.get(0);
		List<String> similarDiseaseByRegex = RegexUtils.getByGroup(
				icdDiseaseSimilarNameAllRegex, icd10DiseaseName, 2);
		String similarDisease = null;
		if(similarDiseaseByRegex.size()>0){
			similarDisease = similarDiseaseByRegex.get(0);
		}
		List<String> similarDiseases = new ArrayList<String>();
		if (StringUtils.isNotBlank(similarDisease)) {
			String[] similarDiseaseArr = similarDisease.split("、|。|;");
			for (String similarDiseaseEach : similarDiseaseArr) {
				if (StringUtils.isNotBlank(similarDiseaseEach))
					similarDiseases.add(similarDiseaseEach);
			}
		}
		allDiseaseNameList.add(oldDisease);
		allDiseaseNameList.addAll(similarDiseases);
		return allDiseaseNameList;
	}
}
