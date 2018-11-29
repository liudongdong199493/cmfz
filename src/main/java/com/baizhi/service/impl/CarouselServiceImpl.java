package com.baizhi.service.impl;

import com.baizhi.dao.CarouselDao;
import com.baizhi.entity.Carousel;
import com.baizhi.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CarouselServiceImpl implements CarouselService {

    @Autowired
    private CarouselDao carouselDao;

    @Override
    public Map getAll(Integer page, Integer rows) {
        System.out.println(page + "......" + rows);
        int start = (page - 1) * rows;
        List<Carousel> list = carouselDao.getAll(start, rows);
        int count = carouselDao.getCount();
        Map map = new HashMap();
        map.put("total", count);
        map.put("rows", list);
        return map;
    }

    @Override
    public void delete(int id) {
        carouselDao.delete(id);
    }

    @Override
    public void update(Carousel carousel) {
        carouselDao.update(carousel);
    }

    @Override
    public void insert(Carousel carousel) {
        carouselDao.insert(carousel);
    }
}
