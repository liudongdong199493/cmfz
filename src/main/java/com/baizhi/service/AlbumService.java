package com.baizhi.service;

import com.baizhi.entity.Album;

import java.util.Map;

public interface AlbumService {
    Map getAll(int page, int rows);

    void insert(Album album);
}
