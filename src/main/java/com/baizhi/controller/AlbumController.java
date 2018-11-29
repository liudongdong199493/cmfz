package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/album")
public class AlbumController {

    @Autowired
    private AlbumService albumService;

    @RequestMapping("/getAll")
    public Map getAll(int page, int rows) {
        Map map = albumService.getAll(page, rows);
        return map;
    }

    @RequestMapping("/insert")
    public boolean insert(Album album, MultipartFile multipartFile, BindingResult bindingResult, HttpServletRequest request) {
        String realPath = request.getSession().getServletContext().getRealPath("/");
        File file = new File(realPath + "/img/audioCollection");
        if (!file.exists()) {
            file.mkdir();
        }
        String extension = FilenameUtils.getExtension(multipartFile.getOriginalFilename());
        UUID uuid = UUID.randomUUID();
        String s = uuid.toString();
        album.setId(s);
        String newName = s + "." + extension;
        album.setCoverlmg(newName);
        try {
            multipartFile.transferTo(new File(file.getAbsolutePath(), newName));
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        try {
            albumService.insert(album);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
