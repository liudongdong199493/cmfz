package com.baizhi;

import com.baizhi.service.AlbumService;
import com.baizhi.service.impl.AlbumServiceImpl;
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
        AlbumService albumService = new AlbumServiceImpl();
        Map all = albumService.getAll(1, 3);
        System.out.println(all.get("rows"));
    }

}
