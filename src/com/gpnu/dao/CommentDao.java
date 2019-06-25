package com.gpnu.dao;

import com.gpnu.domain.Comment;

import java.util.List;

public interface CommentDao {
    public void addComment(Comment comment);
    public List<Comment> getDividComment(Integer startPage, Integer pageSize);
    public int getAllCommentCnt();
    public Comment findCommentById(Integer id);
    public void deleteComment(Comment comment);
    public void deleteCommentWithArticleid(Integer articleId);
}
