package com.gpnu.dao.impl;

import com.gpnu.dao.AdminDao;
import com.gpnu.domain.Admin;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class AdminDaoImpl implements AdminDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    /**
     * 获取管理员的信息
     *
     * @return 管理员信息
     */
    @Override
    public Admin getAdminMsg() {
        List<Admin> admins = (List<Admin>) hibernateTemplate.find("from Admin");
        return admins.get(0);
    }

    @Override
    public void updateMsg(Admin admin) {
        String sql = "update ownerinfo set summary = ? ,email = ?, name = ? , tel = ? where account = 'admin'";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        sqlQuery.setParameter(0, admin.getSummary());
        sqlQuery.setParameter(1, admin.getEmail());
        sqlQuery.setParameter(2, admin.getName());
        sqlQuery.setParameter(3, admin.getTel());
        sqlQuery.executeUpdate();
    }

    @Override
    public void changeHeadimg(String newPath) {
        String sql = "update ownerinfo set headImg = ? where account = 'admin' ";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        sqlQuery.setParameter(0, newPath);
        sqlQuery.executeUpdate();
    }

    @Override
    public void changePassword(String newPassword) {
        String hql = "update Login set password = ? where type = 0";
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query query = session.createQuery(hql);
        query.setParameter(0, newPassword);
        query.executeUpdate();
    }

    @Override
    public boolean checkOldPassword(String account,String password) {
        String hql = "select account from Login where account = ? and password = ? and type = 0" ;
        Session session = hibernateTemplate.getSessionFactory().getCurrentSession();
        Query query = session.createSQLQuery(hql);
        query.setParameter(0,account);
        query.setParameter(1,password);
        List<Object> list = query.list();
        if(list != null && list.size() == 1){
            return true;
        }
        return false;
    }
}
