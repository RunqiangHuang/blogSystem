package com.gpnu.service;

import com.gpnu.domain.*;
import com.gpnu.utils.ArticleSearch;
import com.gpnu.utils.PageModel;

import java.util.List;

public interface IUserService {
    ///////////
    //用户
    //找到用户信息
    public User findUserByAccount(String account);
    //注册
    public void register(User user, Login login);

    ////////
    // 文章
    //获取文章信息
    public Article getArticle(Integer id, String flag);
    //分页获取文章大概内容【去html标签】
    public PageModel getDividArticle(Integer page, ArticleSearch search);
    //获取top5文章
    public List<Article> getTop5Article();
    //根据分类查找文章
    public PageModel getDividArticleWithType(Integer page, Integer typeId);
    //关键词查找文章
    public List<Article> getArticlesByKeyword(String keyword);

    ////////
    //评论
    public void makeComment(Comment comment);

    ///////
    //留言
    public void addMsg(Message message);

    public PageModel getMessageWithDivid(Integer page);

    ///////
    //类别
    //获取所有分类
    public List<Type> getAllType();
}
