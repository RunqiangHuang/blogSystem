package com.gpnu.dao;

import com.gpnu.domain.Admin;

public interface AdminDao {
    public Admin getAdminMsg();
    public void updateMsg(Admin admin);
    public void changeHeadimg(String newPath);
    public void changePassword(String newPassword);
    public boolean checkOldPassword(String password,String account);
}
