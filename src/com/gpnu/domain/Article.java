package com.gpnu.domain;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "article")
@DynamicInsert(true)
public class Article {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String title;

    @Column
    private String content;

    @Column
    private String publishTime;

    @ManyToOne
    @JoinColumn(name = "typeid")
    private Type type;

    @Column
    private Integer state;


    @Column
    private Integer clickNum;

    @Column
    private Integer commentNum;

    @OneToMany(mappedBy = "article")
    @OrderBy("time desc")
    @Basic(fetch=FetchType.LAZY)
    private Set<Comment> comments;

    @Override
    public String toString() {
        return "Article{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", publishTime='" + publishTime + '\'' +
                ", type=" + type +
                ", state=" + state +
                ", clickNum=" + clickNum +
                ", commentNum=" + commentNum +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(String publishTime) {
        this.publishTime = publishTime;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getClickNum() {
        return clickNum;
    }

    public void setClickNum(Integer clickNum) {
        this.clickNum = clickNum;
    }

    public Integer getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(Integer commentNum) {
        this.commentNum = commentNum;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getDraftId(){
        return null;
    }

    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }
}
