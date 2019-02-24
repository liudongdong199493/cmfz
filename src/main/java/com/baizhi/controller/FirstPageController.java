package com.baizhi.controller;

import com.baizhi.service.AlbumService;
import com.baizhi.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FirstPageController {
    /**
     * 吉祥秒音专题
     */
    @Autowired
    private AlbumService albumService;
    /**
     * 轮播图
     */
    @Autowired
    private CarouselService carouselService;
    /**
     * 甘露秒宝
     */


}
