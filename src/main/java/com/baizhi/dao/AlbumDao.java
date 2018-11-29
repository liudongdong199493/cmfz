package com.baizhi.dao;

import com.baizhi.entity.Album;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlbumDao {
    List<Album> getAll(@Param("start") int start, @Param("rows") int rows);

    int getCount();

    void insert(Album album);
}
