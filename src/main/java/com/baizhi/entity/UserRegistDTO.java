package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.soap.SAAJResult;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name ="user")
public class UserRegistDTO {
    @Id
    private Integer userId;

    private String phone;
    private String password;
}
