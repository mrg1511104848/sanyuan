package org.beiyi.dao;

import org.beiyi.entity.db.InstructionComponent;

public interface InstructionComponentMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_component
     *
     * @mbggenerated Thu Jul 05 14:29:40 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_component
     *
     * @mbggenerated Thu Jul 05 14:29:40 CST 2018
     */
    int insert(InstructionComponent record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_component
     *
     * @mbggenerated Thu Jul 05 14:29:40 CST 2018
     */
    int insertSelective(InstructionComponent record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_component
     *
     * @mbggenerated Thu Jul 05 14:29:40 CST 2018
     */
    InstructionComponent selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_component
     *
     * @mbggenerated Thu Jul 05 14:29:40 CST 2018
     */
    int updateByPrimaryKeySelective(InstructionComponent record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_component
     *
     * @mbggenerated Thu Jul 05 14:29:40 CST 2018
     */
    int updateByPrimaryKey(InstructionComponent record);
}