package com.gpnu.utils;

public class ArticleSearch extends Search {
    private String year;
    private String month;
    private Integer typeId;

    @Override
    public String toString() {
        return "ArticleSearch{" +
                "year='" + year + '\'' +
                ", month='" + month + '\'' +
                ", type='" + typeId + '\'' +
                ", keyword='" + super.getKeyword() + '\'' +
                '}';
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }
}
