package org.beiyi.service.db.itr;

import org.beiyi.entity.db.Instructions;


public interface IInstructionsReadService {
	public Instructions getByInstructions(Instructions instructions);
	public boolean contains(String drugCombinationName);
}
