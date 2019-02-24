package com.baizhi.dao;

import com.baizhi.entity.Admin;
import org.apache.ibatis.annotations.Param;

public interface AdminDao  {
    Admin login(Admin admin);

    void updatePassword(@Param("id") Integer id, @Param("password") Integer password);
}
