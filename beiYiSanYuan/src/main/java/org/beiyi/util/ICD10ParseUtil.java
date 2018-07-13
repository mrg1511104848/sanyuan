package org.beiyi.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.beiyi.entity.verify.ICD10;
import org.bson.Document;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.mongo.MongoUtil;

public class ICD10ParseUtil {
	private static Logger log = Logger.getLogger(ICD10ParseUtil.class);
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
//			System.err.println(icd10DiseaseName);
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
	/**
	 * 根据疾病名称获取相关的icd10标准
	 * @param diseaseName
	 * @return
	 */
	public static ICD10 getIcd10ByCode(String icd10Code,String version){
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put( "code", icd10Code);
		if (StringUtils.isNotBlank(version)) {
			filter.put("version", version);
		}
		Document icd10Doc = MongoUtil.findOne("wechat_icd", filter);
		if(icd10Doc==null){
//			log.warn(String.format("未找到关于[icd10Code]%s [version]%s 的ICD10", icd10Code,version));
			return null;
		}
		String name = icd10Doc.getString("name");
		String nameEn = icd10Doc.getString("nameEn");
		String code = icd10Doc.getString("code");
		String v = icd10Doc.getString("version");
		ICD10 icd10 = new ICD10(code,name,nameEn,v);
		return icd10;
	}
	/**
	 * 根据疾病名称获取相关的icd10标准
	 * @param diseaseName
	 * @return
	 */
	public static List<ICD10> getIcd10ListByDiseaseName(String diseaseName,String version){
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put( "name", diseaseName);
		if (StringUtils.isNotBlank(version)) {
			filter.put("version", version);
		}
		List<Document> matchDocs = MongoUtil.findDocList("wechat_icd",filter);
		if(matchDocs == null || matchDocs.size()==0){
			log.warn(String.format("未找到关于[diseaseName]%s [version]%s 的ICD10", diseaseName,version));
			return null;
		}
		List<ICD10> icd10List = new ArrayList<ICD10>();
		for (Document icd10Doc : matchDocs) {
			String name = icd10Doc.getString("name");
			String nameEn = icd10Doc.getString("nameEn");
			String code = icd10Doc.getString("code");
			String v = icd10Doc.getString("version");
			ICD10 icd10 = new ICD10(code,name,nameEn,v);
			icd10List.add(icd10);
		}
		return icd10List;
	}
	/**
	 * 根据疾病名称获取相关的icd10标准
	 * @param diseaseName
	 * @return
	 */
	public static List<ICD10> getIcd10ListByDiseaseNameMysql(String diseaseName,String version){
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put( "name", diseaseName);
		if (StringUtils.isNotBlank(version)) {
			filter.put("version", version);
		}
		List<Document> matchDocs = MongoUtil.findDocList("wechat_icd",filter);
		if(matchDocs == null || matchDocs.size()==0){
			log.warn(String.format("未找到关于[diseaseName]%s [version]%s 的ICD10", diseaseName,version));
			return null;
		}
		List<ICD10> icd10List = new ArrayList<ICD10>();
		for (Document icd10Doc : matchDocs) {
			String name = icd10Doc.getString("name");
			String nameEn = icd10Doc.getString("nameEn");
			String code = icd10Doc.getString("code");
			String v = icd10Doc.getString("version");
			ICD10 icd10 = new ICD10(code,name,nameEn,v);
			icd10List.add(icd10);
		}
		return icd10List;
	}
	/**
	 * 根据疾病名称获取相关的icd10标准
	 * @param diseaseName
	 * @return
	 */
	public static ICD10 getIcd10ByCodeMysql(String icd10Code,String version){
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put( "code", icd10Code);
		if (StringUtils.isNotBlank(version)) {
			filter.put("version", version);
		}
		Document icd10Doc = MongoUtil.findOne("wechat_icd", filter);
		if(icd10Doc==null){
//			log.warn(String.format("未找到关于[icd10Code]%s [version]%s 的ICD10", icd10Code,version));
			return null;
		}
		String name = icd10Doc.getString("name");
		String nameEn = icd10Doc.getString("nameEn");
		String code = icd10Doc.getString("code");
		String v = icd10Doc.getString("version");
		ICD10 icd10 = new ICD10(code,name,nameEn,v);
		return icd10;
	}
	/**
	 * 根据疾病名称获取相关的icd10标准
	 * @param diseaseName
	 * @return
	 */
	public static List<ICD10> getIcd10ListByDiseaseName(String diseaseName){
		return getIcd10ListByDiseaseNameMysql(diseaseName, null);
	}
	public static ICD10 getIcd10ByCode(String icd10Code) {
		return getIcd10ByCodeMysql(icd10Code, null);
	}
}
