package com.gpnu.dao.impl;

import com.gpnu.dao.UserDao;
import com.gpnu.domain.User;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class IUserDaoImpl implements UserDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    /**
     * 根据账号来查找用户
     * @param account 账号
     * @return 用户
     */
    @Override
    public User findUserByAccount(String account) {
        List<User> users = (List<User>) hibernateTemplate.find("from User where account = ? ", account);
        if(users == null || users.size() <= 0)
            return null;
        else
            return users.get(0);
    }

    @Override
    public void addUser(User user) {
        hibernateTemplate.save(user);
    }
}
