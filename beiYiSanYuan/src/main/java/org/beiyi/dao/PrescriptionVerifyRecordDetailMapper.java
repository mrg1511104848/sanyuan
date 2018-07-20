package org.beiyi.dao;

import java.util.List;

import org.beiyi.entity.db.PrescriptionVerifyRecordDetail;

public interface PrescriptionVerifyRecordDetailMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_detail
     *
     * @mbggenerated Fri Jul 20 10:21:17 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_detail
     *
     * @mbggenerated Fri Jul 20 10:21:17 CST 2018
     */
    int insert(PrescriptionVerifyRecordDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_detail
     *
     * @mbggenerated Fri Jul 20 10:21:17 CST 2018
     */
    int insertSelective(PrescriptionVerifyRecordDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_detail
     *
     * @mbggenerated Fri Jul 20 10:21:17 CST 2018
     */
    PrescriptionVerifyRecordDetail selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_detail
     *
     * @mbggenerated Fri Jul 20 10:21:17 CST 2018
     */
    int updateByPrimaryKeySelective(PrescriptionVerifyRecordDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table prescription_verify_record_detail
     *
     * @mbggenerated Fri Jul 20 10:21:17 CST 2018
     */
    int updateByPrimaryKey(PrescriptionVerifyRecordDetail record);

	List<PrescriptionVerifyRecordDetail> getPagedList(String string);
}