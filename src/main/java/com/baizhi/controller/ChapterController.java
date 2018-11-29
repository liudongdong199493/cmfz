package com.baizhi.controller;

import com.baizhi.entity.Chapter;
import com.baizhi.service.ChapterService;
import com.baizhi.util.FileUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;

@RestController
@RequestMapping("/chapter")
public class ChapterController {
    @Autowired
    private ChapterService chapterService;

    @RequestMapping("/insert")
    public boolean insert(String album_id, String title, MultipartFile multipartFile, HttpServletRequest request) {
        Chapter chapter = new Chapter();
        chapter.setTitle(title);
        chapter.setAlbum_id(album_id);
        long size = multipartFile.getSize();
        String sizeStr = (size / 1024.0 / 1024.0) + "M";
        chapter.setSize(sizeStr);
        String realPath = request.getSession().getServletContext().getRealPath("/");
        File file = new File(realPath + "/upload");
        if (!file.exists()) {
            file.mkdir();
        }
        String extension = FilenameUtils.getExtension(multipartFile.getOriginalFilename());
        UUID uuid = UUID.randomUUID();
        String s = uuid.toString();
        String newName = s + "." + extension;
        chapter.setDownPath(newName);
        try {
            multipartFile.transferTo(new File(file.getAbsolutePath(), newName));
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        String duration = FileUtil.getDuration(new File(file.getAbsolutePath() + "/" + newName));
        chapter.setDuration(duration);
        System.out.println(chapter);
        try {
            chapterService.insert(chapter);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    @RequestMapping("/download")
    public boolean download(String downPath, String title, HttpServletRequest request, HttpServletResponse response) {
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");
        String path = uploadPath + "/" + downPath;
        File file = new File(path);
        String s = title + "." + "mp3";
        try {
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(s, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("audio/mpeg");

        try {
            ServletOutputStream outputStream = response.getOutputStream();
            outputStream.write(FileUtils.readFileToByteArray(file));
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;

    }

}
