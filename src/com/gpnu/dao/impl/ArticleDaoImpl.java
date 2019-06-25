package com.gpnu.dao.impl;

import com.gpnu.dao.ArticleDao;
import com.gpnu.domain.Article;
import com.gpnu.utils.ArticleSearch;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@Repository
public class ArticleDaoImpl implements ArticleDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    @Override
    public void addArticle(Article article) {
        hibernateTemplate.save(article);
    }

    @Override
    public Article getArticleById(Integer id) {
        return hibernateTemplate.get(Article.class, id);
    }

    @Override
    public int getArticleCnt() {
        String hql = "select count(*) from Article where state = 1";
        List<Object> list = (List<Object>) hibernateTemplate.find(hql);
        if (list != null || list.size() != 0) {
            Object obj = list.get(0);
            Long lobj = (Long) obj;
            return lobj.intValue();
        }
        return 0;
    }

    @Override
    public List<Article> getDividArticleList(Integer startPage, Integer pageSize, ArticleSearch search) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Article.class);
        // 排序
        criteria.addOrder(Order.desc("publishTime"));
        // 状态为有效
        criteria.add(Restrictions.eq("state", 1));
        if (search != null) {
            // 增加条件
            if (!search.getYear().equals("不限")) {
                criteria.add(Restrictions.like("publishTime", search.getYear() + "%"));
            }
            if (!search.getMonth().equals("不限")) {
                criteria.add(Restrictions.like("publishTime", "_____" + search.getMonth() + "%"));
            }
            if (search.getTypeId() != -1) {
                criteria.add(Restrictions.eq("type.id", search.getTypeId()));
            }
            if (!search.getKeyword().trim().equals("")) {
                criteria.add(Restrictions.like("title", "%" + search.getKeyword() + "%"));
            }
        }
        List<Article> articles = (List<Article>) hibernateTemplate.findByCriteria(criteria, startPage, pageSize);
        return articles;
    }

    @Override
    public void deleteArticle(Article article) {
        article.setState(0);
        hibernateTemplate.update(article);
    }

    @Override
    public List<String> getTime() {
        String sql = "SELECT DISTINCT DATE_FORMAT(publishTime, '%Y') AS year FROM article ";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query query = session.createSQLQuery(sql);
        List<String> resList = query.list();
        return resList;
    }

    @Override
    public void modifyArticle(Article article) {
//        String hql = "update Article a set a.content = :content,a.title = :title,a.type.id = :typeId where a.id = :id";
        String hql = "update Article a set a.content = ?,a.title = ?,a.type.id = ? where a.id = ?";

        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query query = session.createQuery(hql);
        query.setParameter(0, article.getContent());
        query.setParameter(1, article.getTitle());
        query.setParameter(2, article.getType().getId());
        query.setParameter(3, article.getId());
        query.executeUpdate();
    }

    @Override
    public List<Article> getTop5Article() {
        DetachedCriteria criteria = DetachedCriteria.forClass(Article.class);
        // 排序
        criteria.addOrder(Order.desc("clickNum"));
        criteria.addOrder(Order.desc("publishTime"));
        List<Article> articles = (List<Article>) hibernateTemplate.findByCriteria(criteria, 1, 5);
        return articles;
    }

    @Override
    public int getArticleWithTypeCnt(Integer typeId) {
        String sql = "select count(*) from Article  where state = 1 and typeid = ?";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query query = session.createSQLQuery(sql);
        query.setParameter(0, typeId);
        BigInteger articleCnt = (BigInteger) query.uniqueResult();
        return articleCnt.intValue();
    }

    @Override
    public List<Article> getArticleListWithType(Integer startPage, Integer pageSize, Integer typeId) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Article.class);
        // 排序
        criteria.addOrder(Order.desc("publishTime"));
        // 状态为有效
        criteria.add(Restrictions.eq("state", 1));
        criteria.add(Restrictions.eq("type.id", typeId));
        List<Article> articles = (List<Article>) hibernateTemplate.findByCriteria(criteria, startPage, pageSize);
        return articles;
    }

    @Override
    public List<Article> getArticlesByKeyword(String keyword) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Article.class);
        // 排序
        criteria.addOrder(Order.desc("publishTime"));
        // 状态为有效
        criteria.add(Restrictions.eq("state", 1));
        //标题含有关键字
        criteria.add(Restrictions.like("title","%" + keyword + "%"));
        //标题或内容有
//        criteria.add(Restrictions.or(Restrictions.like("title",keyword), Restrictions.like("content",keyword)));
        List<Article> articles = (List<Article>) hibernateTemplate.findByCriteria(criteria);
        return articles;
    }

    @Override
    public Article addClickCnt(Article article) {
        article.setClickNum(article.getClickNum() + 1);
        hibernateTemplate.update(article);
        return article;
    }

    @Override
    public void addCommentCnt(Article article) {
        article.setCommentNum(article.getCommentNum() + 1);
        hibernateTemplate.update(article);
    }

    @Override
    public void subCommentCnt(Article article) {
        article.setCommentNum(article.getCommentNum() - 1);
        hibernateTemplate.update(article);
    }
}
