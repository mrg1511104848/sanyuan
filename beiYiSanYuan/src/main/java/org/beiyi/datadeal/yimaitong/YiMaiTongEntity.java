package org.beiyi.datadeal.yimaitong;

import java.util.List;

import org.skynet.frame.annotation.Path;
import org.skynet.frame.base.SkynetEntity;

public class YiMaiTongEntity extends SkynetEntity{
	@Path(value = ".medicine-title+div a[href^=drugref/drugCate.do]", attr = "href" ,needSave=false)
	private List<String> urlList;
	@Path(value = ".medicine-title+div a[href^=drugref/drugCate.do]" ,needSave=false)
	private List<String> titleList;
	@Path(value = ".search-content a[href^=drugref/html]",attr="href"  ,needSave=false)
	private List<String> detailHrefList;
	@Path(value="a[title=下一页]",attr="href",needAbsolutePath=true,needSave=false)
	private String nextPageUrl;
	private String listUrl;
	@Path(value=".blue-left-white")
	private String type;
	private int pageNo;
	
	@Path(value=".more-infomation p:eq(0)")
	private String medicineName;
	public List<String> getUrlList() {
		return urlList;
	}

	public void setUrlList(List<String> urlList) {
		this.urlList = urlList;
	}

	public List<String> getTitleList() {
		return titleList;
	}

	public void setTitleList(List<String> titleList) {
		this.titleList = titleList;
	}

	public String getNextPageUrl() {
		return nextPageUrl;
	}

	public void setNextPageUrl(String nextPageUrl) {
		this.nextPageUrl = nextPageUrl;
	}

	public List<String> getDetailHrefList() {
		return detailHrefList;
	}

	public void setDetailHrefList(List<String> detailHrefList) {
		this.detailHrefList = detailHrefList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getListUrl() {
		return listUrl;
	}

	public void setListUrl(String listUrl) {
		this.listUrl = listUrl;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String getMedicineName() {
		return medicineName;
	}

	public void setMedicineName(String medicineName) {
		this.medicineName = medicineName;
	}
}
