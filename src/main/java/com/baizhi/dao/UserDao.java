package com.baizhi.dao;

import com.baizhi.entity.User;
import com.baizhi.entity.UserDTO;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface UserDao extends Mapper<User> {

    int countByDate(int time);

    List<UserDTO> selectUserProfil(String sex);
    int getCount();
    List<User> getAll(@Param("start") int start, @Param("rows") int rows);

    User queryUserByName(String username);

    List<User> queryRandom(Integer uid);
}
