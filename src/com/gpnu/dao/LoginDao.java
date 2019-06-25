package com.gpnu.dao;

import com.gpnu.domain.Login;

public interface LoginDao {
    /**
     * 用于检查登录
     * @param login 传递过来的Login尸体拖累
     * @return 用户是否存在
     */
    public Login findUser(Login login);

    public void addLogin(Login login);
}
