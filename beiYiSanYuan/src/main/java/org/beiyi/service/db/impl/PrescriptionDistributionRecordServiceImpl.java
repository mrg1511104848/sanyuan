package org.beiyi.service.db.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.beiyi.dao.PrescriptionDistributionRecordMapper;
import org.beiyi.dao.UserMapper;
import org.beiyi.entity.db.PrescriptionDistributionRecord;
import org.beiyi.entity.db.User;
import org.beiyi.service.db.itr.IPrescriptionDistributionRecordService;
import org.skynet.frame.util.date.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PrescriptionDistributionRecordServiceImpl implements
		IPrescriptionDistributionRecordService {
	private Logger log = Logger
			.getLogger(PrescriptionDistributionRecordServiceImpl.class);
	@Autowired
	PrescriptionDistributionRecordMapper prescriptionDistributionRecordMapper;
	@Autowired
	UserMapper userMapper;

	@Override
	public void savePrescriptionDistributionRecord(String prescriptionNo) {
		User user = userMapper.getRandomUser(null);

		String time = new SimpleDateFormat(DateUtil.DATE_FORMAT_01)
				.format(new Date());
		if (user == null) {
			log.warn("User is null!");
			return;
		}
		// 分配到药师
		PrescriptionDistributionRecord distributionRecord = new PrescriptionDistributionRecord();
		distributionRecord.setPrescriptionNo(prescriptionNo);
		distributionRecord.setDistributionPersonId(user.getId());
		distributionRecord.setDistributionTime(time);
		prescriptionDistributionRecordMapper.insert(distributionRecord);

	}

	@Override
	public List<Integer> getDistributionStatistics(String distributionPersonId) {
		return prescriptionDistributionRecordMapper.getDistributionStatistics(distributionPersonId);
	}
}
