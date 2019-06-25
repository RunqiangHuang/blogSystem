package com.gpnu.dao.impl;

import com.gpnu.dao.MessageDao;
import com.gpnu.domain.Message;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class MessageDaoImpl implements MessageDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    @Override
    public List<Message> getAllMessage() {
        return (List<Message>) hibernateTemplate.find("from Message");
    }

    // 获取留言的数目
    @Override
    public Integer getMsgCnt() {
        String hql = "select count(*) from Message where state = 1";
        List<Object> list = (List<Object>) hibernateTemplate.find(hql);
        if (list != null || list.size() != 0) {
            Object obj = list.get(0);
            Long lobj = (Long) obj;
            return lobj.intValue();
        }
        return 0;
    }

    @Override
    public List<Message> getMessageByDivid(Integer startPage, Integer pageSize) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Message.class);
        criteria.addOrder(Order.desc("time"));
        criteria.add(Restrictions.eq("state",1));
        List<Message> list = (List<Message>) hibernateTemplate.findByCriteria(criteria, startPage, pageSize);
        return list;
    }

    @Override
    public void deleteMsg(Integer id) {
        // 先查询出来
        Message msg = hibernateTemplate.get(Message.class, id);
        // 标志位为 0 代表删除 数据库不删除
        msg.setState(0);
        hibernateTemplate.update(msg);
    }

    @Override
    public void addMessage(Message message) {
        hibernateTemplate.save(message);
    }

}
