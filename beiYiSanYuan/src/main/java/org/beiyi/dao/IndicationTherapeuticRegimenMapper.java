package org.beiyi.dao;

import org.beiyi.entity.db.IndicationTherapeuticRegimen;

public interface IndicationTherapeuticRegimenMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table indication_therapeutic_regimen
     *
     * @mbggenerated Tue Jul 10 14:39:32 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table indication_therapeutic_regimen
     *
     * @mbggenerated Tue Jul 10 14:39:32 CST 2018
     */
    int insert(IndicationTherapeuticRegimen record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table indication_therapeutic_regimen
     *
     * @mbggenerated Tue Jul 10 14:39:32 CST 2018
     */
    int insertSelective(IndicationTherapeuticRegimen record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table indication_therapeutic_regimen
     *
     * @mbggenerated Tue Jul 10 14:39:32 CST 2018
     */
    IndicationTherapeuticRegimen selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table indication_therapeutic_regimen
     *
     * @mbggenerated Tue Jul 10 14:39:32 CST 2018
     */
    int updateByPrimaryKeySelective(IndicationTherapeuticRegimen record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table indication_therapeutic_regimen
     *
     * @mbggenerated Tue Jul 10 14:39:32 CST 2018
     */
    int updateByPrimaryKey(IndicationTherapeuticRegimen record);
}