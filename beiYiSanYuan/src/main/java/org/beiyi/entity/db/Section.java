package org.beiyi.entity.db;

public class Section {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column section.id
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    private String id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column section.name_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    private String name;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column section.type_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    private String type;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column section.desc_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    private String desc;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column section.id
     *
     * @return the value of section.id
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public String getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column section.id
     *
     * @param id the value for section.id
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column section.name_
     *
     * @return the value of section.name_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column section.name_
     *
     * @param name the value for section.name_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column section.type_
     *
     * @return the value of section.type_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public String getType() {
        return type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column section.type_
     *
     * @param type the value for section.type_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column section.desc_
     *
     * @return the value of section.desc_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public String getDesc() {
        return desc;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column section.desc_
     *
     * @param desc the value for section.desc_
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    public void setDesc(String desc) {
        this.desc = desc == null ? null : desc.trim();
    }
}