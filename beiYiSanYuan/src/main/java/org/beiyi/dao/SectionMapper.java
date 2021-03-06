package org.beiyi.dao;

import java.util.List;

import org.beiyi.entity.db.Section;

public interface SectionMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table section
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table section
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    int insert(Section record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table section
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    int insertSelective(Section record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table section
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    Section selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table section
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    int updateByPrimaryKeySelective(Section record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table section
     *
     * @mbggenerated Fri Jul 20 14:25:17 CST 2018
     */
    int updateByPrimaryKey(Section record);

	List<Section> getPagedList(Section record);
}