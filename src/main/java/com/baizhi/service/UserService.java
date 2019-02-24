package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    int[] countByDate();

    Map selectUserProfil();

    Map getAll(Integer page, Integer rows);

    User queryUserByName(String username);

    User regist(String phoneNum, String password);

    User selectByPhoneNum(String phoneNum);

    List<User> queryRandom(Integer uid);
}
