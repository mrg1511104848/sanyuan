package org.beiyi.entity.verify;
/**
 * 药品的分类 如 属于 化药及生物制品 >> 抗微生物药 >> 抗细菌药 >> 抗生素类
 * @author 2bu
 *
 */
public class DrugCategory {
	private String source; //药品类别的来源 ， 如 来源于医脉通
	private String categoryName;//药品的类别
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((categoryName == null) ? 0 : categoryName.hashCode());
		result = prime * result + ((source == null) ? 0 : source.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DrugCategory other = (DrugCategory) obj;
		if (categoryName == null) {
			if (other.categoryName != null)
				return false;
		} else if (!categoryName.equals(other.categoryName))
			return false;
		if (source == null) {
			if (other.source != null)
				return false;
		} else if (!source.equals(other.source))
			return false;
		return true;
	}
}
