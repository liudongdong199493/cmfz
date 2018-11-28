package com.baizhi.service;

import com.baizhi.entity.Carousel;

import java.util.Map;

public interface CarouselService {
    Map getAll(Integer page, Integer rows);

    void delete(int id);

    void update(Carousel carousel);

    void insert(Carousel carousel);
}
