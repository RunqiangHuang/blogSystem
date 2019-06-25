package com.gpnu.service;

import com.gpnu.domain.Admin;

public interface IAdminService {
    public Admin getAdminMsg();

    public void updateAdminMsg(Admin admin);

    public void updateHeadimg(String newPath);

    public boolean changePassword(String account,String Oldpassword,String newPassword);
}
