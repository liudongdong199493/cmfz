package com.baizhi.service.impl;

import com.baizhi.dao.AdminDao;
import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDao adminDao;

    @Override
    public Map login(Admin admin) {
        Admin admin1 = adminDao.login(admin);
        Map map = new HashMap();
        if (admin1 != null) {
            map.put("isLogin", true);
            map.put("admin", admin1);
        }
        return map;
    }

    @Override
    public void updatePassword(Integer id, Integer password2) {
        adminDao.updatePassword(id, password2);
    }
}
