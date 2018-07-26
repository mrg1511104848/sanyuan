package org.beiyi.entity.db.pageBean;

import java.util.List;

public class PrescriptionVerifyRecord extends org.beiyi.entity.db.PrescriptionVerifyRecord{
	
	private List<Integer> verifyProgressList;
	
	private String verifyProgressStr;

	public List<Integer> getVerifyProgressList() {
		return verifyProgressList;
	}

	public void setVerifyProgressList(List<Integer> verifyProgressList) {
		this.verifyProgressList = verifyProgressList;
	}

	public String getVerifyProgressStr() {
		return verifyProgressStr;
	}

	public void setVerifyProgressStr(String verifyProgressStr) {
		this.verifyProgressStr = verifyProgressStr;
	}
	
}
