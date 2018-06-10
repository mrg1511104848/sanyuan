package org.beiyi.entity;

import java.util.List;

/**
 * 药品标准类
 * 
 * @author 2bu
 *
 */
public class Drug {
	private String id;
	private String tongYongName;// 通用名称
	private String shangPinName;// 商品名称
	private String enName;// 英文名称
	private String preparation;// 剂型
	private String mainComponent;// 主成分
	private String accessories;// 辅料
	private String character;// 性状
	private String specification;// 规格
	private String classification;// 分类
	private String otc;// 是否etc
	private String medicareType;// 医保类型
	private String standard;// 执行标准
	private String approveCode;// 批准文号
	private String companyName;// 生产企业
	private String approveDate;// 核准日期
	private String modifyDate;// 修改日期
	private List<BigAdaptationDisease> bigAdaptationDiseases; // 适应症
	private String disableDisease;// 【禁用-疾病】
	private String disableSpecialCrowd;// 【禁用-特殊人群】
	private String disableIrritability;// 【禁用-过敏】
	private String disableCombinedDrug;// 【禁用-合并药物】
	private String cautionDisease;// 【慎用-疾病】
	private String cautionGuidance;// 【医生指导下使用】
	private String contraindicatedInPregnancy;// 【孕妇禁用标记】
	private String fdaPregnancyDrugClassification;// 【FDA妊娠药物分级】
	private String disableLactation;// 【哺乳期禁用标记】
	private String lactationDrugLevel;// 【哺乳期药物分级】
	private String contraindicated;// 【contraindicated】
	private String major;// 【major】

	


	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTongYongName() {
		return tongYongName;
	}

	public void setTongYongName(String tongYongName) {
		this.tongYongName = tongYongName;
	}

	public String getShangPinName() {
		return shangPinName;
	}

	public void setShangPinName(String shangPinName) {
		this.shangPinName = shangPinName;
	}

	public String getEnName() {
		return enName;
	}

	public void setEnName(String enName) {
		this.enName = enName;
	}

	public String getPreparation() {
		return preparation;
	}

	public void setPreparation(String preparation) {
		this.preparation = preparation;
	}

	public String getMainComponent() {
		return mainComponent;
	}

	public void setMainComponent(String mainComponent) {
		this.mainComponent = mainComponent;
	}

	public String getAccessories() {
		return accessories;
	}

	public void setAccessories(String accessories) {
		this.accessories = accessories;
	}

	public String getCharacter() {
		return character;
	}

	public void setCharacter(String character) {
		this.character = character;
	}

	public String getSpecification() {
		return specification;
	}

	public void setSpecification(String specification) {
		this.specification = specification;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getOtc() {
		return otc;
	}

	public void setOtc(String otc) {
		this.otc = otc;
	}

	public String getMedicareType() {
		return medicareType;
	}

	public void setMedicareType(String medicareType) {
		this.medicareType = medicareType;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getApproveCode() {
		return approveCode;
	}

	public void setApproveCode(String approveCode) {
		this.approveCode = approveCode;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getApproveDate() {
		return approveDate;
	}

	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public List<BigAdaptationDisease> getBigAdaptationDiseases() {
		return bigAdaptationDiseases;
	}

	public void setBigAdaptationDiseases(
			List<BigAdaptationDisease> bigAdaptationDiseases) {
		this.bigAdaptationDiseases = bigAdaptationDiseases;
	}

	public String getDisableDisease() {
		return disableDisease;
	}

	public void setDisableDisease(String disableDisease) {
		this.disableDisease = disableDisease;
	}

	public String getDisableSpecialCrowd() {
		return disableSpecialCrowd;
	}

	public void setDisableSpecialCrowd(String disableSpecialCrowd) {
		this.disableSpecialCrowd = disableSpecialCrowd;
	}

	public String getDisableIrritability() {
		return disableIrritability;
	}

	public void setDisableIrritability(String disableIrritability) {
		this.disableIrritability = disableIrritability;
	}

	public String getDisableCombinedDrug() {
		return disableCombinedDrug;
	}

	public void setDisableCombinedDrug(String disableCombinedDrug) {
		this.disableCombinedDrug = disableCombinedDrug;
	}

	public String getCautionDisease() {
		return cautionDisease;
	}

	public void setCautionDisease(String cautionDisease) {
		this.cautionDisease = cautionDisease;
	}

	public String getCautionGuidance() {
		return cautionGuidance;
	}

	public void setCautionGuidance(String cautionGuidance) {
		this.cautionGuidance = cautionGuidance;
	}

	public String getContraindicatedInPregnancy() {
		return contraindicatedInPregnancy;
	}

	public void setContraindicatedInPregnancy(String contraindicatedInPregnancy) {
		this.contraindicatedInPregnancy = contraindicatedInPregnancy;
	}

	public String getFdaPregnancyDrugClassification() {
		return fdaPregnancyDrugClassification;
	}

	public void setFdaPregnancyDrugClassification(
			String fdaPregnancyDrugClassification) {
		this.fdaPregnancyDrugClassification = fdaPregnancyDrugClassification;
	}

	public String getDisableLactation() {
		return disableLactation;
	}

	public void setDisableLactation(String disableLactation) {
		this.disableLactation = disableLactation;
	}

	public String getLactationDrugLevel() {
		return lactationDrugLevel;
	}

	public void setLactationDrugLevel(String lactationDrugLevel) {
		this.lactationDrugLevel = lactationDrugLevel;
	}

	public String getContraindicated() {
		return contraindicated;
	}

	public void setContraindicated(String contraindicated) {
		this.contraindicated = contraindicated;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}
}
