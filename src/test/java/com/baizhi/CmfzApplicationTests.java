package com.baizhi;

import com.baizhi.service.MenuService;
import com.baizhi.service.impl.MenuServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CmfzApplicationTests {

    @Test
    public void contextLoads() {
        MenuService menuService = new MenuServiceImpl();
        Map all = menuService.getAll();
        System.out.println(all.get("list"));
    }

}
