package org.beiyi.service.db.impl;

import org.beiyi.dao.InstructionsMapper;
import org.beiyi.entity.DrugCombinationName;
import org.beiyi.entity.db.Instructions;
import org.beiyi.service.db.itr.IInstructionsReadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class InstructionsReadServiceImpl implements IInstructionsReadService {
	@Autowired
	InstructionsMapper instructionMapper;
	@Override
	public Instructions getByInstructions(Instructions instructions) {
		Instructions instruction = instructionMapper.selectByInstruction(instructions);
		//TODO 获取说明书
		return instruction;
	}

	@Override
	public boolean contains(String drugCombinationName) {
		DrugCombinationName combinationName = new DrugCombinationName(drugCombinationName);
		String shangPinName = combinationName.getShangPinName();
		String tongYongName = combinationName.getTongYongName();
		Instructions instructions = new Instructions();
		instructions.setCommodityName(shangPinName);
		instructions.setCommonName(tongYongName);
		return instructionMapper.getCount(instructions)>0;
	}


}
