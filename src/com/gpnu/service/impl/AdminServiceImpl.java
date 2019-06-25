package com.gpnu.service.impl;

import com.gpnu.dao.AdminDao;
import com.gpnu.domain.Admin;
import com.gpnu.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("adminService")
public class AdminServiceImpl implements IAdminService {

    @Autowired
    private AdminDao adminDao;

    @Override
    public Admin getAdminMsg() {
        return adminDao.getAdminMsg();
    }

    @Override
    public void updateAdminMsg(Admin admin) {
        adminDao.updateMsg(admin);
    }

    @Override
    public void updateHeadimg(String newPath) {
        adminDao.changeHeadimg(newPath);
    }

    @Override
    public boolean changePassword(String account, String Oldpassword, String newPassword) {
        if (adminDao.checkOldPassword(account, Oldpassword)) {
            adminDao.changePassword(newPassword);
            System.out.println("修改成功");
            return true;
        } else {
            System.out.println("//////密码错误");
            return false;
        }
    }
}
