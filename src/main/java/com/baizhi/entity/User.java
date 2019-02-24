package com.baizhi.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user")
public class User {
    @Id
    @Column(name = "user_id")
    @KeySql(useGeneratedKeys = true)
    private Integer user_id;
    @Column(name = "phoneNum")
    private String phoneNum;
    private String username;
    private String password;
    private String salt;
    @Column(name = "dharmaName")
    private String dharmaName;
    private String province;
    private String city;
    private String sex;
    private String sign;
    @Column(name = "headPic")
    private String headPic;
    private String status;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Data registDate;
}
