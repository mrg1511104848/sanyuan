package org.beiyi.service.db.itr;

public interface IMysqlDataInitService {
	/**
	 * Icd10 初始化
	 */
	void initIcd10();
	/**
	 * ATCCode 初始化
	 */
	void initAtcCode();
	/**
	 * 说明书 初始化
	 */
	void initInstructions();
	/**
	 * 药品成分初始化
	 */
	void initInstructionComponentAndInstructionComponentAtc();
	/**
	 * 药品与ATCCode关系初始化
	 */
	void initInstructionsAtc();
	/**
	 * ATC之间的冲突初始化
	 */
	void initAtcConflict();
	/**
	 * ATC编码上下级关系初始化
	 */
	void initAtcBelongTo();
	/**
	 * 说明书禁忌症关系初始化
	 */
	void initInstructionContraindication();
	/**
	 * 说明书适应症关系初始化
	 */
	void initInstructionIndication();
	/**
	 * 适应症治疗方案关系初始化
	 */
	void initIndicationTherapeuticRegimen();
	/**
	 * 治疗方案初始化
	 */
	void initTherapeuticRegimen();
	/**
	 * 疾病库初始化
	 */
	void initDisease();
	/**
	 * 疾病ICD10对应表初始化
	 */
	void initDiseaseIcd10();
	/**
	 * ICD10编码关系初始化
	 */
	void initIcd10BelongTo();
}
