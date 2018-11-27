package com.baizhi.dao;

import com.baizhi.entity.Menu;

import java.util.List;

public interface MenuDao {
    List<Menu> getAll();

    Menu getOneById(int id);
}
