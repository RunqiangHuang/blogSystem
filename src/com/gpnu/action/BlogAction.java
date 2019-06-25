package com.gpnu.action;

import com.alibaba.fastjson.JSON;
import com.gpnu.domain.Admin;
import com.gpnu.domain.Article;
import com.gpnu.domain.Comment;
import com.gpnu.domain.Type;
import com.gpnu.service.*;
import com.gpnu.utils.PageModel;
import com.gpnu.utils.RemoveHTML;
import com.opensymphony.xwork2.ActionSupport;
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
import java.util.Set;

@Controller("blogAction")
@Scope(value = "prototype")
public class BlogAction extends ActionSupport {

    @Autowired
    private IUserService userService;

    @Autowired
    private IAdminService adminService;


    public String toIndex() {
        HttpServletRequest request = ServletActionContext.getRequest();
        //获取所有分类
        List<Type> types = userService.getAllType();
        //博客主人信息
        Admin adminMsg = adminService.getAdminMsg();
        //文章信息
        String tempPage = request.getParameter("page");
        Integer page = 1;
        if (null == tempPage) {
            page = 1;
        } else {
            page = Integer.parseInt(tempPage);
        }
        PageModel pageModel = userService.getDividArticle(page, null);
        //top5文章
        List<Article> top5Article = userService.getTop5Article();
        // 转换成普通文本。取出html标签
        List<Article> pageModelList = pageModel.getList();
        for (int i = 0; i < pageModelList.size(); i++) {
            String content = pageModelList.get(i).getContent();
            pageModelList.get(i).setContent(RemoveHTML.Html2Text(content));
        }
        pageModel.setList(pageModelList);
        for (int i = 0; i < top5Article.size(); i++) {
            String content = top5Article.get(i).getContent();
            top5Article.get(i).setContent(RemoveHTML.Html2Text(content));
        }
        request.setAttribute("types", types);
        request.setAttribute("adminMsg", adminMsg);
        request.setAttribute("pageModel", pageModel);
        request.setAttribute("top5Article", top5Article);
        return "toIndex";
    }

    public String toAbout() {
        Admin adminMsg = adminService.getAdminMsg();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("adminMsg", adminMsg);
        return "toAbout";
    }

    public String toMessage() {
        HttpServletRequest request = ServletActionContext.getRequest();
        String tempPage = request.getParameter("page");
        Integer page = 1;
        if (null == tempPage) {
            page = 1;
        } else {
            page = Integer.parseInt(tempPage);
        }
        PageModel pageModel = userService.getMessageWithDivid(page);
        request.setAttribute("pageModel", pageModel);
        return "toMessage";
    }

    public String toType() {
        HttpServletRequest request = ServletActionContext.getRequest();
        String tempPage = request.getParameter("page");
        String tempType = request.getParameter("type");
        Integer page = 1;
        Integer type = 0;
        if (null == tempPage) {
            page = 1;
        } else {
            page = Integer.parseInt(tempPage);
        }
        if (null == tempType) {
            type = 0;
        } else {
            type = Integer.parseInt(tempType);
        }
        PageModel pageModel = null;
        // type = 0 就代表查询所有。
        if (0 == type) {
            pageModel = userService.getDividArticle(page, null);
        } else {
            String typeId = request.getParameter("typeId");
            String typeName = request.getParameter("typeName");
            request.setAttribute("type", type);
            request.setAttribute("typeName", typeName);
            request.setAttribute("page", page);
            request.setAttribute("flag", 1);
            pageModel = userService.getDividArticleWithType(page, type);
        }
        List<Type> types = userService.getAllType();
        List<Article> pageModelList = pageModel.getList();
        for (int i = 0; i < pageModelList.size(); i++) {
            String content = pageModelList.get(i).getContent();
            pageModelList.get(i).setContent(RemoveHTML.Html2Text(content));
        }
        pageModel.setList(pageModelList);
        request.setAttribute("types", types);
        request.setAttribute("pageModel", pageModel);
        return "toType";
    }

    public String toArticle() {
        HttpServletRequest request = ServletActionContext.getRequest();
        String articleId = request.getParameter("articleId");
        String flag = request.getParameter("flag");
        Article article = userService.getArticle(Integer.parseInt(articleId), flag);
        request.setAttribute("article", article);
        Set<Comment> comments = article.getComments();
        return "toArticle";
    }

    public String toLogin() {
        return "toLogin";
    }

    public String toRegister() {
        return "toRegister";
    }

    public String toArticleSearch() {
        HttpServletRequest request = ServletActionContext.getRequest();
        String keyword = request.getParameter("keyword");
        List<Article> articles = userService.getArticlesByKeyword(keyword);
        //转换成普通文本
        for (int i = 0; i < articles.size(); i++) {
            String content = articles.get(i).getContent();
            articles.get(i).setContent(RemoveHTML.Html2Text(content));
        }
        request.setAttribute("keyword", keyword);
        request.setAttribute("articles", articles);
        return "toArticleSearch";
    }

    public void toLogout() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        request.getSession().removeAttribute("user");
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("state","1");
        response.getWriter().print(JSON.toJSON(map));
    }

}
