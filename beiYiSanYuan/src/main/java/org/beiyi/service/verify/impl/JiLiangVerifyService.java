package org.beiyi.service.verify.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.beiyi.changliang.DrugInfoEnum;
import org.beiyi.changliang.JiLiangOpratorEnum;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugDosageInfoVerifyBean;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.entity.verify.HuanZhe;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.entity.verify.JiLiang;
import org.beiyi.entity.verify.JiLiangCheckRecord;
import org.beiyi.entity.verify.Oprator;
import org.beiyi.entity.verify.enums.VerifyTypeEnums;
import org.beiyi.reource.Resources;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.beiyi.util.InstructionsReadUtil;
import org.skynet.frame.util.DoubleUtil;
import org.skynet.frame.util.RegexUtils;
import org.skynet.frame.util.StringBufferUtil;
import org.skynet.frame.util.date.DateUtil;
import org.skynet.frame.util.excel.ExcelUtil;

/**
 * 剂量审核service
 * 
 * @author 2bu
 *
 */
public class JiLiangVerifyService implements IDrugVeryfy {
	private static final String AGE_KEYWORD_REGEX = ".*成人.*|.*年龄.*|.*岁.*|.*儿童.*|.*老年.*";
	private Logger log = Logger.getLogger(JiLiangVerifyService.class);

	/**
	 * 根据规则获取剂量
	 * 
	 * @param standard
	 * @return
	 */
	private static String getDosage(String standard) {
		List<String> dosageList = RegexUtils.getByGroup(
				DrugInfoEnum.standardRegex, standard, 1);
		return dosageList == null || dosageList.size() == 0 ? null : dosageList
				.get(0).trim();
	}

	/**
	 * 根据规则获取包装单位 如 粒、颗
	 * 
	 * @param standard
	 * @return
	 */
	private static String getDosagePackUnit(String standard) {
		List<String> dosageList = RegexUtils.getByGroup(
				DrugInfoEnum.standardRegex, standard, 4);
		return dosageList == null || dosageList.size() == 0 ? null : dosageList
				.get(0).trim();
	}

	/**
	 * 根据规则获取剂量单位
	 * 
	 * @param standard
	 * @return
	 */
	private static String getDosageUnit(String standard) {
		List<String> dosageList = RegexUtils.getByGroup(
				DrugInfoEnum.dosageUnitRegex, standard, 2);
		return dosageList == null || dosageList.size() == 0 ? null : dosageList
				.get(0).trim();
	}

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		List<Drug> chuFangDrugVerifingList = chuFang.getDrugs();// 需要遍历处方中的药品，挨个进行计量审核
		int chuFangDrugValidCount = 0;
		StringBuffer chuFangErrBuffer = new StringBuffer();
		chuFangDrugLoopOutter: 
		for (Drug chuFangDrug : chuFangDrugVerifingList) {
			String chuFangDrugDosage = chuFangDrug.getDosage();
			String chuFangDrugDosageUnit = chuFangDrug.getDosageUnit();
			String chuFangDrugDosingFrequency = chuFangDrug
					.getDosingFrequency();
			String chuFangDrugCombinationName = chuFangDrug
					.getDrugCombinationName();
			
			System.out.println("------------------------------------------");
			log.info(String.format("[chuFangDrugCombinationName] %s",
					chuFangDrugCombinationName));

			String[] blankElement = getBlankElement(
					new String[] {
							chuFangDrugDosageUnit,
							" [处方] " + chuFangDrug.getDrugCombinationName()
									+ " “每次用量单位”为空!" },
					new String[] {
							chuFangDrugDosage,
							" [处方] " + chuFangDrug.getDrugCombinationName()
									+ " “每次用量”为空!" },
					new String[] {
							chuFangDrugDosingFrequency,
							" [处方] " + chuFangDrug.getDrugCombinationName()
									+ " “用药频率”为空!" });
			if (blankElement != null) {
				continue;
			}
			DrugDosageInfoVerifyBean dosageInfoVerifyBean = new DrugDosageInfoVerifyBean();// 某药审核结果封装
			dosageInfoVerifyBean.setDrug(chuFangDrug);
			// 获取整理好的说明书的药品
			Instruction instruction = InstructionsReadUtil.get(chuFangDrug
					.getDrugCombinationName());
			if (instruction == null) {
				String errorMsg = String.format(" %s 在说明书中不存在！",
						chuFangDrug.getDrugCombinationName());
				chuFangErrBuffer.append(String.format(
						"%s【药品】 %s 剂量不适宜，具体原因为 ： %s", ExcelUtil.NEW_LINE,
						chuFangDrug.getDrugCombinationName(), errorMsg));
				continue;
			}
			List<InstructionUse> instructionUses = instruction
					.getInstructionUses();
			// 获取“剂量选择”分组
			List<List<JiLiang>> jiLiangSelectionGroupList = Resources.jiLiangSelectionGroupList;
			// 用来存放剂量审核的记录，最后进行最终剂量评判的标准
			List<JiLiangCheckRecord> jiLiangCheckRecords = new ArrayList<JiLiangCheckRecord>();
			// 遍历 整理好的说明书 - 药品使用相关信息
			for (InstructionUse instructionUse : instructionUses) {
				String instructionPatientStatusText = instructionUse
						.getPatientStatus();// 患者状态
				String instructionDoseSelection = instructionUse
						.getDoseSelection();// 剂量选择
				String instructionDosage = instructionUse.getDosage();// 1 or
																		// 1；2
				String instructionDosageUnit = instructionUse.getDosageUnit(); // 粒
																				// 片
																				// 次/日
				instructionDoseSelection = parseDoseSelection(instructionDoseSelection); //转换一下说明书中的剂量选择
				
				String instructionDosingFrequency = instructionUse
						.getDosingFrequency(); // BID Q6H 次
				
				String[] instructionBlankElement = getBlankElement(
						new String[] {
								instructionDosageUnit,
								" [整理好的说明书] "
										+ instruction.getDrugCombinationName()
										+ " “每次用量单位”为空!" },
						new String[] {
								instructionDosage,
								" [整理好的说明书] "
										+ instruction.getDrugCombinationName()
										+ " “每次用量”为空!" },
						new String[] {
								instructionDosingFrequency,
								" [整理好的说明书] "
										+ instruction.getDrugCombinationName()
										+ " “用药频率”为空!" });
				if (instructionBlankElement != null) {
					continue;
				}
				// 0.筛选人群
				boolean crowdValid = crowdIsValid(chuFang,
						instructionPatientStatusText);
				if (!crowdValid) {// 不属于该人群的话，continue;
				// chuFangErrBuffer.append(String.format("%s【药品】 %s 人群不适宜",ExcelUtil.NEW_LINE,
				// chuFangDrug.getDrugCombinationName()));
					continue;
				}
				// 1.首先比较每次用量单位
				if (!chuFangDrugDosageUnit.equals(instructionDosageUnit)) {// 不一致
					// 统一单位
					String[] dosageArr = parseToStandardUnit(chuFangDrug,
							instructionUse);// 统一剂量单位 index:[0]
											// chuFangDrugDosage index:[1]
											// instructionDosage
					if (dosageArr == null) {
						String errorMsg = String
								.format(" [统一剂量单位] %s 换算失败  [chuFangDrugDosageUnit] %s [instructionDosageUnit] %s",
										instruction.getDrugCombinationName(),
										chuFangDrugDosageUnit,
										instructionDosageUnit);
						log.error(errorMsg);
						chuFangErrBuffer
								.append(String.format(
										"%s【药品】 %s 剂量不适宜，具体原因为 ： %s",
										ExcelUtil.NEW_LINE,
										chuFangDrug.getDrugCombinationName(),
										errorMsg));
						// 将处方中错误的药品封装到verifyResult
						DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(
								chuFangDrug,
								VerifyTypeEnums.ERROR_PARSE_DOSAGE_UNIT);
						verifyResult.getErrorDrugs().add(drugVerifyInfo);
						continue chuFangDrugLoopOutter;// 如果换算失败的话，进行下一个处方药品审核
					} else {
						chuFangDrugDosage = dosageArr[0];
						instructionDosage = dosageArr[1];
					}
				}
				// 2.比较每次用量
				JiLiang sourceJiLiang = new JiLiang(chuFangDrugDosage,
						chuFangDrugDosingFrequency);
				JiLiang targetJiLiang = new JiLiang(instructionDosage,
						instructionDosingFrequency, instructionDoseSelection);
				JiLiangCheckRecord checkRecord = new JiLiangCheckRecord(
						sourceJiLiang, targetJiLiang);// 每次比较两个前封装一下
				jiLiangCheckRecords.add(checkRecord);

				// 比较用量
				if (!compareDosage(checkRecord)) {
					checkRecord.setValid(false);
					checkRecord.setInValidText(String.format(
							"%s 用量不适宜 : 处方“%s” , 说明书【%s】“%s” ",
							ExcelUtil.NEW_LINE, chuFangDrugDosage.trim(),
							instructionDoseSelection, instructionDosage));
					dosageInfoVerifyBean.getInvalidInstructionDosages().add(
							"【" + instructionDoseSelection + "】"
									+ instructionUse.getDosage()
									+ instructionUse.getDosageUnit());
					checkRecord
							.setInvalidDosageType(VerifyTypeEnums.INVALID_DOSAGE);
				} else {
					// 剂量选择符合第一个分组才加入到dosageInfoVerifyBean有效的剂量中
					List<JiLiang> groupJiLiangs = jiLiangSelectionGroupList
							.get(0);
					for (JiLiang jiLiang : groupJiLiangs) {
						if (instructionDoseSelection.equals(jiLiang
								.getDoseSelection())) {
							dosageInfoVerifyBean.getValidInstructionDosages()
									.add("【" + instructionDoseSelection + "】"
											+ instructionUse.getDosage()
											+ instructionUse.getDosageUnit());
							break;
						}
					}
				}
				// 进一步比较用药频率
				if (!compareFrequency(checkRecord)) {
					checkRecord.setValid(false);
					// checkRecord.setInValidText(String.format("%s 用药频率不适宜 : 处方“%s” 说明书“%s”"
					// ,ExcelUtil.NEW_LINE,chuFangDrugDosingFrequency.trim(),instructionDosingFrequency.trim()));
					checkRecord
							.setInvalidDosageType(VerifyTypeEnums.INVALID_DOSING_FREQUENCY);
					dosageInfoVerifyBean.getInvalidInstructionDosFrequencys()
							.add(instructionDosingFrequency.trim());
				} else {
					dosageInfoVerifyBean.getValidInstructionDosFrequencys()
							.add(instructionDosingFrequency.trim());
				}
				
				/*//计算发药数量，疗程是否符合说明书的标准
				if(checkRecord.isValid()){
					String calculate = Resources.dddsCalculateMap.get(chuFangDrugDosingFrequency);
					String hour = calculate.split("_")[0];
					String time = calculate.split("_")[1];
					
					
					RegexUtils.getByGroup(DrugInfoEnum.standardRegex, "0.3g x20粒/盒", 1);
				}*/
			}

			// 遍历所有的关于这个处方的审核结果。按照doseSelection(剂量选择)进行分组，
			// 并查询每个分组是否达标，如果某一分组不达标，
			// 则认定为审核失败

			// 初始化检查后的分组List
			List<List<JiLiangCheckRecord>> checkResultsGroupList = new ArrayList<List<JiLiangCheckRecord>>(
					jiLiangSelectionGroupList.size());
			for (int i = 0; i < jiLiangSelectionGroupList.size(); i++) {
				checkResultsGroupList.add(new ArrayList<JiLiangCheckRecord>(2));
			}
			outter: for (JiLiangCheckRecord jiLiangCheckRecord : jiLiangCheckRecords) {
				String doseSelection = jiLiangCheckRecord.getTargetJiLiang()
						.getDoseSelection();
				// 从resouce中初始化的分组中，根据剂量选择判断属于哪个分组
				for (int i = 0; i < jiLiangSelectionGroupList.size(); i++) {
					List<JiLiang> jiLiangSelectionGroup = jiLiangSelectionGroupList
							.get(i);
					for (JiLiang jiLiang : jiLiangSelectionGroup) {
						if (jiLiang.getDoseSelection().equals(doseSelection)) {
							checkResultsGroupList.get(i)
									.add(jiLiangCheckRecord);
							continue outter;
						}
					}
				}
			}
			List<Boolean> groupValidRecords = new ArrayList<Boolean>();// 记录每组检查的结果
			boolean allGroupValid = true;
			outter: for (List<JiLiangCheckRecord> checkResultGroupEach : checkResultsGroupList) {
				boolean thisGroupValid = false;
				if (checkResultGroupEach == null
						|| checkResultGroupEach.size() == 0) {
					groupValidRecords.add(null);// 记录每组检查的结果
					continue;
				}
				for (JiLiangCheckRecord checkResult : checkResultGroupEach) {
					if (checkResult.isValid()) {
						JiLiang targetJiLiang = checkResult.getTargetJiLiang();
						if (targetJiLiang.getDoseSelection().equals(
								"单日最大剂量/最大日剂量")) {
							allGroupValid = true;// 如果有单日最大剂量，则判断是否小于单日最大剂量,如果小于，也是这个药正确的。
							groupValidRecords.add(true);// 记录每组检查的结果
							break outter;
						} else {
							thisGroupValid = true;
							break;
						}
					}
				}
				if (!thisGroupValid) {// 如果某一分组不达标，则认定为审核失败（单日最大剂量已经在上面判断）
					allGroupValid = false;
				}
				groupValidRecords.add(thisGroupValid);// 记录每组检查的结果
			}
			if (allGroupValid) {
				// 将处方中正确的药品封装到verifyResult
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug,
						VerifyTypeEnums.SUCCESS);
				verifyResult.getSuccessDrugs().add(drugVerifyInfo);

				chuFangDrugValidCount++;// 正确的处方数量累加
			} else {
				// 将处方中错误的药品封装到verifyResult
				DrugVerifyInfo drugVerifyInfo = new DrugVerifyInfo(chuFangDrug,
						VerifyTypeEnums.INVALID_DOSAGE);
				verifyResult.getErrorDrugs().add(drugVerifyInfo);

				String errorMsg = packJiLiangErrorMsg(dosageInfoVerifyBean,
						checkResultsGroupList, groupValidRecords);
				errorMsg = String.format("%s【药品】 %s 剂量不适宜，具体原因为（%s）",
						ExcelUtil.NEW_LINE,
						chuFangDrug.getDrugCombinationName(), errorMsg);
				chuFangErrBuffer.append(errorMsg);
			}
		}
		if(chuFangDrugValidCount == chuFangDrugVerifingList.size()){
			return VerifyResult
					.success();
		}else{
			verifyResult.setResultMsg("审核失败，剂量存在问题（"
					+ chuFangErrBuffer.toString() + "）");
			return verifyResult;
		}
	}
	private String parseDoseSelection(String doseSelection){
		if(StringUtils.isBlank(doseSelection)){
			return "常规剂量";
		}
		return doseSelection;
	}
	

	/**
	 * 封装剂量审核的错误信息
	 * 
	 * @param dosageInfoVerifyBean
	 * @param checkResultsGroupList
	 * @param groupValidRecords
	 * @return
	 */
	private String packJiLiangErrorMsg(
			DrugDosageInfoVerifyBean dosageInfoVerifyBean,
			List<List<JiLiangCheckRecord>> checkResultsGroupList,
			List<Boolean> groupValidRecords) {
		StringBuffer errorMsgSb = new StringBuffer();
		for (int i = 0; i < groupValidRecords.size(); i++) {
			Boolean checkResult = groupValidRecords.get(i);
			if (checkResult == null) {
				continue;
			}
			if (checkResult == false) {
				List<JiLiangCheckRecord> checkGroupList = checkResultsGroupList
						.get(i);
				for (JiLiangCheckRecord jiLiangCheckRecord : checkGroupList) {
					String invalidText = jiLiangCheckRecord.getInValidText();
					if (StringUtils.isNotBlank(invalidText))
						errorMsgSb.append(invalidText + " ，");
				}

				/*
				 * List<JiLiangCheckRecord> filteredCheckGroupList = new
				 * ArrayList<JiLiangCheckRecord>(); for (JiLiangCheckRecord
				 * jiLiangCheckRecord : checkGroupList) { boolean contains =
				 * false; int invalidDosageType =
				 * jiLiangCheckRecord.getInvalidDosageType();
				 * if(invalidDosageType ==
				 * DosageInvalidTypeEnums.INVALID_DOSAGE){
				 * 
				 * } for (JiLiangCheckRecord filteredCheckRecord :
				 * filteredCheckGroupList) { String oldDoseSelection =
				 * jiLiangCheckRecord.getTargetJiLiang().getDoseSelection();
				 * String filteredDoseSelection =
				 * filteredCheckRecord.getTargetJiLiang().getDoseSelection();
				 * if(oldDoseSelection!=null && filteredDoseSelection!=null &&
				 * oldDoseSelection.equals(filteredDoseSelection)){ contains =
				 * true; break; } } if(!contains){ String invalidText =
				 * jiLiangCheckRecord.getInValidText();
				 * parseAfterErrorMsg.append(invalidText+" ，");
				 * 
				 * filteredCheckGroupList.add(jiLiangCheckRecord); } }
				 */

			}
		}

		/*
		 * for (List<JiLiangCheckRecord> errorGroup :
		 * checkResultsGroupErrorList) {
		 * 
		 * }
		 */
		Drug dosageDrug = dosageInfoVerifyBean.getDrug();
		StringBuffer resultTxtDosing = new StringBuffer();
		if (dosageInfoVerifyBean.getValidInstructionDosages().size() == 0
				&& dosageInfoVerifyBean.getInvalidInstructionDosages().size() > 0) {
			resultTxtDosing.append("用量不合适:");
			String chuFangDrugDosing = dosageDrug.getDosage()
					+ dosageInfoVerifyBean.getDrug().getDosageUnit() + "("
					+ dosageDrug.getStandard() + ")";
			resultTxtDosing.append("处方用量");
			resultTxtDosing.append("“");
			resultTxtDosing.append(chuFangDrugDosing);
			resultTxtDosing.append("”，");
			resultTxtDosing.append("未在说明书用量");
			resultTxtDosing.append("（");
			for (String instructionDos : dosageInfoVerifyBean
					.getInvalidInstructionDosages()) {
				resultTxtDosing.append(instructionDos);
				resultTxtDosing.append("，");
			}
			resultTxtDosing = StringBufferUtil.removeEnd(resultTxtDosing, "，").append("）范围内");
		}

		StringBuffer resultTxtDosingFrequency = new StringBuffer();
		if (dosageInfoVerifyBean.getValidInstructionDosFrequencys().size() == 0
				&& dosageInfoVerifyBean.getInvalidInstructionDosFrequencys()
						.size() > 0) {
			resultTxtDosingFrequency.append("频率不合适:");
			String chuFangDrugDosingFrequency = dosageInfoVerifyBean.getDrug()
					.getDosingFrequency().trim();
			resultTxtDosingFrequency.append("处方频率");
			resultTxtDosingFrequency.append("“");
			resultTxtDosingFrequency.append(chuFangDrugDosingFrequency);
			resultTxtDosingFrequency.append("”，");
			resultTxtDosingFrequency.append("未在说明书频率");
			resultTxtDosingFrequency.append("（");
			for (String instructionDosFrequency : dosageInfoVerifyBean
					.getInvalidInstructionDosFrequencys()) {
				resultTxtDosingFrequency.append(instructionDosFrequency);
				resultTxtDosingFrequency.append("，");
			}
			resultTxtDosingFrequency = StringBufferUtil.removeEnd(resultTxtDosingFrequency, "，");
			resultTxtDosingFrequency.append("）范围内");
		}
		// return errorMsgSb.toString() + " 转换后:"+parseAfterErrorMsg.toString();

		StringBuffer result = new StringBuffer("【药品】"
				+ dosageDrug.getDrugCombinationName());
		if (StringUtils.isNotBlank(resultTxtDosing)) {
			result.append(resultTxtDosing);
			result.append("；");
		}
		if (StringUtils.isNotBlank(resultTxtDosingFrequency)) {
			result.append(resultTxtDosingFrequency);
			result.append("；");
		}
		return result.toString();
	}

	/**
	 * 根据处方中的患者的生日等信息和说明书的患者状态，过滤看患者是否属于那个人群
	 * 
	 * @param chuFang
	 * @param instructionPatientStatusText
	 */
	private boolean crowdIsValid(ChuFang chuFang,
			String instructionPatientStatusText) {
		HuanZhe huanZhe = chuFang.getHuanZhe();
		if (huanZhe == null)
			throw new RuntimeException("The huanZhe is blank!");

		if (instructionPatientStatusText.contains("暂无")) {
			return true;
		} else if (instructionPatientStatusText.matches(AGE_KEYWORD_REGEX)) {
			if (StringUtils.isNotBlank(huanZhe.getBornDate())) {
				// DateUtils.parseDate(str, parsePatterns)
				try {
					Date bornDate = DateUtil.parseToDate(huanZhe.getBornDate());
					// 查看患者的年龄是否在区间内
					return compareBornDateInInstructionPatientStatus(bornDate,
							instructionPatientStatusText);
				} catch (ParseException e) {
					log.error("The bornDate is not valid", e);
					return false;
				}
			}
		} else {
			// 判断用户的诊断是否符合说明书的患者状态
			List<String> diagnosisesList = chuFang.getDiagnosises();
			for (String diagnosis : diagnosisesList) {
				if (compareDiagnosisAndInstructionPatientStatus(diagnosis,
						instructionPatientStatusText)) {
					return true;
				}
			}

		}

		return false;
	}

	/**
	 * 查看患者的年龄是否在说明书的患者状态 (成人|老年|other)区间内
	 * 
	 * @param bornDate
	 * @param instructionPatientStatusText
	 * @return
	 */
	private boolean compareBornDateInInstructionPatientStatus(Date bornDate,
			String instructionPatientStatusText) {
		System.out.println(new SimpleDateFormat(DateUtil.DATE_FORMAT_02)
				.format(bornDate));
		String ageCondition = Resources.patientStatusMap
				.get(instructionPatientStatusText);
		if (StringUtils.isNotBlank(ageCondition)) {
			if (ageCondition.contains("or")) {
				String[] orConditions = ageCondition.split("or");
				boolean condition0InSection = DateUtil.dateInSection(bornDate,
						orConditions[0]);
				boolean condition1InSection = DateUtil.dateInSection(bornDate,
						orConditions[1]);
				if (condition0InSection || condition1InSection) {
					return true;
				}
			} else if (ageCondition.contains("and")) {
				String[] andConditions = ageCondition.split("and");
				boolean condition0InSection = DateUtil.dateInSection(bornDate,
						andConditions[0]);
				boolean condition1InSection = DateUtil.dateInSection(bornDate,
						andConditions[1]);
				if (condition0InSection && condition1InSection) {
					return true;
				}
			} else {
				boolean condition0InSection = DateUtil.dateInSection(bornDate,
						ageCondition);
				return condition0InSection;
			}
		}
		return false;
	}

	private boolean compareDiagnosisAndInstructionPatientStatus(
			String diagnosis, String instructionPatientStatusText) {
		if (StringUtils.isBlank(diagnosis))
			return false;
		if (diagnosis.equals(instructionPatientStatusText)) {
			return true;
		}
		return false;
	}

	/**
	 * 获取为空的元素，此方法用于校验blank的元素，ps : 校验每次用量是否为空，如果为空，记录日志并返回为空的元素...
	 * 
	 * @param blankChecks
	 *            [0] 元素值 [1] 元素为空时的说明
	 * @return 返回为空的元素和元素为空时的说明
	 */
	private String[] getBlankElement(String[]... blankChecks) {
		for (String[] check : blankChecks) {
			String key = check[0];
			if (StringUtils.isBlank(key)) {
				log.error(check[1]);
				return check;
			}
		}
		return null;
	}

	/**
	 * 比较每次用量
	 * 
	 * @param dosage
	 *            处方中的剂量
	 * @param instructionDosage
	 *            说明书中的剂量
	 * @param instructionDoseSelection
	 * @param checkRecord
	 * @return
	 */
	private boolean compareDosage(JiLiangCheckRecord checkRecord) {
		JiLiang source = checkRecord.getSourceJiLiang();
		JiLiang target = checkRecord.getTargetJiLiang();

		String[] dosageArr = source.getDosage().split(DrugInfoEnum.dosageRegex);
		String[] instructionDosageArr = target.getDosage().split(
				DrugInfoEnum.dosageRegex);
		for (String cfDosage : dosageArr) {

			if (StringUtils.isBlank(cfDosage)) {
				checkRecord.setValid(false);
				continue;
			}

			for (String insDosage : instructionDosageArr) {

				if (StringUtils.isBlank(insDosage)) {
					checkRecord.setValid(false);
					continue;
				}
				cfDosage = cfDosage.trim();
				insDosage = insDosage.trim();
				String insDoseSelection = target.getDoseSelection();// 获取剂量选择，用于判断用什么操作符
				double doubleCfDosage = DoubleUtil.parseStr2Double(cfDosage, 3);
				Oprator insOprator = getSpecialParseToStandardOp(insDosage);
				// 如果处方中剂量直接是个范围，并且是剂量分组中第一组中的内容(常规剂量,起始剂量,负荷剂量,维持剂量,剂量调整) or
				// 剂量选择是空 ，则直接从这里判断
				if (insOprator.getType().equals(JiLiangOpratorEnum.BETWEEN)
						&& (getJiLiang(insDoseSelection, 0) != null || StringUtils
								.isBlank(insDoseSelection))) {
					List<Double> insJiLiangRanges = insOprator
							.getToCompareNums();
					if (doubleCfDosage >= insJiLiangRanges.get(0)
							&& doubleCfDosage <= insJiLiangRanges.get(1)) {
						checkRecord.setValid(true);
						return true;
					} else {
						checkRecord.setValid(false);
						return false;
					}
				}

				double doubleInsDosage = DoubleUtil.parseStr2Double(insDosage,
						3);

				JiLiang jiLiang = getJiLiang(insDoseSelection);
				if (jiLiang == null) {
					checkRecord.setValid(false);
					continue;
				}
				String op = jiLiang.getOprator();
				if (op.equals(JiLiangOpratorEnum.EQ)
						&& doubleCfDosage == doubleInsDosage) {
					checkRecord.setValid(true);
					return true;
				}
				if (op.equals(JiLiangOpratorEnum.LEQ)
						&& doubleCfDosage <= doubleInsDosage) {
					checkRecord.setValid(true);
					return true;
				}
				if (op.equals(JiLiangOpratorEnum.GEQ)
						&& doubleCfDosage >= doubleInsDosage) {
					checkRecord.setValid(true);
					return true;
				}
			}
		}
		checkRecord.setValid(false);
		return false;
	}

	

	private Oprator getSpecialParseToStandardOp(String insDosage) {
		Oprator oprator = new Oprator();
		String[] regex = { "(\\d+|\\d+.\\d+)~(\\d+|\\d+.\\d+)", "(\\d+)" };
		String[] regexType = { JiLiangOpratorEnum.BETWEEN,
				JiLiangOpratorEnum.EQ };
		for (int i = 0; i < regex.length; i++) {
			String r = regex[i];
			List<String> tarNums = RegexUtils.getByGroup(r, insDosage);
			if (tarNums.size() != 0) {
				List<Double> toCompareNums = new ArrayList<Double>();
				for (String n : tarNums) {
					toCompareNums.add(DoubleUtil.parseStr2Double(n, 3));
				}
				oprator.setType(regexType[i]);
				oprator.setToCompareNums(toCompareNums);
				break;
			}
		}
		return oprator;
	}

	/**
	 * 比较用药频率
	 * 
	 * @param dosingFrequency
	 * @param instructionDosingFrequency
	 * @return
	 */
	private boolean compareFrequency(JiLiangCheckRecord checkRecord) {
		/*String dosingFrequency = checkRecord.getSourceJiLiang()
				.getDosingFrequency().trim();
		String instructionDosingFrequency = checkRecord.getTargetJiLiang()
				.getDosingFrequency().trim();
		if (dosingFrequency.equals(instructionDosingFrequency)) {
			return true;
		}
		List<String> equalsFrequencies = Resources.dddsMap.get(dosingFrequency);
		if (equalsFrequencies == null) {
			return false;
		}
		return equalsFrequencies.contains(instructionDosingFrequency);*/
		return false;
	}

	/**
	 * 统一单位
	 * 
	 * @param instructionUse
	 *            说明书
	 * @param chuFangDrug
	 *            处方
	 * @return index:[0] 处方中的格式化后的剂量 index:[1] 说明书中的格式化后的剂量
	 */
	private String[] parseToStandardUnit(Drug chuFangDrug,
			InstructionUse instructionUse) {
		if (chuFangDrug == null || instructionUse == null) {
			return null;
		}

		String chuFangDrugStandard = chuFangDrug.getStandard();// 处方药品规格
		if (chuFangDrugStandard == null) {
			return null;
		}

		// 查看处方的Drug的剂量单位 和 说明书的Drug的剂量单位 ， 是否可以直接转换为mg
		String chuFangDosage = chuFangDrug.getDosage();
		String chuFangDosageUnit = chuFangDrug.getDosageUnit();

		String instructionDosage = instructionUse.getDosage();
		String instructionDosageUnit = instructionUse.getDosageUnit();

		String[] chuFangDosageStandard = null;
		String[] instructionDosageStandard = null;

		// 进行包装单位转换
		String[] chuFangDosageAndDosageUnit = parseDosagePackUnit(chuFangDrug, chuFangDosage, chuFangDosageUnit);
		String[] instructionDosageAndDosageUnit = parseDosagePackUnit(chuFangDrug, instructionDosage, instructionDosageUnit);
		if(chuFangDosageAndDosageUnit == null || instructionDosageAndDosageUnit == null){
			//发现药品单位是包装单位但是转换失败。
			return null;
		}
		// 进行剂量单位转换
		chuFangDosageStandard = parseDosageUnitToStandard(chuFangDosageAndDosageUnit[0],
				chuFangDosageAndDosageUnit[1]);
		;
		instructionDosageStandard = parseDosageUnitToStandard(
				instructionDosageAndDosageUnit[0], instructionDosageAndDosageUnit[1]);

		if (chuFangDosageStandard != null && instructionDosageStandard != null
				&& chuFangDosageStandard.length == 2
				&& instructionDosageStandard.length == 2) {
			if (StringUtils.isBlank(chuFangDosageStandard[1])
					|| StringUtils.isBlank(instructionDosageStandard[1])) {
				return null;
			}
			if (chuFangDosageStandard[1].equals(instructionDosageStandard[1])) {
				return new String[] { chuFangDosageStandard[0],
						instructionDosageStandard[0] };
			}
		}

		return null;
	}

	/**
	 * 针对包装单位的转换
	 * 
	 * @param chuFangDrug
	 * @param dosage
	 * @param dosageUnit
	 * @return
	 */
	private String[] parseDosagePackUnit(Drug chuFangDrug, String dosage,
			String dosageUnit) {
		if (StringUtils.isBlank(dosage)) {
			throw new RuntimeException("The dosage is blank!");
		}
		if (StringUtils.isBlank(dosageUnit)) {
			throw new RuntimeException("The DosageUnit is blank!");
		}
		if (!dosageUnit.matches("粒|拴|揿|瓶|片|喷|枚")) {
			return new String[] { dosage, dosageUnit };
		}
		String chuFangDrugStandard = chuFangDrug.getStandard();// 规格
		if (chuFangDrugStandard == null) {
			log.error(String.format("[处方-药品] %s 规格为空",
					chuFangDrug.getDrugCombinationName()));
			return null;
		}
		String chuFangDosagePackUnitFromDrugStandard = getDosagePackUnit(chuFangDrugStandard); // 处方中的包装单位

		if (StringUtils.isBlank(chuFangDosagePackUnitFromDrugStandard)) {
			log.error(String.format("[处方-药品] %s 处方中规格 “%s” 获取的包装单位为空",
					chuFangDrug.getDrugCombinationName(),chuFangDrugStandard));
			return null;
		}
		// 计量单位/包装单位dosageUnit 是否等于处方中的包装单位，相等的话在转换剂量及单位
		if (dosageUnit.trim().equalsIgnoreCase(chuFangDosagePackUnitFromDrugStandard.trim())) {
			// 0.3g * 20粒 /盒  
			//得到 0.3(dosageFromDrugStandard) 和 g(dosageUnitFromDrugStandard)
			String dosageFromDrugStandard = getDosage(chuFangDrugStandard);// 从规格中获取处方中的剂量
			String dosageUnitFromDrugStandard = getDosageUnit(chuFangDrugStandard);// 从规格中获取处方中的剂量单位
			
			if(StringUtils.isBlank(dosageFromDrugStandard)){
				log.error(String.format("[处方-药品] %s 处方中规格 “%s” 获取的剂量为空",
						chuFangDrug.getDrugCombinationName(),chuFangDrugStandard));
				return null;
			}
			if(StringUtils.isBlank(dosageFromDrugStandard)){
				log.error(String.format("[处方-药品] %s 处方中规格 “%s” 获取的剂量单位为空",
						chuFangDrug.getDrugCombinationName(),chuFangDrugStandard));
				return null;
			}
			//0.3(dosageFromDrugStandard) 和 1(dosage) 相乘得到每次用量
			double dosageDouble = DoubleUtil.parseStr2Double(dosageFromDrugStandard, 3);
			double dosageFromDrugStandardDouble = DoubleUtil.parseStr2Double(dosage, 3);
			double dosageShouldBeUseEachTime = dosageDouble * dosageFromDrugStandardDouble; //相乘得到每次应该用的量
			
			//将g(dosageUnitFromDrugStandard)和相乘得到每次应该用的量dosageShouldBeUseEachTime相组合，返回。
			return new String[] { dosageShouldBeUseEachTime+"", dosageUnitFromDrugStandard };
		}
		return null;
	}

	/**
	 * 转换成常规的剂量单位，不对包装单位转换 //常见质量单位：1克（g）=1000毫克（mg）=10000000微克（μg）；
	 * //常见体积单位：1升（L）=1000毫升（ml）=1000000微升（μl）；
	 * 
	 * @param dosage
	 * @param dosageUnit
	 * @return
	 */
	private String[] parseDosageUnitToStandard(String dosage, String dosageUnit) {
		if (StringUtils.isBlank(dosage) || StringUtils.isBlank(dosageUnit)) {
			return null;
		}
		String parsedDosage = null;
		if(Resources.dosageUnitConversionMap.containsKey(dosageUnit)){
			String[] convertInfo = Resources.dosageUnitConversionMap.get(dosageUnit);
			String parsedDosageUnit = convertInfo[0];
			String opNum = convertInfo[1];
			String op = convertInfo[2];
			Oprator oprator = getSpecialParseToStandardOp(opNum);
			if(oprator.getType().equals(JiLiangOpratorEnum.BETWEEN)){
				List<Double> ranges = oprator.getToCompareNums();
				if(op.equals(JiLiangOpratorEnum.MULTIPLY)){
					double start = DoubleUtil.parseStr2Double(dosage, 3)*ranges.get(0);
					double end = DoubleUtil.parseStr2Double(dosage, 3)*ranges.get(1);
					parsedDosage = start+"~"+end;
				}else{
					throw new RuntimeException(" The other oprators not support!");
				}
			}else if(oprator.getType().equals(JiLiangOpratorEnum.EQ)){
				if(op.equals(JiLiangOpratorEnum.MULTIPLY)){
					double parsedDosageDouble = DoubleUtil.parseStr2Double(dosage, 3)*DoubleUtil.parseStr2Double(opNum, 3);
					parsedDosage = parsedDosageDouble + "";
				}else if(op.equals(JiLiangOpratorEnum.DEVIDED)){
					double parsedDosageDouble = DoubleUtil.parseStr2Double(dosage, 3)/DoubleUtil.parseStr2Double(opNum, 3);
					parsedDosage = parsedDosageDouble + "";
				}
			}
			return new String[] { parsedDosage, parsedDosageUnit };
		}
		return null;
	}

	/**
	 * 判断剂量是否属于某个index分组
	 * 
	 * @param doseSelection
	 * @param groupIndex
	 * @return
	 */
	public static JiLiang getJiLiang(String doseSelection, int groupIndex) {
		List<JiLiang> list = Resources.jiLiangSelectionGroupList
				.get(groupIndex);
		for (JiLiang jiLiang : list) {
			if (jiLiang.getDoseSelection().equals(doseSelection)) {
				return jiLiang;
			}
		}
		return null;
	}

	public static JiLiang getJiLiang(String doseSelection) {
		for (List<JiLiang> list : Resources.jiLiangSelectionGroupList) {
			for (JiLiang jiLiang : list) {
				if (jiLiang.getDoseSelection().equals(doseSelection)) {
					return jiLiang;
				}
			}
		}
		return null;
	}

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}

}
