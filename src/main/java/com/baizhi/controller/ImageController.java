package com.baizhi.controller;

import com.google.code.kaptcha.Producer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
public class ImageController {
    @Autowired
    private Producer producer;

    @RequestMapping("/code")
    public void getCode(HttpServletResponse response, HttpSession session) throws IOException {

        String code = producer.createText();

        session.setAttribute("code", code);

        BufferedImage image = producer.createImage(code);


        ImageIO.write(image, "jpg", response.getOutputStream());


    }

}
