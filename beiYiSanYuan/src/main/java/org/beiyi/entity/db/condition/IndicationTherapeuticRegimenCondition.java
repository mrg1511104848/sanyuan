package org.beiyi.entity.db.condition;

import java.util.List;

import org.beiyi.entity.db.IndicationTherapeuticRegimen;

public class IndicationTherapeuticRegimenCondition extends IndicationTherapeuticRegimen{
	private List<String> indications;//适应症

	public List<String> getIndications() {
		return indications;
	}

	public void setIndications(List<String> indications) {
		this.indications = indications;
	}
}
