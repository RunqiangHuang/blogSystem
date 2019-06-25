package com.gpnu.action;

import com.alibaba.fastjson.JSON;
import com.gpnu.domain.Type;
import com.gpnu.service.IBlogManageService;
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
import java.util.List;
import java.util.Map;

@Controller("typeAction")
@Scope(value = "prototype")
public class TypeAction extends ActionSupport implements ModelDriven<Type> {

    private Type type = new Type();

    // 接受传递过来的关键词
    private String keyword;

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    @Autowired
    private IBlogManageService blogManageService;

    @Override
    public Type getModel() {
        return type;
    }

    public String toTypeManage() {
        List<Type> types = blogManageService.getAllType();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("typeList", types);
        return "typeManage";
    }

    public void deleteType() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        Integer id = Integer.parseInt(request.getParameter("id"));
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setCharacterEncoding("utf-8");
        Map<String,Object> map = new HashMap<>();
        try {
            blogManageService.deleteType(id);
            map.put("state",1);
            response.getWriter().print(JSON.toJSON(map));
        }catch (Exception e){
            map.put("state",0);
            response.getWriter().print(JSON.toJSON(map));
        }
    }

    public String saveOrUpdateType() {
        // 根据是否有id来判断更新还是添加
        System.out.println(type);
        // 添加
        if (type.getId() == null) {
            try {
                blogManageService.addType(type);
            } catch (Exception e) {
                System.out.println("失败失败！！！！");
                throw new RuntimeException();
            }
        } else {
            blogManageService.modifyType(type);
        }
        return "toTypeManage";
    }

    public String findByKeyword() {
        HttpServletRequest request = ServletActionContext.getRequest();
        List<Type> types = blogManageService.getTypeByKeyword(keyword);
        request.setAttribute("typeList", types);
        request.setAttribute("keyword", keyword);
        return "typeManage";
    }

    // ajax
    // 添加分类
    public void addType() throws IOException {
        HttpServletResponse reasponse = ServletActionContext.getResponse();
        reasponse.setCharacterEncoding("utf-8");
        Type newType = null;
        try {
            newType = blogManageService.addType(type);
        } catch (Exception e) {
            reasponse.getWriter().print(JSON.toJSON("fail"));
            throw new RuntimeException();
        }
        reasponse.getWriter().print(JSON.toJSON(newType));
    }

    // ajax 获取分类
    public void getAlltype() throws IOException {
        HttpServletResponse reasponse = ServletActionContext.getResponse();
        reasponse.setCharacterEncoding("utf-8");
        List<Type> types = blogManageService.getAllType();
        reasponse.getWriter().print(JSON.toJSONString(types));
    }

}
