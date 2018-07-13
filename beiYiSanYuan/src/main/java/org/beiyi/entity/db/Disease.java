package org.beiyi.entity.db;

public class Disease {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column disease.id
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    private String id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column disease.dis_name
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    private String disName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column disease.alias_name
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    private String aliasName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column disease.description
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    private String description;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column disease.last_update_time
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    private String lastUpdateTime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column disease.id
     *
     * @return the value of disease.id
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public String getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column disease.id
     *
     * @param id the value for disease.id
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column disease.dis_name
     *
     * @return the value of disease.dis_name
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public String getDisName() {
        return disName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column disease.dis_name
     *
     * @param disName the value for disease.dis_name
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public void setDisName(String disName) {
        this.disName = disName == null ? null : disName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column disease.alias_name
     *
     * @return the value of disease.alias_name
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public String getAliasName() {
        return aliasName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column disease.alias_name
     *
     * @param aliasName the value for disease.alias_name
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public void setAliasName(String aliasName) {
        this.aliasName = aliasName == null ? null : aliasName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column disease.description
     *
     * @return the value of disease.description
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public String getDescription() {
        return description;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column disease.description
     *
     * @param description the value for disease.description
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column disease.last_update_time
     *
     * @return the value of disease.last_update_time
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public String getLastUpdateTime() {
        return lastUpdateTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column disease.last_update_time
     *
     * @param lastUpdateTime the value for disease.last_update_time
     *
     * @mbggenerated Thu Jul 05 17:16:32 CST 2018
     */
    public void setLastUpdateTime(String lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime == null ? null : lastUpdateTime.trim();
    }
}