package com.gpnu.action;

import com.gpnu.domain.Comment;
import com.gpnu.service.IBlogManageService;
import com.gpnu.service.IUserService;
import com.gpnu.utils.PageModel;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@Controller("commentAction")
@Scope(value = "prototype")
public class CommentAction extends ActionSupport implements ModelDriven<Comment> {

    @Autowired
    private IBlogManageService blogManageService;

    @Autowired
    private IUserService userService;


    private Comment comment = new Comment();


    public String toCommentManage() {
        HttpServletRequest request = ServletActionContext.getRequest();
        PageModel pageModel = blogManageService.getDividComment(1);
        request.setAttribute("pageModel", pageModel);
        return "toCommentManage";
    }

    public String deleteComment() {
        HttpServletRequest request = ServletActionContext.getRequest();
        Integer id = Integer.parseInt(request.getParameter("id"));
        blogManageService.deleteComment(id);
        return "toCommentManageAction";
    }

    public void makeComment() throws IOException {
//        System.out.println(comment);
        userService.makeComment(comment);
        //重定向到对应的页面
        String articleId = comment.getArticle().getId() + "";
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        response.sendRedirect(request.getContextPath() + "/blog_toArticle?articleId=" + articleId +"&flag=2");

    }

    @Override
    public Comment getModel() {
        return comment;
    }
}
