package org.beiyi.dao;

import java.util.List;

import org.beiyi.entity.db.InstructionContraindication;

public interface InstructionContraindicationMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_contraindication
     *
     * @mbggenerated Thu Jul 05 17:04:13 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_contraindication
     *
     * @mbggenerated Thu Jul 05 17:04:13 CST 2018
     */
    int insert(InstructionContraindication record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_contraindication
     *
     * @mbggenerated Thu Jul 05 17:04:13 CST 2018
     */
    int insertSelective(InstructionContraindication record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_contraindication
     *
     * @mbggenerated Thu Jul 05 17:04:13 CST 2018
     */
    InstructionContraindication selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_contraindication
     *
     * @mbggenerated Thu Jul 05 17:04:13 CST 2018
     */
    int updateByPrimaryKeySelective(InstructionContraindication record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table instruction_contraindication
     *
     * @mbggenerated Thu Jul 05 17:04:13 CST 2018
     */
    int updateByPrimaryKey(InstructionContraindication record);

	List<InstructionContraindication> findByCondition(
			InstructionContraindication instructionContraindicationCondition);
}