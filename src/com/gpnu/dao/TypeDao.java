package com.gpnu.dao;

import com.gpnu.domain.Type;

import java.util.List;

public interface TypeDao {

    //获取所有类别
    public List<Type> getAllType();

    //修改类别
    public void modifyType(Type type);

    //删除类别
    public void deleteType(Integer id);

    //增加类别
    public Type addType(Type type);

    //条件查询
    public List<Type> getTypeByKeyword(String keyword);
}
