package com.gpnu.action;

import com.gpnu.domain.Admin;
import com.gpnu.domain.Login;
import com.gpnu.domain.User;
import com.gpnu.service.IAdminService;
import com.gpnu.service.ILoginService;
import com.gpnu.service.IUserService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;

@Controller("loginAction")
@Scope(value = "prototype")
public class LoginAction extends ActionSupport implements ModelDriven<Login> {

    private Login login = new Login();

    @Autowired
    private ILoginService loginService;

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IUserService userService;

    @Override
    public Login getModel() {
        return login;
    }

    /**
     * 用于登录
     *
     * @return
     */
    public String login() {
        Login loginUser = loginService.checkLogin(this.login);
        HttpServletRequest request = ServletActionContext.getRequest();
        // 用户名或密码错误
        if (loginUser == null) {
            request.setAttribute("msg", "用户名或密码错误！");
        } else {
            // 登录成功。根据此id查找该用户的详细信息
            if (loginUser.getType() == 0) {
                // 管理员
//                System.out.println(adminService.getAdminMsg());
                Admin adminMsg = adminService.getAdminMsg();
                request.getSession().setAttribute("adminInfo",adminMsg);
                return "admin";
            } else {
                // 普通用户
                User userInfo = userService.findUserByAccount(loginUser.getAccount());
                System.out.println(userInfo);
                request.getSession().setAttribute("user", userInfo);
                return "blogIndex";
            }
        }
        return "login";
    }


}
