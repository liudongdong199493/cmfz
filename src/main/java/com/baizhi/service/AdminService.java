package com.baizhi.service;

import com.baizhi.entity.Admin;

import java.util.Map;

public interface AdminService {
    Map login(Admin admin);

    void updatePassword(Integer id, Integer password2);
}
