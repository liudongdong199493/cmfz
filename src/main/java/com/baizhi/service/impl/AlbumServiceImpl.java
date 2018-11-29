package com.baizhi.service.impl;

import com.baizhi.dao.AlbumDao;
import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AlbumServiceImpl implements AlbumService {
    @Autowired
    private AlbumDao albumDao;

    @Override
    public Map getAll(int page, int rows) {
        int start = (page - 1) * rows;
        List<Album> list = albumDao.getAll(start, rows);
        int count = albumDao.getCount();
        Map map = new HashMap();
        map.put("total", count);
        map.put("rows", list);
        return map;
    }

    @Override
    public void insert(Album album) {
        albumDao.insert(album);
    }
}
