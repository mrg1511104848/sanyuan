package org.beiyi.dao;

import org.beiyi.entity.db.InstructionsAtc;

public interface InstructionsAtcMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instructions_atc
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instructions_atc
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    int insert(InstructionsAtc record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instructions_atc
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    int insertSelective(InstructionsAtc record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instructions_atc
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    InstructionsAtc selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instructions_atc
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    int updateByPrimaryKeySelective(InstructionsAtc record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instructions_atc
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    int updateByPrimaryKey(InstructionsAtc record);
}