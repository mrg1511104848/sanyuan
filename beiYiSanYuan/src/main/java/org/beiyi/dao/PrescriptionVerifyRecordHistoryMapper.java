package org.beiyi.dao;

import org.beiyi.entity.db.PrescriptionVerifyRecordHistory;

public interface PrescriptionVerifyRecordHistoryMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_history
     *
     * @mbggenerated Tue Jul 24 15:51:39 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_history
     *
     * @mbggenerated Tue Jul 24 15:51:39 CST 2018
     */
    int insert(PrescriptionVerifyRecordHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_history
     *
     * @mbggenerated Tue Jul 24 15:51:39 CST 2018
     */
    int insertSelective(PrescriptionVerifyRecordHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_history
     *
     * @mbggenerated Tue Jul 24 15:51:39 CST 2018
     */
    PrescriptionVerifyRecordHistory selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_history
     *
     * @mbggenerated Tue Jul 24 15:51:39 CST 2018
     */
    int updateByPrimaryKeySelective(PrescriptionVerifyRecordHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_history
     *
     * @mbggenerated Tue Jul 24 15:51:39 CST 2018
     */
    int updateByPrimaryKey(PrescriptionVerifyRecordHistory record);
}