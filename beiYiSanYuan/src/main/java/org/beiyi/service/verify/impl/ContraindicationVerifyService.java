package org.beiyi.service.verify.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.ICD10;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.reource.BysyConfig;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.ICD10ParseUtil;
import org.beiyi.util.VerifyUtil;

/**
 * 禁忌症审核
 * 
 * @author 2bu
 *
 */
public class ContraindicationVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
//		Set<Drug> notExistsDrugs = new HashSet<Drug>();

		List<String> chuFangAlldiagnosises = chuFang.getDiagnosises();

		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行审核
		for (int i = 0; i < chuFangDrugVerifingList.size(); i++) {
			Drug chuFangDrug = chuFangDrugVerifingList.get(i);
			Instruction instruction = VerifyUtil
					.getInstructionOfChuFangDrug(chuFangDrug);
//			if (instruction == null) {// 药品不存在于说明书
//				notExistsDrugs.add(chuFangDrug);
//				continue;
//			}

			List<String> instructionContraindications = instruction
					.getContraindications();
			Set<String> contraindicationEntirelyEqResult = compareContraindicationEntirelyEq(
					instructionContraindications, chuFangAlldiagnosises);

			if (VerifyUtil.chuFangDrugContainsInVerifyResultErrorDrugs(verifyResult,
					chuFangDrug)) {
				continue;
			}
			if (contraindicationEntirelyEqResult != null
					&& contraindicationEntirelyEqResult.size() > 0) {
				errMsgBuffer.append("药品 "
						+ chuFangDrug.getDrugCombinationName() + " ");
				for (String entirelyEq : contraindicationEntirelyEqResult) {
					errMsgBuffer.append(String.format("禁用于 “%s” 疾病/特殊人群 ；",
							entirelyEq));
				}
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult,
						chuFangDrug, VerifyTypeEnums.CONTRAINDICATIONS);
			} else {
				Set<ContraindicationICD10VerifyResult> contraindicationICD10MatchResult = compareContraindicationICD10Match(
						instructionContraindications, chuFangAlldiagnosises);
				if (contraindicationICD10MatchResult != null
						&& contraindicationICD10MatchResult.size() > 0) {
					errMsgBuffer.append("药品 "
							+ chuFangDrug.getDrugCombinationName() + " ");
					for (ContraindicationICD10VerifyResult iCD10Match : contraindicationICD10MatchResult) {
						errMsgBuffer.append(String.format(
								"禁用于 “%s(ICD10:%s)” 疾病/特殊人群 ；",
								iCD10Match.getDiseaseName(),
								iCD10Match.getIcd10Code()));
					}
					VerifyUtil.addErrorDrugToVerifyResult(verifyResult,
							chuFangDrug, VerifyTypeEnums.CONTRAINDICATIONS);
				}
			}
		}
//		VerifyUtil.addNotExistsDrugToVerifyResult(verifyResult, notExistsDrugs,
//				errMsgBuffer);
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}

	/**
	 * 判断处方中的适应症的icd10前几位
	 * 是否与药品对应于说明书中的禁忌症的icd10前几位相匹配。如果匹配，返回所有匹配项，代表处方的这些匹配到的适应症是禁忌的。
	 * 
	 * @param instructionContraindications
	 * @param chuFangAlldiagnosises
	 * @return
	 */
	private Set<ContraindicationICD10VerifyResult> compareContraindicationICD10Match(
			List<String> instructionContraindications,
			List<String> chuFangAlldiagnosises) {
		Set<ContraindicationICD10VerifyResult> contraindicationICD10VerifyResults = new HashSet<ContraindicationICD10VerifyResult>();
		if(instructionContraindications == null || chuFangAlldiagnosises == null){
			return null;
		}
		// TODO 判断处方中的适应症的icd10前几位
		// 是否与药品对应于说明书中的禁忌症的icd10前几位相匹配。如果匹配，返回所有匹配项，代表处方的这些匹配到的适应症是禁忌的。
		for (String chuFangDiagnosis : chuFangAlldiagnosises) {
			if(StringUtils.isBlank(chuFangDiagnosis)) continue;
			chuFangDiagnosis = chuFangDiagnosis.trim();
			
			for (String instructionContraindication : instructionContraindications) {
				if(StringUtils.isBlank(instructionContraindication)) continue;
				instructionContraindication = instructionContraindication
						.trim();
				ContraindicationICD10VerifyResult contraindicationICD10VerifyResult = checkICD10CodeEq(
						chuFangDiagnosis, instructionContraindication,
						BysyConfig.getConfig("icd10_len_to_verify", "5")
								.toString());
				if (contraindicationICD10VerifyResult != null) {
					
					contraindicationICD10VerifyResult.setChuFangDiagnosis(chuFangDiagnosis);
					contraindicationICD10VerifyResult.setInstructionContraindication(instructionContraindication);
					
					contraindicationICD10VerifyResults
							.add(contraindicationICD10VerifyResult);
				}
			}
		}
		return contraindicationICD10VerifyResults;
	}

	/**
	 * 根据疾病名称获取对应的同一version的icd10，并截取对应的icd10 code 位数，判断是否相等。
	 * 
	 * @param chuFangDiagnosis
	 *            处方的疾病
	 * @param instructionContraindication
	 *            说明书的禁忌症
	 * @param object
	 * @return
	 */
	private ContraindicationICD10VerifyResult checkICD10CodeEq(
			String chuFangDiagnosis, String instructionContraindication,
			String lenToVerifys) {
		
		List<ICD10> chuFangDiagnosisICD10List = ICD10ParseUtil
				.getIcd10ListByDiseaseName(chuFangDiagnosis);
		List<ICD10> instructionContraindicationICD10List = ICD10ParseUtil
				.getIcd10ListByDiseaseName(instructionContraindication);
		if (chuFangDiagnosisICD10List == null
				|| chuFangDiagnosisICD10List.size() == 0
				|| instructionContraindicationICD10List == null
				|| instructionContraindicationICD10List.size() == 0) {
			return null;
		}
		String[] lenToVerifyArr = lenToVerifys.split(",");
		for (int i = 0; i < chuFangDiagnosisICD10List.size(); i++) {
			for (int j = 0; j < instructionContraindicationICD10List.size(); j++) {
				for (String icd10LenStr : lenToVerifyArr) {
					if (StringUtils.isBlank(icd10LenStr)) {
						continue;
					}
					Integer icd10Len = Integer.parseInt(icd10LenStr);
					String chuFangDiagnosisIcd10Code = chuFangDiagnosisICD10List
							.get(i).getCode();
					String instructionContraindicationICD10Code = instructionContraindicationICD10List
							.get(j).getCode();

					if (chuFangDiagnosisIcd10Code.length() < icd10Len
							|| instructionContraindicationICD10Code.length() < icd10Len) {
						continue;
					}
					String chuFangIcd10CodeSubString = chuFangDiagnosisIcd10Code
							.substring(0, icd10Len);

					String instructionIcd10CodeSubString = instructionContraindicationICD10Code
							.substring(0, icd10Len);
					String chuFangIcd10Version = chuFangDiagnosisICD10List.get(
							i).getVersion();
					String instructionIcd10Version = instructionContraindicationICD10List
							.get(j).getVersion();
					if (chuFangIcd10CodeSubString
							.equals(instructionIcd10CodeSubString)
							&& chuFangIcd10Version
									.equals(instructionIcd10Version)) {

						ContraindicationICD10VerifyResult contraindicationICD10VerifyResult = new ContraindicationICD10VerifyResult();
						ICD10 icd10 = ICD10ParseUtil.getIcd10ByCode(
								chuFangIcd10CodeSubString);
						if (icd10 == null) {
							continue;
						}
						contraindicationICD10VerifyResult.setDiseaseName(icd10
								.getName());
						contraindicationICD10VerifyResult.setIcd10Code(icd10
								.getCode());
						return contraindicationICD10VerifyResult;
					}
				}
			}
		}
		return null;
	}

	/**
	 * 某个处方对应说明书中的 禁忌 疾病/特殊人群 与 处方中的所有 适应症 进行比较 看是否全词匹配
	 * 
	 * @param instructionContraindications
	 * @param chuFangAlldiagnosises
	 * @return
	 */
	private Set<String> compareContraindicationEntirelyEq(
			List<String> instructionContraindications,
			List<String> chuFangAlldiagnosises) {
		Set<String> contraindicationEntirelyEqList = new HashSet<String>();
		for (String chuFangDiagnosis : chuFangAlldiagnosises) {
			chuFangDiagnosis = chuFangDiagnosis.trim();
			for (String instructionContraindication : instructionContraindications) {
				instructionContraindication = instructionContraindication
						.trim();

				if (chuFangDiagnosis.equals(instructionContraindication)) {
					contraindicationEntirelyEqList
							.add(instructionContraindication);
				}
			}
		}
		return contraindicationEntirelyEqList;
	}

	class ContraindicationICD10VerifyResult {
		private String diseaseName;
		private String icd10Code;

		
		private String chuFangDiagnosis;
		private String instructionContraindication;
		
		public String getDiseaseName() {
			return diseaseName;
		}

		public void setDiseaseName(String diseaseName) {
			this.diseaseName = diseaseName;
		}

		public String getIcd10Code() {
			return icd10Code;
		}

		public void setIcd10Code(String icd10Code) {
			this.icd10Code = icd10Code;
		}

		public String getChuFangDiagnosis() {
			return chuFangDiagnosis;
		}

		public void setChuFangDiagnosis(String chuFangDiagnosis) {
			this.chuFangDiagnosis = chuFangDiagnosis;
		}

		public String getInstructionContraindication() {
			return instructionContraindication;
		}

		public void setInstructionContraindication(String instructionContraindication) {
			this.instructionContraindication = instructionContraindication;
		}

		@Override
		public String toString() {
			return "ContraindicationICD10VerifyResult [diseaseName="
					+ diseaseName + ", icd10Code=" + icd10Code
					+ ", chuFangDiagnosis=" + chuFangDiagnosis
					+ ", instructionContraindication="
					+ instructionContraindication + "]";
		}

	}

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}
}
