package com.gpnu.service.impl;

import com.gpnu.dao.LoginDao;
import com.gpnu.domain.Login;
import com.gpnu.service.ILoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("loginService")
@Transactional
public class LoginServiceImpl implements ILoginService {

    @Autowired
    private LoginDao loginDao;

    @Override
    public Login checkLogin(Login login) {
        return loginDao.findUser(login);
    }
}
