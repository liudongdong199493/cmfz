package com.baizhi.controller;

import com.baizhi.entity.Carousel;
import com.baizhi.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/carousel")
public class CarouselController {
    @Autowired
    private CarouselService carouselService;

    @RequestMapping("/getAll")
    public @ResponseBody
    Map getAll(Integer page, Integer rows) {
        Map map = carouselService.getAll(page, rows);
        return map;
    }

    @RequestMapping("/delete")
    public @ResponseBody
    boolean delete(int id) {
        try {
            carouselService.delete(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @RequestMapping("/update")
    public @ResponseBody
    boolean update(Carousel carousel, BindingResult bindingResult) {
        try {
            carouselService.update(carousel);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    @RequestMapping("/insert")
    public @ResponseBody
    boolean insert(Carousel carousel, BindingResult bindingResult, MultipartFile file, HttpServletRequest request) {
        try {
            if (file == null) {
                return false;
            }
            String fileName = file.getOriginalFilename();
            fileName = new Date().getTime() + "_" + fileName;
            String realPath = request.getSession().getServletContext().getRealPath("/img/shouye");
            carousel.setCarousel_imgPath("/img/shouye/" + fileName);
            try {
                file.transferTo(new File(realPath + "\\" + fileName));
                System.out.println(carousel + "iiiiiiiiiiiii");
                carouselService.insert(carousel);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }


}
