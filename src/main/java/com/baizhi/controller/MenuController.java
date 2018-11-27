package com.baizhi.controller;

import com.baizhi.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private MenuService menuService;

    @RequestMapping("/getAll")
    public Map getAll() {
        Map map = menuService.getAll();
        return map;
    }

    @RequestMapping("/getOneById")
    public Map getOneById(int id) {
        Map map = menuService.getOneById(id);
        return map;
    }
}
