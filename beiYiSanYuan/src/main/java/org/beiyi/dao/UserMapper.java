package org.beiyi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.beiyi.entity.db.User;

public interface UserMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user
     *
     * @mbggenerated Wed Jul 04 14:52:37 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user
     *
     * @mbggenerated Wed Jul 04 14:52:37 CST 2018
     */
    int insert(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user
     *
     * @mbggenerated Wed Jul 04 14:52:37 CST 2018
     */
    int insertSelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user
     *
     * @mbggenerated Wed Jul 04 14:52:37 CST 2018
     */
    User selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user
     *
     * @mbggenerated Wed Jul 04 14:52:37 CST 2018
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bysy_user
     *
     * @mbggenerated Wed Jul 04 14:52:37 CST 2018
     */
    int updateByPrimaryKey(User record);

	User findUser(@Param(value="username")String username, @Param(value="password")String password);

	List<User> getPagedList(User user);
	
	List<User> findUserByCondition(User user);
	
	User getRandomUser(User user);
}