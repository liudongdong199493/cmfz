package com.baizhi.service.impl;

import com.baizhi.dao.MenuDao;
import com.baizhi.entity.Menu;
import com.baizhi.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuDao menuDao;

    @Override
    public Map getAll() {
        List<Menu> list = menuDao.getAll();
        Map map = new HashMap();
        map.put("list", list);
        return map;
    }

    @Override
    public Map getOneById(int id) {
        Menu menu = menuDao.getOneById(id);
        Map map = new HashMap();
        map.put("menu", menu);
        return map;
    }
}
