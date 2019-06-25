package com.gpnu.action;

import com.alibaba.fastjson.JSON;
import com.gpnu.domain.Article;
import com.gpnu.domain.Type;
import com.gpnu.service.IBlogManageService;
import com.gpnu.service.IUserService;
import com.gpnu.utils.ArticleSearch;
import com.gpnu.utils.PageModel;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope(value = "prototype")
public class ArticleAction extends ActionSupport implements ModelDriven<Article> {


    @Autowired
    private IBlogManageService blogManageService;

    // 获取草稿id
    private String draftId;


    //表达式封装
    private ArticleSearch articleSearch;

    private Article article = new Article();

    public File file;

    public String fileFileName;

    // 关于文件的操作
    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }

    public String getFileFileName() {
        return fileFileName;
    }

    public void setFileFileName(String fileFileName) {
        this.fileFileName = fileFileName;
    }

    public ArticleSearch getArticleSearch() {
        return articleSearch;
    }

    public void setArticleSearch(ArticleSearch articleSearch) {
        this.articleSearch = articleSearch;
    }

    public void fileUpload() throws IOException {
        if (file != null) {
            System.out.println("图片上传中...");
            HttpServletRequest request = ServletActionContext.getRequest();
            String filePath = "F:/blogSystem/temp";
            File dir = new File(filePath);
            // 创建路径
            if (!dir.exists()) {
                dir.mkdirs();
            }
            String fileName = System.currentTimeMillis() + ".png";
            File newFile = new File(filePath + "/" + fileName);
            FileUtils.copyFile(file, newFile);
            Map<String, Object> map = new HashMap<>();
            // 映射的路径
            String realpath = "/img/temp" + "/" + fileName;
            map.put("path", realpath);
            System.out.println(realpath + "---------");
            System.out.println("图片上传成功！");
            String jsonString = JSON.toJSONString(map);
            HttpServletResponse respones = ServletActionContext.getResponse();
            respones.setCharacterEncoding("utf-8");
            respones.getWriter().write(jsonString);
        } else {
            System.out.println("图片上传失败！");
        }
    }

    //////

    public String getDraftId() {
        return draftId;
    }

    public void setDraftId(String draftId) {
        this.draftId = draftId;
    }

    @Override
    public Article getModel() {
        return article;
    }

    // 发表文章
    public String publishArticle() {
        blogManageService.addArticle(article,draftId);
        return "toArticleManageAction";
    }


    // 获取具体文章。【用于修改】
    public String toSaveOrUpdateArticle() {
        HttpServletRequest request = ServletActionContext.getRequest();
        String flag = request.getParameter("flag");
        if (request.getParameter("id") != null) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            Article article = blogManageService.getArticle(id,flag);
            request.setAttribute("article", article);
            request.setAttribute("flag", 1);
        } else {
            request.setAttribute("flag", 0);
        }
        return "toSaveOrUpdateArticle";
    }

    public String toArticleManage() {
        HttpServletRequest request = ServletActionContext.getRequest();
        // 判断是否查询。  多条件查询不显示分页
        if (articleSearch == null) {
            request.setAttribute("flag", "1");
        } else {
            // 否则显示分页
            //仍需判断是否第二次按下。
            if (articleSearch.getYear().equals("不限") && articleSearch.getMonth().equals("不限") &&
                    articleSearch.getTypeId() == -1 && articleSearch.getKeyword().trim().equals("")) {
                request.setAttribute("flag", "1");
            } else {
                request.setAttribute("flag", "0");
            }
        }
        // 1.查找种类信息
        List<Type> types = blogManageService.getAllType();

        // 2.获取年份
        List<String> timeList = blogManageService.getAllArticleTime();

        // 3.获取文章信息
        // 3-1 获取页数。 防止为空
        String tempPage = request.getParameter("page");
        Integer page = 1;
        if (null == tempPage) {
            page = 1;
        } else {
            page = Integer.parseInt(tempPage);
        }
        PageModel pageModel = blogManageService.getDividArticle(page, articleSearch);
        request.setAttribute("types", types);
        request.setAttribute("timeList", timeList);
        request.setAttribute("pageModel", pageModel);
        request.setAttribute("search", articleSearch);
        return "toArticleManage";
    }

    public String deleteArticle() {
        HttpServletRequest request = ServletActionContext.getRequest();
        Integer id = Integer.parseInt(request.getParameter("id"));
        blogManageService.deleteArticle(id);
        return "toArticleManageAction";
    }

    public void updateArticle() throws IOException {
        blogManageService.modifyArticle(article);
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setCharacterEncoding("utf-8");
        Map<String, Object> map = new HashMap<>();
        map.put("state","1");
        response.getWriter().print(JSON.toJSON(map));
    }

}
