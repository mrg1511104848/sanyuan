package org.beiyi.dao;

import org.beiyi.entity.db.PrescriptionDistributionRecord;

public interface PrescriptionDistributionRecordMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_distribution_record
     *
     * @mbggenerated Tue Jul 31 16:47:18 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_distribution_record
     *
     * @mbggenerated Tue Jul 31 16:47:18 CST 2018
     */
    int insert(PrescriptionDistributionRecord record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_distribution_record
     *
     * @mbggenerated Tue Jul 31 16:47:18 CST 2018
     */
    int insertSelective(PrescriptionDistributionRecord record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_distribution_record
     *
     * @mbggenerated Tue Jul 31 16:47:18 CST 2018
     */
    PrescriptionDistributionRecord selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_distribution_record
     *
     * @mbggenerated Tue Jul 31 16:47:18 CST 2018
     */
    int updateByPrimaryKeySelective(PrescriptionDistributionRecord record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_distribution_record
     *
     * @mbggenerated Tue Jul 31 16:47:18 CST 2018
     */
    int updateByPrimaryKey(PrescriptionDistributionRecord record);
}