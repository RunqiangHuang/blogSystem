package com.gpnu.service.impl;

import com.gpnu.dao.*;
import com.gpnu.domain.*;
import com.gpnu.service.IUserService;
import com.gpnu.utils.ArticleSearch;
import com.gpnu.utils.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("userService")
@Transactional
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private LoginDao loginDao;

    @Autowired
    private ArticleDao articleDao;

    @Autowired
    private MessageDao messageDao;

    @Autowired
    private CommentDao commentDao;

    @Autowired
    private TypeDao typeDao;

    @Override
    public User findUserByAccount(String account) {
        return userDao.findUserByAccount(account);
    }

    @Override
    public void register(User user, Login login) {
        // 插入登录表
        loginDao.addLogin(login);
        // 插入用户表
        userDao.addUser(user);
    }

    @Override
    public Article getArticle(Integer id, String flag) {
        Article article = articleDao.getArticleById(id);
        if (flag.equals("1")) {
            //浏览量+1
            article = articleDao.addClickCnt(article);
        }
        return article;
    }

    @Override
    public PageModel getDividArticle(Integer page, ArticleSearch search) {
        Integer totalCnt = articleDao.getArticleCnt();
        PageModel pageModel = new PageModel(page, 9, totalCnt);
        pageModel.setList(articleDao.getDividArticleList(pageModel.getStartIndex(), pageModel.getPageSize(), search));
        return pageModel;
    }

    @Override
    public List<Article> getTop5Article() {
        return articleDao.getTop5Article();
    }

    @Override
    public PageModel getDividArticleWithType(Integer page, Integer typeId) {
        Integer totalCnt = articleDao.getArticleWithTypeCnt(typeId);
        PageModel pageModel = new PageModel(page, 10, totalCnt);
        List<Article> articleList = articleDao.getArticleListWithType(pageModel.getStartIndex(), pageModel.getPageSize(), typeId);
        pageModel.setList(articleList);
        return pageModel;
    }

    @Override
    public List<Article> getArticlesByKeyword(String keyword) {
        return articleDao.getArticlesByKeyword(keyword);
    }

    @Override
    public void makeComment(Comment comment) {
        commentDao.addComment(comment);
        Article article = articleDao.getArticleById(comment.getArticle().getId());
        articleDao.addCommentCnt(article);
    }

    @Override
    public void addMsg(Message message) {
        messageDao.addMessage(message);
    }

    @Override
    public PageModel getMessageWithDivid(Integer page) {
        // 1.获取总页数
        Integer totalCnt = messageDao.getMsgCnt();
        PageModel pageModel = new PageModel(page,10,totalCnt);
        pageModel.setList(messageDao.getMessageByDivid(pageModel.getStartIndex(),pageModel.getPageSize()));
        return pageModel;
    }

    @Override
    public List<Type> getAllType() {
        return typeDao.getAllType();
    }
}
