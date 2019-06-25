package com.gpnu.action;

import com.gpnu.domain.Message;
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

@Controller
@Scope(value = "prototype")
public class MessageAction extends ActionSupport implements ModelDriven<Message> {

    @Autowired
    private IBlogManageService blogManageService;

    @Autowired
    private IUserService userService;

    private Message message = new Message();

    public String getMessage() {
        // 未分页
//        List<Message> allMessage = messageService.getAllMessage();
//        for (Message message : allMessage){
//            System.out.println(message);
//        }

        //分页
        HttpServletRequest request = ServletActionContext.getRequest();
        String tempPage = request.getParameter("page");
        Integer page = 1;
        if (null == tempPage) {
            page = 1;
        } else {
            page = Integer.parseInt(tempPage);
        }
        PageModel pageModel = blogManageService.getMessageWithDivid(page);
        request.setAttribute("pageModel", pageModel);
        return "toMessage";
    }

    public String deleteMessage() {
        HttpServletRequest request = ServletActionContext.getRequest();
        Integer id = Integer.parseInt(request.getParameter("id"));
        blogManageService.deleteMsg(id);
        return "toMessageManageAction";
    }

    public String makeMessage(){
        userService.addMsg(message);
        message.setState(1);
        return "toMessageBlogAction";
    }

    @Override
    public Message getModel() {
        return message;
    }
}
