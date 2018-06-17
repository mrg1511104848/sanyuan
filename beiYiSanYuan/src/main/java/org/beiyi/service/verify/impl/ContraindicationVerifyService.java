package org.beiyi.service.verify.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.VerifyUtil;

/**
 * 禁忌症审核
 * @author 2bu
 *
 */
public class ContraindicationVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errMsgBuffer = new StringBuffer();
		Set<Drug> notExistsDrugs = new HashSet<Drug>();
		
		List<String> chuFangAlldiagnosises = chuFang.getDiagnosises();
		
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行审核
		for (int i = 0; i < chuFangDrugVerifingList.size(); i++) {
			Drug chuFangDrug = chuFangDrugVerifingList.get(i);
			Instruction instruction = VerifyUtil.getInstructionOfChuFangDrug(chuFangDrug);
			if (instruction == null) {//药品不存在于说明书
				notExistsDrugs.add(chuFangDrug);
				continue;
			}
			
			List<String> instructionContraindications = instruction.getContraindications();
			Set<String> contraindicationEntirelyEqResult = compareContraindicationEntirelyEq(instructionContraindications,chuFangAlldiagnosises);
			
			if(VerifyUtil.chuFangDrugContainsInVerifyResult(verifyResult, chuFangDrug)){
				continue;
			}
			if(contraindicationEntirelyEqResult!=null && contraindicationEntirelyEqResult.size()>0){
				errMsgBuffer.append("药品 "+chuFangDrug.getDrugCombinationName()+" ");
				for (String entirelyEq : contraindicationEntirelyEqResult) {
					errMsgBuffer.append(String.format("禁用于 “%s” 疾病/特殊人群 ；",entirelyEq));
				}
				VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrug, VerifyTypeEnums.CONTRAINDICATIONS);
			}else{
				Set<ContraindicationICD10VerifyResult> contraindicationICD10MatchResult = compareContraindicationICD10Match(instructionContraindications,chuFangAlldiagnosises);
				if(contraindicationICD10MatchResult!=null && contraindicationICD10MatchResult.size()>0){
					errMsgBuffer.append("药品 "+chuFangDrug.getDrugCombinationName()+" ");
					for (ContraindicationICD10VerifyResult iCD10Match : contraindicationICD10MatchResult) {
						errMsgBuffer.append(String.format("禁用于 “%s(ICD10:%s)” 疾病/特殊人群 ；",iCD10Match.getDiseaseName(),iCD10Match.getIcd10Code()));
					}
				}
//				VerifyUtil.addErrorDrugToVerifyResult(verifyResult, chuFangDrug, VerifyTypeEnums.CONTRAINDICATIONS);
			}
		}
		VerifyUtil.addNotExistsDrugToVerifyResult(verifyResult, notExistsDrugs, errMsgBuffer);
		VerifyUtil.packVerifyResultFinal(verifyResult, errMsgBuffer);
		return verifyResult;
	}
	/**
	 * 判断处方中的适应症的icd10前几位 是否与药品对应于说明书中的禁忌症的icd10前几位相匹配。如果匹配，返回所有匹配项，代表处方的这些匹配到的适应症是禁忌的。
	 * @param instructionContraindications
	 * @param chuFangAlldiagnosises
	 * @return
	 */
	private Set<ContraindicationICD10VerifyResult> compareContraindicationICD10Match(
			List<String> instructionContraindications,
			List<String> chuFangAlldiagnosises) {
		Set<ContraindicationICD10VerifyResult> contraindicationICD10VerifyResults = new HashSet<ContraindicationICD10VerifyResult>();
		//TODO 判断处方中的适应症的icd10前几位 是否与药品对应于说明书中的禁忌症的icd10前几位相匹配。如果匹配，返回所有匹配项，代表处方的这些匹配到的适应症是禁忌的。
		for (String chuFangDiagnosis : chuFangAlldiagnosises) {
			chuFangDiagnosis = chuFangDiagnosis.trim();
			
			for (String instructionContraindication : instructionContraindications) {
				instructionContraindication = instructionContraindication.trim();
				ContraindicationICD10VerifyResult contraindicationICD10VerifyResult = checkICD10CodeEq(chuFangDiagnosis,instructionContraindication,5);
				if(contraindicationICD10VerifyResult!=null){
					contraindicationICD10VerifyResults.add(contraindicationICD10VerifyResult);
				}
			}
		}
		return contraindicationICD10VerifyResults;
	}
	private ContraindicationICD10VerifyResult checkICD10CodeEq(String chuFangDiagnosis,
			String instructionContraindication, int numToEq) {
		
		return null;
	}
	/**
	 * 某个处方对应说明书中的 禁忌 疾病/特殊人群 与 处方中的所有 适应症 进行比较 看是否全词匹配
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
				instructionContraindication = instructionContraindication.trim();
				
				if(chuFangDiagnosis.equals(instructionContraindication)){
					contraindicationEntirelyEqList.add(instructionContraindication);
				}
			}
		}
		return contraindicationEntirelyEqList;
	}
	class ContraindicationICD10VerifyResult{
		private String diseaseName;
		private String icd10Code;
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
	} 
}
