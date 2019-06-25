package com.gpnu.utils;

public class Search {
    private String keyword;

    @Override
    public String toString() {
        return "Serch{" +
                "keyword='" + keyword + '\'' +
                '}';
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
}
