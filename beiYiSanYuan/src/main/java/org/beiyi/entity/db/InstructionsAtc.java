package org.beiyi.entity.db;

public class InstructionsAtc {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.instruction_id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String instructionId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.common_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String commonName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.commodity_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String commodityName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.atc_id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String atcId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.atc_ch_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String atcChName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.atc_en_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String atcEnName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column instructions_atc.atc_no
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    private String atcNo;

    
    public InstructionsAtc() {
		super();
	}

	public InstructionsAtc(String commonName, String commodityName) {
		super();
		this.commonName = commonName;
		this.commodityName = commodityName;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.id
     *
     * @return the value of instructions_atc.id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.id
     *
     * @param id the value for instructions_atc.id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.instruction_id
     *
     * @return the value of instructions_atc.instruction_id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getInstructionId() {
        return instructionId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.instruction_id
     *
     * @param instructionId the value for instructions_atc.instruction_id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setInstructionId(String instructionId) {
        this.instructionId = instructionId == null ? null : instructionId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.common_name
     *
     * @return the value of instructions_atc.common_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getCommonName() {
        return commonName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.common_name
     *
     * @param commonName the value for instructions_atc.common_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setCommonName(String commonName) {
        this.commonName = commonName == null ? null : commonName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.commodity_name
     *
     * @return the value of instructions_atc.commodity_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getCommodityName() {
        return commodityName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.commodity_name
     *
     * @param commodityName the value for instructions_atc.commodity_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setCommodityName(String commodityName) {
        this.commodityName = commodityName == null ? null : commodityName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.atc_id
     *
     * @return the value of instructions_atc.atc_id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getAtcId() {
        return atcId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.atc_id
     *
     * @param atcId the value for instructions_atc.atc_id
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setAtcId(String atcId) {
        this.atcId = atcId == null ? null : atcId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.atc_ch_name
     *
     * @return the value of instructions_atc.atc_ch_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getAtcChName() {
        return atcChName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.atc_ch_name
     *
     * @param atcChName the value for instructions_atc.atc_ch_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setAtcChName(String atcChName) {
        this.atcChName = atcChName == null ? null : atcChName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.atc_en_name
     *
     * @return the value of instructions_atc.atc_en_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getAtcEnName() {
        return atcEnName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.atc_en_name
     *
     * @param atcEnName the value for instructions_atc.atc_en_name
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setAtcEnName(String atcEnName) {
        this.atcEnName = atcEnName == null ? null : atcEnName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column instructions_atc.atc_no
     *
     * @return the value of instructions_atc.atc_no
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public String getAtcNo() {
        return atcNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column instructions_atc.atc_no
     *
     * @param atcNo the value for instructions_atc.atc_no
     *
     * @mbggenerated Thu Jul 05 15:05:45 CST 2018
     */
    public void setAtcNo(String atcNo) {
        this.atcNo = atcNo == null ? null : atcNo.trim();
    }
}