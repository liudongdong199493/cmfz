package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/countByDate")
    public int[] countByDate(){
        int[] count = userService.countByDate();
        return count;
    }

    @RequestMapping("/selectUserProfil")
    public Map selectUserProfil(){
        Map map = userService.selectUserProfil();
        return map;
    }

    @RequestMapping("getAll")
    public Map getAll(Integer page,Integer rows){
        Map map = userService.getAll(page,rows);
        return map ;
    }

    @RequestMapping("/login")
    public Object login(String username, String password, String code, HttpSession session){
        String code1 = (String) session.getAttribute("code");
        if(code.equalsIgnoreCase(code1)){
            User user = userService.queryUserByName(username);
            if(user!=null){
                if(user.getPassword().equals(password)){
                    return user;
                }
                return "密码错误！";
            }
            return "用户名不存在";
        }else{
            return "验证码错误！";
        }

    }

    @RequestMapping("/registUser")
    public Object registUser(String phoneNum,String password){
        User user1 = userService.selectByPhoneNum(phoneNum);
        if(user1==null){
            User user = userService.regist(phoneNum,password);
            return user;
        }else{
            Map map = new HashMap();
            map.put("error","-200");
            map.put("error_msg","该手机号已存在");
            return map;
        }


    }
    @RequestMapping("/queryRandom")
    public Object queryRandom(Integer uid){
        List<User> list =  userService.queryRandom(uid);
        return list;
    }




}
