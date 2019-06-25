package com.gpnu.dao.impl;

import com.gpnu.dao.TypeDao;
import com.gpnu.domain.Type;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class TypeDaoImpl implements TypeDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    @Override
    public List<Type> getAllType() {
//        return null;
        return (List<Type>) hibernateTemplate.find("from Type");
    }

    @Override
    public void modifyType(Type type) {
        hibernateTemplate.update(type);
    }

    @Override
    public void deleteType(Integer id) {
        Type type = hibernateTemplate.get(Type.class, id);
        hibernateTemplate.delete(type);
    }

    @Override
    public Type addType(Type type) {
        hibernateTemplate.save(type);
        return type;
    }

    @Override
    public List<Type> getTypeByKeyword(String keyword) {
        // 条件查询。利用DetachedCriteria实现
        DetachedCriteria criteria = DetachedCriteria.forClass(Type.class);
        if(keyword != null || !keyword.trim().equals("")){
            criteria.add(Restrictions.like("name","%" + keyword + "%"));
        }
        return (List<Type>) hibernateTemplate.findByCriteria(criteria);
    }
}
