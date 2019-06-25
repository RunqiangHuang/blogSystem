package com.gpnu.service.impl;

import com.gpnu.dao.*;
import com.gpnu.domain.Article;
import com.gpnu.domain.Comment;
import com.gpnu.domain.Draft;
import com.gpnu.domain.Type;
import com.gpnu.service.IBlogManageService;
import com.gpnu.utils.ArticleSearch;
import com.gpnu.utils.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("blogManageService")
@Transactional
public class BlogManageServiceImpl implements IBlogManageService {

    @Autowired
    private ArticleDao articleDao;

    @Autowired
    private DraftDao draftDao;

    @Autowired
    private CommentDao commentDao;

    @Autowired
    private TypeDao typeDao;

    @Autowired
    private MessageDao messageDao;

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
    public List<String> getAllArticleTime() {
        return articleDao.getTime();
    }

    @Override
    public PageModel getDividArticle(Integer page, ArticleSearch search) {
        Integer totalCnt = articleDao.getArticleCnt();
        PageModel pageModel = new PageModel(page, 6, totalCnt);
        pageModel.setList(articleDao.getDividArticleList(pageModel.getStartIndex(), pageModel.getPageSize(), search));
        return pageModel;
    }

    @Override
    public void addArticle(Article article, String draftId) {
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(date);
        article.setPublishTime(time);
        // 需要看是不是在草稿上改来的
        if (draftId != null && !draftId.trim().equals("")) {
            Integer tempId = Integer.parseInt(draftId);
            Draft draft = draftDao.findDraftById(tempId);
            draftDao.deleteDraft(draft);
        }
        articleDao.addArticle(article);
    }

    @Override
    public void deleteArticle(Integer id) {
        Article article = articleDao.getArticleById(id);
        articleDao.deleteArticle(article);
        // 对所属文章对应的评论进行处理
        commentDao.deleteCommentWithArticleid(id);
    }

    @Override
    public void modifyArticle(Article article) {
        articleDao.modifyArticle(article);
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
    public List<Type> getAllType() {
        return typeDao.getAllType();
    }

    @Override
    public void modifyType(Type type) {
        typeDao.modifyType(type);
    }

    @Override
    public void deleteType(Integer id) {
        typeDao.deleteType(id);
    }

    @Override
    public Type addType(Type type) {
        return typeDao.addType(type);
    }

    @Override
    public List<Type> getTypeByKeyword(String keyword) {
        return typeDao.getTypeByKeyword(keyword);
    }

    @Override
    public PageModel getMessageWithDivid(Integer page) {
        // 1.获取总页数
        Integer totalCnt = messageDao.getMsgCnt();
        // 2.设置数据
        PageModel pageModel = new PageModel(page, 10, totalCnt);
        pageModel.setList(messageDao.getMessageByDivid(pageModel.getStartIndex(), pageModel.getPageSize()));
        return pageModel;
    }

    @Override
    public void deleteMsg(Integer id) {
        messageDao.deleteMsg(id);
    }

    @Override
    public List<Draft> listDraft() {
        return draftDao.listDrafts();
    }

    @Override
    public Draft addDraft(Draft draft) {
        draftDao.addDraft(draft);
        return draft;
    }

    @Override
    public void updateDraft(Draft draft) {
        draftDao.updateDraft(draft);
    }

    @Override
    public void deleteDraft(Integer id) {
        //先查出当前草稿
        Draft draft = draftDao.findDraftById(id);
        //删除
        draftDao.deleteDraft(draft);
    }

    @Override
    public Draft findDraftById(Integer id) {
        return draftDao.findDraftById(id);
    }

    @Override
    public PageModel getDividComment(Integer page) {
        Integer totalCnt = commentDao.getAllCommentCnt();
        PageModel pageModel = new PageModel(page,10,totalCnt);
        pageModel.setList(commentDao.getDividComment(pageModel.getStartIndex(),pageModel.getPageSize()));
        return pageModel;
    }

    @Override
    public void deleteComment(Integer id) {
        Comment comment= commentDao.findCommentById(id);
        commentDao.deleteComment(comment);
        //评论数-1
        Integer articleId = comment.getArticle().getId();
        Article article = articleDao.getArticleById(articleId);
        articleDao.subCommentCnt(article);
    }
}
