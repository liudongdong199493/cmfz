package com.baizhi.entity;

import lombok.*;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    private Integer id;
    private String title;
    private String iconCls;
    private Integer parent_id;
    private String url;
    private List<Menu> menuList;
}
