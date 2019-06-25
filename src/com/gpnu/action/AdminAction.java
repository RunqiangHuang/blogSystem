package com.gpnu.action;

import com.alibaba.fastjson.JSON;
import com.gpnu.domain.Admin;
import com.gpnu.domain.Login;
import com.gpnu.service.IAdminService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

@Controller("adminAction")
@Scope(value = "prototype")
public class AdminAction extends ActionSupport implements ModelDriven<Admin> {

    private Admin admin = new Admin();

    //表达式封装
    private Login login;

    private String newPassword;

    public Login getLogin() {
        return login;
    }

    public void setLogin(Login login) {
        this.login = login;
    }


    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }
    ///////////////////

    @Autowired
    private IAdminService adminService;

    @Override
    public Admin getModel() {
        return admin;
    }

    public void changeInfo() {
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        Admin adminInSession = (Admin) request.getSession().getAttribute("adminInfo");
        adminService.updateAdminMsg(admin);
        adminInSession.setEmail(admin.getEmail());
        adminInSession.setName(admin.getName());
        adminInSession.setSummary(admin.getSummary());
        adminInSession.setTel(admin.getTel());
        request.getSession().setAttribute("adminInfo",adminInSession);
        response.setCharacterEncoding("utf-8");
        try {
            String jsonString = JSON.toJSONString("ok");
            response.getWriter().write(jsonString);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void changeHeadimg() {
        HttpServletRequest request = ServletActionContext.getRequest();
        String headData = request.getParameter("headData").substring(22);
        Base64.Decoder decoder = Base64.getDecoder();
        try {
            byte[] imgByte = decoder.decode(headData);
            String filePath = "F:/blogSystem/admin";
            String fileName = System.currentTimeMillis() + ".png";
            String path = "/img/admin/" + fileName;
            File dir = new File(filePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            FileOutputStream out = new FileOutputStream(filePath + "/" + fileName); // 输出文件路径
            out.write(imgByte);
            // 改变路径
            adminService.updateHeadimg(path);
            System.out.println("-------------------here2");
            //取出session
            Admin admin = (Admin) request.getSession().getAttribute("adminInfo");
            admin.setHeadImg(path);

            Map<String, Object> map = new HashMap<>();
            map.put("path", path);
            String jsonString = JSON.toJSONString(map);
            HttpServletResponse respones = ServletActionContext.getResponse();
            respones.setCharacterEncoding("utf-8");
            respones.getWriter().write(jsonString);
            // 更新session

            request.getSession().setAttribute("adminInfo", admin);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void changePassword() throws IOException {
        HttpServletResponse reasponse = ServletActionContext.getResponse();
        reasponse.setCharacterEncoding("utf-8");
        Map<String, Object> map = new HashMap<>();
        if(adminService.changePassword(login.getAccount(),login.getPassword(),newPassword)){
            map.put("state","1");
        }else{
            map.put("state","0");
        }
        reasponse.getWriter().print(JSON.toJSON(map));
    }

    public String toInfo(){
        return "toInfo";
    }

    public String toChangePassword(){
        return "toChangePassword";
    }

    public String toLogout(){
        HttpServletRequest request = ServletActionContext.getRequest();
        request.getSession().removeAttribute("adminInfo");
        return "toLogout";
    }
}
