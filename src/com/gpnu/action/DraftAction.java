package com.gpnu.action;

import com.alibaba.fastjson.JSON;
import com.gpnu.domain.Draft;
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

@Controller("draftAction")
@Scope(value = "prototype")
public class DraftAction extends ActionSupport implements ModelDriven<Draft> {

    @Autowired
    private IBlogManageService blogManageService;

    private Draft draft = new Draft();

    @Override
    public Draft getModel() {
        return draft;
    }

    public String list(){
        List<Draft> drafts = blogManageService.listDraft();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("drafts",drafts);
        return "toDraftManage";
    }

    // 变成草稿或保存
    public void saveOrUpdate() throws IOException {
        System.out.println(draft);
        HttpServletResponse reasponse = ServletActionContext.getResponse();
        reasponse.setCharacterEncoding("utf-8");
        Map<String, Object> map = new HashMap<>();
        if (draft.getDraftId() == null) {
            Draft newDraft = blogManageService.addDraft(draft);
            map.put("state",1);
            map.put("draftId",newDraft.getDraftId());
        } else {
            blogManageService.updateDraft(draft);
            map.put("state", "0");
        }
        reasponse.getWriter().print(JSON.toJSON(map));
    }

    public String deleteDraft() {
        HttpServletRequest request = ServletActionContext.getRequest();
        Integer articleId = Integer.parseInt(request.getParameter("id"));
        blogManageService.deleteDraft(articleId);
        return "toListAction";
    }

    public String draftContent(){
        HttpServletRequest request = ServletActionContext.getRequest();
        Integer draftId = Integer.parseInt(request.getParameter("id"));
        Draft draft = blogManageService.findDraftById(draftId);
        request.setAttribute("article",draft);
        request.setAttribute("flag", 2);
        return "toDraftContent";
    }
}
