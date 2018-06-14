package org.beiyi.datadeal.entity;

import org.skynet.frame.annotation.Path;
import org.skynet.frame.base.SkynetEntity;

public class DrugfutureSupplementBySFDA extends SkynetEntity{
	@Path(value="tr:contains(剂型) td:eq(1)")
	private String JiXing;
	@Path(value="tr:contains(英文名称) td:eq(1)")
	private String enProductName;
	@Path(value="tr:contains(原批准文号) td:eq(1)")
	private String oldPiZhunWenHao;
	@Path(value="tr:contains(药品本位码备注) td:eq(1)")
	private String benWeiMaDesc;
	@Path(value="tr:contains(规格) td:eq(1)")
	private String guiGe;
	@Path(value="tr:contains(批准日期) td:eq(1)")
	private String piZhunRiQi;
	@Path(value="tr:contains(产品类别) td:eq(1)")
	private String type;
	@Path(value="tr:contains(批准文号) td:eq(1)")
	private String piZhunWenHao;
	@Path(value="tr:contains(药品本位码) td:eq(1)")
	private String benWeiMa;
	@Path(value="tr:contains(生产地址) td:eq(1)")
	private String manufactureAddress;
	@Path(value="tr:contains(产品名称) td:eq(1)")
	private String productName;
	@Path(value="tr:contains(生产单位) td:eq(1)")
	private String manufactureFactory;
	@Path(value="tr:contains(商品名) td:eq(1)")
	private String goodsName;
	public String getJiXing() {
		return JiXing;
	}
	public void setJiXing(String jiXing) {
		JiXing = jiXing;
	}
	public String getEnProductName() {
		return enProductName;
	}
	public void setEnProductName(String enProductName) {
		this.enProductName = enProductName;
	}
	public String getOldPiZhunWenHao() {
		return oldPiZhunWenHao;
	}
	public void setOldPiZhunWenHao(String oldPiZhunWenHao) {
		this.oldPiZhunWenHao = oldPiZhunWenHao;
	}
	public String getBenWeiMaDesc() {
		return benWeiMaDesc;
	}
	public void setBenWeiMaDesc(String benWeiMaDesc) {
		this.benWeiMaDesc = benWeiMaDesc;
	}
	public String getGuiGe() {
		return guiGe;
	}
	public void setGuiGe(String guiGe) {
		this.guiGe = guiGe;
	}
	public String getPiZhunRiQi() {
		return piZhunRiQi;
	}
	public void setPiZhunRiQi(String piZhunRiQi) {
		this.piZhunRiQi = piZhunRiQi;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPiZhunWenHao() {
		return piZhunWenHao;
	}
	public void setPiZhunWenHao(String piZhunWenHao) {
		this.piZhunWenHao = piZhunWenHao;
	}
	public String getBenWeiMa() {
		return benWeiMa;
	}
	public void setBenWeiMa(String benWeiMa) {
		this.benWeiMa = benWeiMa;
	}
	public String getManufactureAddress() {
		return manufactureAddress;
	}
	public void setManufactureAddress(String manufactureAddress) {
		this.manufactureAddress = manufactureAddress;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getManufactureFactory() {
		return manufactureFactory;
	}
	public void setManufactureFactory(String manufactureFactory) {
		this.manufactureFactory = manufactureFactory;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
}
