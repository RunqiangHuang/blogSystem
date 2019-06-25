package com.gpnu.dao;

import com.gpnu.domain.User;

public interface UserDao {
    public User findUserByAccount(String account);
    public void addUser(User user);
}
