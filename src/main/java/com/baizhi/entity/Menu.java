package com.baizhi.entity;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
@Getter
@Setter
public class Menu {
    private Integer id;
    private String title;
    private String iconCls;
    private Integer parent_id;
    private String url;
    private List<Menu> menuList;
}
