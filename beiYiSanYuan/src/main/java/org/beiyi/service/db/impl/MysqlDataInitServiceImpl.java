package org.beiyi.service.db.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.openxml4j.exceptions.InvalidOperationException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.beiyi.dao.AtcBelongToMapper;
import org.beiyi.dao.AtcCodeMapper;
import org.beiyi.dao.AtcConflictMapper;
import org.beiyi.dao.DiseaseIcd10Mapper;
import org.beiyi.dao.DiseaseMapper;
import org.beiyi.dao.Icd10Mapper;
import org.beiyi.dao.IndicationTherapeuticRegimenMapper;
import org.beiyi.dao.InstructionComponentAtcMapper;
import org.beiyi.dao.InstructionComponentMapper;
import org.beiyi.dao.InstructionContraindicationMapper;
import org.beiyi.dao.InstructionIndicationMapper;
import org.beiyi.dao.InstructionsAtcMapper;
import org.beiyi.dao.InstructionsCategoryMapper;
import org.beiyi.dao.InstructionsMapper;
import org.beiyi.datadeal.DXYUtil;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.db.AtcBelongTo;
import org.beiyi.entity.db.AtcCode;
import org.beiyi.entity.db.AtcConflict;
import org.beiyi.entity.db.Disease;
import org.beiyi.entity.db.DiseaseIcd10;
import org.beiyi.entity.db.Icd10;
import org.beiyi.entity.db.IndicationTherapeuticRegimen;
import org.beiyi.entity.db.InstructionComponent;
import org.beiyi.entity.db.InstructionComponentAtc;
import org.beiyi.entity.db.InstructionContraindication;
import org.beiyi.entity.db.InstructionIndication;
import org.beiyi.entity.db.Instructions;
import org.beiyi.entity.db.InstructionsAtc;
import org.beiyi.entity.db.InstructionsCategory;
import org.beiyi.entity.db.TherapeuticRegimen;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.Instruction;
import org.beiyi.entity.verify.InstructionUse;
import org.beiyi.reource.BysyConfig;
import org.beiyi.reource.Resources;
import org.beiyi.service.db.itr.IMysqlDataInitService;
import org.beiyi.util.ATCUtil;
import org.beiyi.util.InstructionsReadUtil;
import org.bson.Document;
import org.skynet.frame.util.excel.ExcelReadUtil;
import org.skynet.frame.util.mongo.MongoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import com.gargoylesoftware.htmlunit.util.StringUtils;
import com.sun.jna.platform.FileUtils;

@Service
public class MysqlDataInitServiceImpl implements IMysqlDataInitService {
	@Autowired
	Icd10Mapper icd10Mapper;
	@Autowired
	AtcCodeMapper atcCodeMapper;
	@Autowired
	InstructionsMapper instructionsMapper;
	@Autowired
	InstructionComponentMapper instructionComponentMapper;
	@Autowired
	InstructionComponentAtcMapper instructionComponentAtcMapper;
	@Autowired
	InstructionsAtcMapper instructionsAtcMapper;
	@Autowired
	AtcConflictMapper atcConflictMapper;
	@Autowired
	AtcBelongToMapper atcBelongToMapper;
	@Autowired
	DiseaseMapper diseaseMapper;
	@Autowired
	InstructionContraindicationMapper instructionContraindicationMapper;
	@Autowired
	InstructionIndicationMapper instructionIndicationMapper;
	
	@Autowired
	IndicationTherapeuticRegimenMapper indicationTherapeuticRegimenMapper;
	
	@Autowired
	DiseaseIcd10Mapper diseaseIcd10Mapper;
	
	@Autowired
	InstructionsCategoryMapper instructionsCategoryMapper;
	static String updateDate = null;
	static{
		updateDate = new SimpleDateFormat(
				org.skynet.frame.util.date.DateUtil.DATE_FORMAT_01)
				.format(new Date());
	}
	public static void main(String[] args){
	}

	private void printProccess(int totalCount, int currCount) {
		System.out.println(currCount + "/" + totalCount);
	}

	private static void initChuFangAllDrugs(String... filePath)
			throws InvalidOperationException, IOException, OpenXML4JException,
			ParserConfigurationException, SAXException {
		for (String fPath : filePath) {
			File file1 = new File(fPath);
			List<List<String>> recordsPart1 = ExcelReadUtil.getRecords(file1);
			int idx = 0;
			for (List<String> list : recordsPart1) {
				idx++;
				if (idx == 1)
					continue;
				String drugName = list.get(21);
				String form = list.get(22);
				String pack = list.get(24);
				Drug drug = new Drug();
				drug.setDrugCombinationName(new DrugCombinationName(drugName).getCombinationStandardName());
				drug.setForm(form);
				drug.setPack(pack);
				MongoUtil.saveBean("chufang_drug", drug);
//				allDrugs.add(drug);
			}
		}
		MongoUtil.addIndex("chufang_drug", "drugCombinationName", false);
	}
	public void initIcd10() {
		List<Document> documents = MongoUtil.findDocList("wechat_icd");
		int totalCount = MongoUtil.getCount("wechat_icd");
		int currCount = 0;
		for (Document document : documents) {
			String name = document.getString("name");
			String code = document.getString("code");
			String level = document.getString("level");
			String version = document.getString("version");
			Icd10 record = new Icd10();
			record.setName(name);
			record.setCode(code);
			record.setLevel(Integer.parseInt(level));
			record.setVersion(Resources.ICD_VERSION_MAP.get(version));
			icd10Mapper.insert(record);
			// System.out.println(currCount+++"/"+totalCount);
			printProccess(totalCount, currCount);
		}
	}

	@Override
	public void initAtcCode() {
		List<Document> documents = MongoUtil.findDocList("bysy_atc_code");
		for (Document document : documents) {
			String unit = document.getString("unit");
			String enName = document.getString("enName");
			String wayOfTaking = document.getString("wayOfTaking");
			String atcNo = document.getString("atcNo");
			String dosage = document.getString("dosage");
			String chName = document.getString("chName");
			AtcCode atcCode = new AtcCode();
			atcCode.setUnit(unit);
			atcCode.setEnName(enName);
			atcCode.setWayOfTaking(wayOfTaking);
			atcCode.setAtcNo(atcNo);
			atcCode.setDosage(dosage);
			atcCode.setChName(chName);
			atcCodeMapper.insert(atcCode);
		}
	}

	@Override
	public void initInstructions() {
		int totalCount = MongoUtil.getCount("dxy_app_drug_detail");
		int currCount = 0;
		
		List<Document> dxyAppDrugDetailList = MongoUtil
				.findDocList("dxy_app_drug_detail");
		for (Document dxyAppDrugDetailDoc : dxyAppDrugDetailList) {
			try {
				String cnName = DXYUtil.getString(dxyAppDrugDetailDoc, "商品名", true);
				String commonName = DXYUtil.getString(dxyAppDrugDetailDoc, "通用名",
						true);
				String engName = DXYUtil
						.getString(dxyAppDrugDetailDoc, "英文名", true);
				String otc = DXYUtil.getString(dxyAppDrugDetailDoc, "是否OTC", true);
				String standard = DXYUtil.getString(dxyAppDrugDetailDoc, "执行标准",
						true);
				String approveCode = DXYUtil.getString(dxyAppDrugDetailDoc, "批准文号",
						true);
				String approveDate = DXYUtil.getString(dxyAppDrugDetailDoc, "核准日期",
						true);
				String modifyDate = DXYUtil.getString(dxyAppDrugDetailDoc, "修改日期",
						true);
				String companyName = DXYUtil.getString(dxyAppDrugDetailDoc, "生产企业",
						true);
				String period = DXYUtil.getString(dxyAppDrugDetailDoc, "有效期", true);
				Instructions instructions = new Instructions();
				instructions.setApproveCode(approveCode);
				instructions.setApproveDate(approveDate);
				instructions.setCommodityName(cnName);
				instructions.setCommonName(commonName);
				instructions.setCompanyName(companyName);
				instructions.setEnName(engName);
				instructions.setModifyDate(modifyDate);

				
				Document doc = MongoUtil.findOne("chufang_drug", "drugCombinationName",new DrugCombinationName(cnName, commonName).getCombinationStandardName());
				if(doc!=null){
					 instructions.setPack(doc.getString("pack"));
					 instructions.setPreparation(doc.getString("form"));
				}
				if (otc == null) {
					instructions.setOtc(-1);
				} else if (otc.equals("否")) {
					instructions.setOtc(0);
				} else if (otc.equals("是")) {
					instructions.setOtc(1);
				}
				instructions.setPeriod(period);
				instructions.setSource("丁香园");
				instructions.setStandard(standard);
				instructions.setUpdateDate(updateDate);
				instructionsMapper.insert(instructions);
			} catch (Exception e) {
				e.printStackTrace();
			}
			printProccess(totalCount, currCount++);
		}
	}

	@Override
	public void initInstructionComponentAndInstructionComponentAtc() {
		List<Document> bysyDrugMajorConstituentList = MongoUtil
				.findDocList("bysy_drug_major_constituent");
		for (Document bysyDrugMajorConstituentDoc : bysyDrugMajorConstituentList) {
			String shangPinMing = bysyDrugMajorConstituentDoc.getString("shangPinMing");
			String tongYongMing = bysyDrugMajorConstituentDoc.getString("tongYongMing");
			String majorConstituent = bysyDrugMajorConstituentDoc.getString("major_constituent");
			List<Instructions> instructions =  instructionsMapper.selectByCommodityNameAndCommonName(shangPinMing, tongYongMing);
			if(instructions == null){
				System.out.println();
			}else{
				for (Instructions i : instructions) {
					String instructionId = i.getId();
					InstructionComponent record = new InstructionComponent();
					record.setInstructionId(instructionId);
					record.setComponentName(majorConstituent);
					record.setAccessoriesFlag(1);
					record.setCommodityName(shangPinMing);
					record.setCommonName(tongYongMing);
					instructionComponentMapper.insert(record);
					List<AtcCode> atcCodes = atcCodeMapper.selectByChName(majorConstituent);
					if(atcCodes!=null){
						for (AtcCode atcCode : atcCodes) {
							InstructionComponentAtc instructionComponentAtc = new InstructionComponentAtc();
							instructionComponentAtc.setAtcId(atcCode.getId());
							instructionComponentAtc.setAtcNo(atcCode.getAtcNo());
							instructionComponentAtc.setComponentId(record.getId());
							instructionComponentAtc.setComponentName(majorConstituent);
							instructionComponentAtcMapper.insert(instructionComponentAtc);
						}
					}
				}
			}
		}
	}

	@Override
	public void initInstructionsAtc() {
		List<Instruction> excelinstructions = InstructionsReadUtil.getInstructions();
		for (Instruction exInstruction : excelinstructions) {
			if(exInstruction.getAtcCode()==null || org.apache.commons.lang3.StringUtils.isBlank(exInstruction.getAtcCode().getAtcNo())){
				continue;
			}
			DrugCombinationName drugCombinationName = new DrugCombinationName(exInstruction.getDrugCombinationName());
			String shangPinMing = drugCombinationName.getShangPinName();
			String tongYongMing = drugCombinationName.getTongYongName();
			List<Instructions> dbInstructions =  instructionsMapper.selectByCommodityNameAndCommonName(shangPinMing, tongYongMing);
			for (Instructions dbInstruction : dbInstructions) {
				AtcCode atcCode = atcCodeMapper.findByAtcNo(exInstruction.getAtcCode().getAtcNo().toUpperCase());
				if(atcCode!=null){
					InstructionsAtc record = new InstructionsAtc();
					record.setAtcId(atcCode.getId());
					record.setAtcChName(atcCode.getChName());
					record.setAtcEnName(atcCode.getEnName());
					record.setAtcNo(atcCode.getAtcNo());
					record.setInstructionId(dbInstruction.getId());
					record.setCommodityName(dbInstruction.getCommodityName());
					record.setCommonName(dbInstruction.getCommonName());
					instructionsAtcMapper.insert(record);
				}
			}
		}
	}

	@Override
	public void initAtcConflict() {
		List<Document> documents = MongoUtil.findDocList("drugAtcInfoDDI");
		for (Document document : documents) {
			String drugAAtcNo = document.getString("drugAAtcNo");
			AtcCode atcCode = atcCodeMapper.findByAtcNo(drugAAtcNo);
			AtcConflict atcConflict = new AtcConflict();
			atcConflict.setAtcId(atcCode.getId());
			atcConflict.setAtcCode(atcCode.getAtcNo());
			atcConflict.setAtcName(atcCode.getChName());
			
			String drugBAtcNo = document.getString("drugBAtcNo");
			if(drugBAtcNo == null){
				continue;
			}
			AtcCode conflictAtcCode = atcCodeMapper.findByAtcNo(drugBAtcNo);
			atcConflict.setConflictAtcId(conflictAtcCode.getId());
			atcConflict.setConflictAtcCode(conflictAtcCode.getAtcNo());
			atcConflict.setConflictAtcName(conflictAtcCode.getChName());
			atcConflictMapper.insert(atcConflict);
		}
	}

	@Override
	public void initAtcBelongTo() {
		List<AtcCode> atcCodes = atcCodeMapper.selectAll();
		List<String> errorAtcCodes = new ArrayList<String>();
		for (AtcCode atcCode : atcCodes) {
			String atcNo = atcCode.getAtcNo();
			String atcParentNo = ATCUtil.getATCCodeParentByAtcCode(atcNo);
			if(atcParentNo == null){
				AtcBelongTo atcBelongTo = new AtcBelongTo();
				atcBelongTo.setAtcCode(atcCode.getAtcNo());
				atcBelongTo.setAtcId(atcCode.getId());
				atcBelongTo.setAtcName(atcCode.getChName());
				atcBelongTo.setAtcLevel(ATCUtil.getAtcNoLevel(atcCode.getAtcNo()));
				atcBelongTo.setAtcParentCode(null);
				atcBelongTo.setAtcParentId(null);
				atcBelongTo.setAtcParentName(null);
				atcBelongTo.setAtcParentLevel(null);
				atcBelongToMapper.insert(atcBelongTo);
				continue;
			}
			boolean match = false;
			for (AtcCode atcEachCode : atcCodes) {
				if(atcEachCode.getAtcNo().equals(atcParentNo)){
					match = true;
					AtcBelongTo atcBelongTo = new AtcBelongTo();
					atcBelongTo.setAtcCode(atcCode.getAtcNo());
					atcBelongTo.setAtcId(atcCode.getId());
					atcBelongTo.setAtcName(atcCode.getChName());
					atcBelongTo.setAtcLevel(ATCUtil.getAtcNoLevel(atcCode.getAtcNo()));
					
					atcBelongTo.setAtcParentCode(atcEachCode.getAtcNo());
					atcBelongTo.setAtcParentId(atcEachCode.getId());
					atcBelongTo.setAtcParentName(atcEachCode.getChName());
					atcBelongTo.setAtcParentLevel(ATCUtil.getAtcNoLevel(atcEachCode.getAtcNo()));
					atcBelongToMapper.insert(atcBelongTo);
				}
			}
			if(!match){
				errorAtcCodes.add(atcNo);
			}
		}
		try {
			org.apache.commons.io.FileUtils.writeLines(new File("C://errorAtcCodes.txt"), errorAtcCodes);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void initDisease() {
		int totalCount = MongoUtil.getCount("bysy_chufang_drug_disease");
		int currCount = 0;
		//org.apache.commons.lang3.StringUtils.removeEnd(contraindication.trim(), "？")
		List<Document> documents = MongoUtil.findDocList("bysy_chufang_drug_disease");
		for (Document document : documents) {
			String disease = document.getString("disease");
			String[] diseaseArr = disease.split("；|;|,| ");
			for (String diseaseEach : diseaseArr) {
				Disease record = new Disease();
				record.setDisName(org.apache.commons.lang3.StringUtils.removeEnd(diseaseEach.trim(), "？"));
				record.setLastUpdateTime(updateDate);
				try {
					diseaseMapper.insert(record);
				} catch (Exception e) {
//					System.out.println(e.getMessage());
				}
				printProccess(totalCount, ++currCount);
			}
		}
	}
	
	@Override
	public void initInstructionContraindication() {
		List<Instruction> excelinstructions = InstructionsReadUtil.getInstructions();
		for (Instruction exInstruction : excelinstructions) {
			
			DrugCombinationName drugCombinationName = new DrugCombinationName(exInstruction.getDrugCombinationName());
			String shangPinMing = drugCombinationName.getShangPinName();
			String tongYongMing = drugCombinationName.getTongYongName();
			List<Instructions> dbInstructions =  instructionsMapper.selectByCommodityNameAndCommonName(shangPinMing, tongYongMing);
			for (Instructions dbInstruction : dbInstructions) {
				InstructionContraindication record = new InstructionContraindication();
				
				record.setInstructionId(dbInstruction.getId());
				record.setCommodityName(dbInstruction.getCommodityName());
				record.setCommonName(dbInstruction.getCommonName());
				List<String> contraindications = exInstruction.getContraindications();
				for (String contraindication : contraindications) {
					Disease disease = diseaseMapper.selectByDiseaseName(contraindication);
					if(disease == null){
						Disease dis = new Disease();
						dis.setDisName(contraindication);
						dis.setLastUpdateTime(updateDate);
					    diseaseMapper.insert(dis);
					    disease = dis;
					}
					record.setContraindicationId(disease.getId());
					record.setDiseaseName(disease.getDisName());
					record.setDiseaseAliasName(disease.getAliasName());
					instructionContraindicationMapper.insert(record);
				}
				
			}
		}
	}

	@Override
	public void initInstructionIndication() {
		List<Instruction> excelinstructions = InstructionsReadUtil.getInstructions();
		for (Instruction exInstruction : excelinstructions) {
			
			DrugCombinationName drugCombinationName = new DrugCombinationName(exInstruction.getDrugCombinationName());
			String shangPinMing = drugCombinationName.getShangPinName();
			String tongYongMing = drugCombinationName.getTongYongName();
			List<Instructions> dbInstructions =  instructionsMapper.selectByCommodityNameAndCommonName(shangPinMing, tongYongMing);
			for (Instructions dbInstruction : dbInstructions) {
				InstructionIndication record = new InstructionIndication();
				
				record.setInstructionId(dbInstruction.getId());
				record.setCommodityName(dbInstruction.getCommodityName());
				record.setCommonName(dbInstruction.getCommonName());
				List<String> diagnosises = exInstruction.getDiagnosises();
				for (String indication : diagnosises) {
					Disease disease = diseaseMapper.selectByDiseaseName(indication);
					if(disease == null){
						Disease dis = new Disease();
						dis.setDisName(indication);
						dis.setLastUpdateTime(updateDate);
					    diseaseMapper.insert(dis);
					    disease = dis;
					}
					record.setIndicationId(disease.getId());
					record.setIndicationName(disease.getDisName());
					record.setIndicationAliasName(disease.getAliasName());
					instructionIndicationMapper.insert(record);
				}
			}
		}
	}
	@Override
	public void initTherapeuticRegimen() {
		List<Instruction> excelinstructions = InstructionsReadUtil.getInstructions();
		
		for (Instruction  exInstruction : excelinstructions) {
			List<String> diagnosises = exInstruction.getDiagnosises();
			for (String diagnosise : diagnosises) {
				DrugCombinationName drugCombinationName = new DrugCombinationName(exInstruction.getDrugCombinationName());
				InstructionIndication instructionIndicationCondition = new InstructionIndication();
				instructionIndicationCondition.setIndicationName(diagnosise);
				instructionIndicationCondition.setCommodityName(drugCombinationName.getShangPinName());
				instructionIndicationCondition.setCommonName(drugCombinationName.getTongYongName());
				InstructionIndication insIndicationResult = instructionIndicationMapper.selectByInstructionIndication(instructionIndicationCondition);
				List<InstructionUse> instructionUses = exInstruction.getInstructionUses();
				for (InstructionUse instructionUse : instructionUses) {
					IndicationTherapeuticRegimen therapeuticRegimen = new IndicationTherapeuticRegimen();
					therapeuticRegimen.setDosage(instructionUse.getDosage());
					therapeuticRegimen.setDosageUnit(instructionUse.getDosageUnit());
					therapeuticRegimen.setDosageFrequency(instructionUse.getDosingFrequency());
					therapeuticRegimen.setCourseRestriction(instructionUse.getCourseControl());
					therapeuticRegimen.setDoseSelection(instructionUse.getDoseSelection());
					therapeuticRegimen.setIndicationId(insIndicationResult.getIndicationId());
					therapeuticRegimen.setIndicationName(diagnosise);
					therapeuticRegimen.setCommodityName(insIndicationResult.getCommodityName());
					therapeuticRegimen.setCommonName(insIndicationResult.getCommonName());
					therapeuticRegimen.setInstructionId(insIndicationResult.getInstructionId());
					therapeuticRegimen.setPatientStatus(instructionUse.getPatientStatus());
					therapeuticRegimen.setRouteMedication(instructionUse.getRouteOfMedication());
					indicationTherapeuticRegimenMapper.insert(therapeuticRegimen);
				}
			}
		}
	}


	@Override
	public void initDiseaseIcd10() {
		List<Disease> diseases = diseaseMapper.findAll();
		for (Disease d : diseases) {
			Document doc = MongoUtil.findOne("bysy_drug_syz_final","shiYingZheng",d.getDisName());
			if(doc == null) continue;
			String code = doc.getString("code");
//			String version = doc.getString("version");
			Icd10 icd10 = new Icd10();
			icd10.setCode(code);
			List<Icd10> icd10s = icd10Mapper.findByIcd10(icd10);
			for (Icd10 icd10Result : icd10s) {
				DiseaseIcd10 diseaseIcd10 = new DiseaseIcd10();
				diseaseIcd10.setDiseaseId(d.getId());
				diseaseIcd10.setDiseaseName(d.getDisName());
				diseaseIcd10.setIcd10Code(icd10Result.getCode());
				diseaseIcd10.setIcd10Name(icd10Result.getName());
				diseaseIcd10.setIcd10Id(icd10Result.getId());
				diseaseIcd10.setIcd10Version(icd10Result.getVersion());
				diseaseIcd10Mapper.insert(diseaseIcd10);
			}
		}
	}

	@Override
	public void initIcd10BelongTo() {
	}

	@Override
	public void initInstructionsCategory() {
		List<Document> yiMaiTongFinalStandardDocs = MongoUtil.findDocList("yiMaiTongFinalStandard");
		for (Document doc : yiMaiTongFinalStandardDocs) {
			String combinationStandardName = doc.getString("combinationStandardName");
			String shangPinMing = doc.getString("shangPinMing");
			String tongYongMing = doc.getString("tongYongMing");
			String category = doc.getString("category");
			List<Instructions> instructions = instructionsMapper.selectByCommodityNameAndCommonName(shangPinMing, tongYongMing);
			if(instructions!=null){
				for (Instructions ins : instructions) {
					InstructionsCategory record = new InstructionsCategory();
					record.setCombinationStandardName(combinationStandardName);
					record.setCommodityName(shangPinMing);
					record.setCommonName(tongYongMing);
					record.setInstructionId(ins.getId());
					record.setCategory(category);
					record.setLastUpdateTime(updateDate);
					instructionsCategoryMapper.insert(record);
				}
			}
		}
	}
}
