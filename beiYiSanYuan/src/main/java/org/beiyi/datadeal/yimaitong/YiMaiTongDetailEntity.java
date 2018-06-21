package org.beiyi.datadeal.yimaitong;

import java.util.List;

import org.skynet.frame.annotation.Path;
import org.skynet.frame.base.SkynetEntity;

public class YiMaiTongDetailEntity extends SkynetEntity{
	@Path(value = ".blue-bar")
	private String name;
	@Path(value = ".info-content .title")
	private List<String> titleList;
	@Path(value = ".info-content .more-infomation")
	private List<String> moreInfomationList;
	@Path(value = ".info-content .more-infomation",useText=false)
	private List<String> moreInfomationListHtm;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String> getTitleList() {
		return titleList;
	}

	public void setTitleList(List<String> titleList) {
		this.titleList = titleList;
	}

	public List<String> getMoreInfomationList() {
		return moreInfomationList;
	}

	public void setMoreInfomationList(List<String> moreInfomationList) {
		this.moreInfomationList = moreInfomationList;
	}

	public List<String> getMoreInfomationListHtm() {
		return moreInfomationListHtm;
	}

	public void setMoreInfomationListHtm(List<String> moreInfomationListHtm) {
		this.moreInfomationListHtm = moreInfomationListHtm;
	}

}
