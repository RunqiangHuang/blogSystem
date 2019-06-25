package com.gpnu.dao;

import com.gpnu.domain.Article;
import com.gpnu.utils.ArticleSearch;

import java.util.List;

public interface ArticleDao {
    public void addArticle(Article article);

    public Article getArticleById(Integer id);

    // 获取数目
    public int getArticleCnt();

    // 分页查询
    public List<Article> getDividArticleList(Integer startPage, Integer pageSize, ArticleSearch search);

    // 删除
    public void deleteArticle(Article article);

    public List<String> getTime();

    public void modifyArticle(Article article);

    public List<Article> getTop5Article();

    // 某一分类的数目
    public int getArticleWithTypeCnt(Integer typeId);

    //根据类别查询
    public List<Article> getArticleListWithType(Integer startPage, Integer pageSize,Integer typeId);

    //模糊查询文章。
    public List<Article> getArticlesByKeyword(String keyword);

    //添加浏览数
    public Article addClickCnt(Article article);

    //添加评论数
    public void addCommentCnt(Article article);

    //减少评论数
    public void subCommentCnt(Article article);
}
