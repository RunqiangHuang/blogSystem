package com.gpnu.dao.impl;

import com.gpnu.dao.CommentDao;
import com.gpnu.domain.Comment;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class CommentDaoImpl implements CommentDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    @Override
    public void addComment(Comment comment) {
        hibernateTemplate.save(comment);
    }


    @Override
    public List<Comment> getDividComment(Integer startPage, Integer pageSize) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Comment.class);
        criteria.addOrder(Order.desc("time"));
        criteria.add(Restrictions.eq("state", 1));
        List<Comment> list = (List<Comment>) hibernateTemplate.findByCriteria(criteria, startPage, pageSize);
        return list;
    }

    @Override
    public int getAllCommentCnt() {
        String hql = "select count(*) from Comment where state = 1";
        List<Object> list = (List<Object>) hibernateTemplate.find(hql);
        if (list != null || list.size() != 0) {
            Object obj = list.get(0);
            Long lobj = (Long) obj;
            return lobj.intValue();
        }
        return 0;
    }


    @Override
    public Comment findCommentById(Integer id) {
        return hibernateTemplate.get(Comment.class,id);
    }

    @Override
    public void deleteComment(Comment comment) {
        comment.setState(0);
        hibernateTemplate.update(comment);
    }

    @Override
    public void deleteCommentWithArticleid(Integer articleId) {
        String hql = "update Comment set state = 0 where id = ?";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query query = session.createQuery(hql);
        query.setParameter(0,articleId);
        query.executeUpdate();
    }
}
