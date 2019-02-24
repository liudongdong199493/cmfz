package com.baizhi.service.impl;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import com.baizhi.entity.UserDTO;
import com.baizhi.entity.UserRegistDTO;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Override
    public int[] countByDate() {
        int count1 = userDao.countByDate(7);
        int count2 = userDao.countByDate(14);
        int count3 = userDao.countByDate(21);
        int[] count ={count1,count2,count3};
        return count;
    }

    @Override
    public Map selectUserProfil() {
        List<UserDTO> countMan = userDao.selectUserProfil("男");
        List<UserDTO> countWoman = userDao.selectUserProfil("女");
        Map map = new HashMap();
        map.put("man",countMan);
        map.put("woman",countWoman);
        return map;
    }

    @Override
    public Map getAll(Integer page, Integer rows) {
        int start = (page-1)*rows;
        List<User> users = userDao.getAll(start,rows);
        int count = userDao.getCount();
        Map map = new HashMap();
        map.put("total",count);
        map.put("rows",users);
        return map;
    }

    @Override
    public User queryUserByName(String username) {
        User user =  userDao.queryUserByName(username);
        return user;
    }

    @Override
    public User regist(String phoneNum, String password) {
        User user = new User();
        user.setPhoneNum(phoneNum);
        user.setPassword(password);
        userDao.insert(user);
        System.out.println(user.getUser_id());
        return user;
    }

    @Override
    public User selectByPhoneNum(String phoneNum) {
        User user = new User();
        user.setPhoneNum(phoneNum);
        User user1 = userDao.selectOne(user);
        return user1;
    }

    @Override
    public List<User> queryRandom(Integer uid) {
        List<User> list = userDao.queryRandom(uid);
        return list;
    }


}
