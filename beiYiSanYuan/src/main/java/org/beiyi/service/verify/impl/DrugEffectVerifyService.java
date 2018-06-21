package org.beiyi.service.verify.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.VerifyResult;
import org.beiyi.entity.verify.ChuFang;
import org.beiyi.entity.verify.ChuFangCheckRecord;
import org.beiyi.entity.verify.Drug;
import org.beiyi.entity.verify.DrugVerifyInfo;
import org.beiyi.service.verify.itr.IDrugVeryfy;
import org.bson.Document;
import org.skynet.frame.util.StringBufferUtil;
import org.skynet.frame.util.mongo.MongoUtil;

/**
 * 药品间的相互作用审核
 * 
 * @author 2bu
 *
 */
public class DrugEffectVerifyService implements IDrugVeryfy {

	@Override
	public VerifyResult verify(ChuFang chuFang,
			VerifyResult lastStepVerifyResult) {
		VerifyResult verifyResult = new VerifyResult();
		StringBuffer errorMsgSb = new StringBuffer();
		List<Drug> chuFangDrugVerifingList = chuFang.getOldDrugs();// 需要遍历处方中的药品，查看两两药品间有没有相互作用
		for (int i = 0; i < chuFangDrugVerifingList.size(); i++) {
			Drug drugI = chuFangDrugVerifingList.get(i);
			DrugCombinationName drugCombinationNameI = new DrugCombinationName(
					drugI.getDrugCombinationName());
			String tongYongNameI = drugCombinationNameI
					.getTongYongName();
			List<DrugAndEffectLevel> drugIEffectDrugAndEffectLevels = new ArrayList<DrugAndEffectLevel>();
			for (int j = i + 1; j < chuFangDrugVerifingList.size(); j++) {
				Drug drugJ = chuFangDrugVerifingList.get(j);
				DrugCombinationName drugCombinationNameJ = new DrugCombinationName(
						drugJ.getDrugCombinationName());
				String tongYongNameJ = drugCombinationNameJ
						.getTongYongName();

				Map<String, Object> query = new HashMap<String, Object>();
				Map<String, Object> or1 = new HashMap<String, Object>();
				Map<String, Object> or2 = new HashMap<String, Object>();

				System.out.println(tongYongNameI+"-"+tongYongNameJ);
				if(tongYongNameI.equals("卡托普利片") && tongYongNameJ.equals("硫唑嘌呤片")){
					System.out.println();
				}
				or1.put("dxyDrugATongYongMing", tongYongNameI);
				or1.put("dxyDrugBTongYongMing", tongYongNameJ);

				or2.put("dxyDrugATongYongMing", tongYongNameJ);
				or2.put("dxyDrugBTongYongMing", tongYongNameI);

				List<Object> orList = new ArrayList<Object>();
				orList.add(or1);
				orList.add(or2);
				query.put("$or", orList);

				Document doc = MongoUtil.findOne("drugAtcInfoDDIWithDXY", query);
				if (doc != null) {
					String level = doc.getString("level");
					DrugAndEffectLevel drugAndEffectLevel = new DrugAndEffectLevel();
					drugAndEffectLevel
							.setCombinationNameI(drugCombinationNameI);
					drugAndEffectLevel
							.setCombinationNameJ(drugCombinationNameJ);
					drugAndEffectLevel.setLevel(level);
					drugIEffectDrugAndEffectLevels.add(drugAndEffectLevel);
					
					verifyResult.getErrorDrugs().add(new DrugVerifyInfo(drugI));
					verifyResult.getErrorDrugs().add(new DrugVerifyInfo(drugJ));
					continue;
				}
			}
			StringBuffer drugCombinationNameJBuffer = new StringBuffer();
			for (DrugAndEffectLevel drugAndEffectLevel : drugIEffectDrugAndEffectLevels) {
				DrugCombinationName drugCombinationNameJ = drugAndEffectLevel
						.getCombinationNameJ();
				drugCombinationNameJBuffer.append(drugCombinationNameJ
						.getCombinationStandardName() + "("+drugAndEffectLevel.getLevel()+")，");
			}
			if (drugIEffectDrugAndEffectLevels != null
					&& drugIEffectDrugAndEffectLevels.size() > 0) {
				errorMsgSb.append(String.format(
						"药品“%s”与 药品 “%s” 存在相互作用，", drugCombinationNameI
								.getCombinationStandardName(), StringBufferUtil
								.removeEnd(drugCombinationNameJBuffer, "，")));
			}
		}
		if(StringUtils.isBlank(errorMsgSb)){
			verifyResult.setSuccess(true);
		}else{
			verifyResult.setSuccess(false);
			verifyResult.setResultMsg(errorMsgSb.toString());
		}
		return verifyResult;
	}

	static class DrugAndEffectLevel {
		private DrugCombinationName combinationNameI;
		private DrugCombinationName combinationNameJ;
		private String level;

		public DrugCombinationName getCombinationNameI() {
			return combinationNameI;
		}

		public void setCombinationNameI(DrugCombinationName combinationNameI) {
			this.combinationNameI = combinationNameI;
		}

		public DrugCombinationName getCombinationNameJ() {
			return combinationNameJ;
		}

		public void setCombinationNameJ(DrugCombinationName combinationNameJ) {
			this.combinationNameJ = combinationNameJ;
		}

		public String getLevel() {
			return level;
		}

		public void setLevel(String level) {
			this.level = level;
		}
	}

	@Override
	public String appendErrors(Drug chuFangDrug, List<ChuFangCheckRecord> errors) {
		// TODO Auto-generated method stub
		return null;
	}
}
