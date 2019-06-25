package com.gpnu.action;

import com.alibaba.fastjson.JSON;
import com.gpnu.domain.Login;
import com.gpnu.domain.User;
import com.gpnu.service.IUserService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller("userAction")
@Scope(value = "prototype")
public class UserAction extends ActionSupport implements ModelDriven<User> {

    @Autowired
    private IUserService userService;

    private User user = new User();

    public String toLogin(){
        return "toLogin";
    }

    public String toResister(){
        return "toRegister";
    }

    public void checkUser() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse reasponse = ServletActionContext.getResponse();
        reasponse.setCharacterEncoding("utf-8");
        Map<String,Object> map = new HashMap<>();
        String account = request.getParameter("account");
        User userExist = userService.findUserByAccount(account);
        if(userExist == null){
            map.put("status","1");
        }else{
            map.put("status","0");
        }
        reasponse.getWriter().print(JSON.toJSON(map));
    }

    public void register() throws IOException{
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse reasponse = ServletActionContext.getResponse();
        String password = request.getParameter("password");
        Login login= new Login();
        login.setAccount(user.getAccount());
        login.setPassword(password);
        login.setType(1);
        userService.register(user,login);
        System.out.println(user);
        System.out.println(login);
        Map<String,Object> map = new HashMap<>();
        map.put("status","1");
        reasponse.getWriter().print(JSON.toJSON(map));
    }

    @Override
    public User getModel() {
        return user;
    }
}
