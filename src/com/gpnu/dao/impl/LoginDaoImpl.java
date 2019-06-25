package com.gpnu.dao.impl;

import com.gpnu.dao.LoginDao;
import com.gpnu.domain.Login;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class LoginDaoImpl implements LoginDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    @Override
    public Login findUser(Login login) {
        List<Login> loginList = (List<Login>) hibernateTemplate.find("from Login where account = ? and password = ?",
                login.getAccount(), login.getPassword());
        if(loginList == null || loginList.size() <= 0){
            return null;
        }else{
            return loginList.get(0);
        }
    }

    @Override
    public void addLogin(Login login) {
        hibernateTemplate.save(login);
    }
}
