package com.gpnu.dao;

import com.gpnu.domain.Message;

import java.util.List;

public interface MessageDao {
    public List<Message> getAllMessage();

    //统计数目
    public Integer getMsgCnt();

    /**
     * 分页
     *
     * @param startPage 第几页
     * @param pageSize  每页显示多少条
     * @return 分页信息
     */
    public List<Message> getMessageByDivid(Integer startPage, Integer pageSize);

    /**
     * 删除留言
     * @param id 留言Id
     */
    public void deleteMsg(Integer id);

    public void addMessage(Message message);
}
