package org.beiyi.service.db.impl;

import java.util.List;

import org.beiyi.dao.AtcCodeMapper;
import org.beiyi.dao.Icd10Mapper;
import org.beiyi.entity.db.AtcCode;
import org.beiyi.entity.db.Icd10;
import org.beiyi.reource.Resources;
import org.beiyi.service.db.itr.IMysqlDataInitService;
import org.bson.Document;
import org.skynet.frame.util.mongo.MongoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MysqlDataInitServiceImpl implements IMysqlDataInitService {
	@Autowired
	Icd10Mapper icd10Mapper;
	@Autowired
	AtcCodeMapper atcCodeMapper;

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
			System.out.println(currCount+++"/"+totalCount);
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
}
