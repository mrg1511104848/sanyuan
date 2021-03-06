package org.beiyi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.beiyi.entity.db.UserSection;

public interface UserSectionMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user_section
     *
     * @mbggenerated Tue Jul 24 10:12:33 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user_section
     *
     * @mbggenerated Tue Jul 24 10:12:33 CST 2018
     */
    int insert(UserSection record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user_section
     *
     * @mbggenerated Tue Jul 24 10:12:33 CST 2018
     */
    int insertSelective(UserSection record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user_section
     *
     * @mbggenerated Tue Jul 24 10:12:33 CST 2018
     */
    UserSection selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user_section
     *
     * @mbggenerated Tue Jul 24 10:12:33 CST 2018
     */
    int updateByPrimaryKeySelective(UserSection record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user_section
     *
     * @mbggenerated Tue Jul 24 10:12:33 CST 2018
     */
    int updateByPrimaryKey(UserSection record);

	List<org.beiyi.entity.db.pageBean.UserSection> getPagedList(org.beiyi.entity.db.pageBean.UserSection userSection);
	
	org.beiyi.entity.db.pageBean.UserSection get(@Param(value="id") String id);
}