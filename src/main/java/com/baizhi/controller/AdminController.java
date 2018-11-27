package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("/login")
    public Map login(Admin admin, String code, HttpSession session) {
        Map map = new HashMap();
        if (code.equalsIgnoreCase((String) session.getAttribute("code"))) {
            map = adminService.login(admin);
            boolean isLogin = (boolean) map.get("isLogin");
            if (isLogin) {
                session.setAttribute("admin", map.get("admin"));
            }
        } else {
            map.put("code", false);
        }
        return map;
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("admin");
        return "forward:login.jsp";
    }

    @RequestMapping("/updatePassword")
    public boolean updatePassword(Integer password1, HttpSession session) {
        try {
            Admin admin = (Admin) session.getAttribute("admin");
            adminService.updatePassword(admin.getId(), password1);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

}
