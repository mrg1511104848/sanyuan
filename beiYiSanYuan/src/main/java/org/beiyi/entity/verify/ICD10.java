package org.beiyi.entity.verify;
/**
 * icd10实体
 * @author mrg
 *
 */
public class ICD10 {
	private String code;
	private String name;
	private String nameEn;
	private String version;
	private String parentName ;
	private String parentNameEn ;
	private String parentCode ;
	public ICD10() {
		super();
	}
	public ICD10(String code, String name, String nameEn, String version) {
		super();
		this.code = code;
		this.name = name;
		this.nameEn = nameEn;
		this.version = version;
	}
	public ICD10(String code, String name, String nameEn, String version,
			String parentName, String parentNameEn, String parentCode) {
		super();
		this.code = code;
		this.name = name;
		this.nameEn = nameEn;
		this.version = version;
		this.parentName = parentName;
		this.parentNameEn = parentNameEn;
		this.parentCode = parentCode;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNameEn() {
		return nameEn;
	}
	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getParentNameEn() {
		return parentNameEn;
	}
	public void setParentNameEn(String parentNameEn) {
		this.parentNameEn = parentNameEn;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
}
