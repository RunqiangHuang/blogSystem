package com.gpnu.service;

import com.gpnu.domain.Article;
import com.gpnu.domain.Draft;
import com.gpnu.domain.Type;
import com.gpnu.utils.ArticleSearch;
import com.gpnu.utils.PageModel;

import java.util.List;

public interface IBlogManageService {
    ///////////////////////////////////
    //文章
    //获取文章信息
    public Article getArticle(Integer id, String flag);
    // 获取所有时间
    public List<String> getAllArticleTime();
    //分页获取文章
    public PageModel getDividArticle(Integer page, ArticleSearch search);
    //增加文章
    public void addArticle(Article article, String draftId);
    //删除文章
    public void deleteArticle(Integer id);
    //修改文章
    public void modifyArticle(Article article);
    //根据种类查找文章
    public PageModel getDividArticleWithType(Integer page, Integer typeId);

    /////////////////////////////////
    // 类别
    //获取所有类别
    public List<Type> getAllType();
    //修改类别
    public void modifyType(Type type);
    //删除类别
    public void deleteType(Integer id);
    //增加类别
    public Type addType(Type type);
    //关键词查询类别
    public List<Type> getTypeByKeyword(String keyword);

    //////////////////////////////
    //留言
    //分页获取留言
    public PageModel getMessageWithDivid(Integer page);

    //删除留言
    public void deleteMsg(Integer id);

    /////////////////////////////
    //草稿
    //显示草稿
    public List<Draft> listDraft();
    //添加草稿
    public Draft addDraft(Draft draft);
    //修改草稿
    public void updateDraft(Draft draft);
    //删除草稿
    public void deleteDraft(Integer id);
    //根据id查找草稿
    public Draft findDraftById(Integer id);

    /////////////////////////////
    //评论
    //分页显示评论
    public PageModel getDividComment(Integer page);
    //删除评论
    public void deleteComment(Integer id);

}
