package com.baizhi.dao;

import com.baizhi.entity.Carousel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CarouselDao {
    List<Carousel> getAll(@Param("start") int start, @Param("rows") int rows);

    int getCount();

    void delete(int id);

    void update(Carousel carousel);

    void insert(Carousel carousel);
}
