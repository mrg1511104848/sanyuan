package org.beiyi.service.db.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

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
	@Autowired
	PrescriptionDistributionRecordMapper prescriptionDistributionRecordMapper;
	@Autowired
	UserMapper userMapper;
	@Override
	public void savePrescriptionDistributionRecord(String prescriptionNo) {
		List<User> users = userMapper.findUserByCondition(null);
		Random r = new Random(users.size());
		
		String time = new SimpleDateFormat(DateUtil.DATE_FORMAT_01)
				.format(new Date());
		//分配到药师
		PrescriptionDistributionRecord distributionRecord = new PrescriptionDistributionRecord();
		distributionRecord.setPrescriptionNo(prescriptionNo);
		distributionRecord.setDistributionPersonId(users.get(r.nextInt()).getId());
		distributionRecord.setDistributionTime(time);
		prescriptionDistributionRecordMapper.insert(distributionRecord);
	}
}
