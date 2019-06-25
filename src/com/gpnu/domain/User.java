package com.gpnu.domain;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "userinfo")
@DynamicInsert(true)
public class User {
    @Id
    private String account;

    @Column
    private String name;

    @Column
    private String headImg;

    @Column
    private String email;

    @Override
    public String toString() {
        return "User{" +
                "account='" + account + '\'' +
                ", name='" + name + '\'' +
                ", headImg='" + headImg + '\'' +
                ", email='" + email + '\'' +
                '}';
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHeadImg() {
        return headImg;
    }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
