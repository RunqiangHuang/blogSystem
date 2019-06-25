package com.gpnu.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 用于登录
 */
@Entity
public class Login {
    @Id
    private String account;

    @Column
    private String password;

    @Column
    private Integer type;

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Login{" +
                "account='" + account + '\'' +
                ", password='" + password + '\'' +
                ", type=" + type +
                '}';
    }
}
