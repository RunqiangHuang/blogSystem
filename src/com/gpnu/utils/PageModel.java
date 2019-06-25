package com.gpnu.utils;

import java.util.ArrayList;
import java.util.List;

public class PageModel {
    // 当前页的信息
    private List list = new ArrayList();
    // 分页参数
    private int currentPageNum; // 当前页面
    private int pageSize = 10; // 页面大小
    private int totalRecords; // 总记录条数
    private int totalPageNum; // 总页数
    private int startIndex; // 开始的索引
    private int prePageNum; // 前一页
    private int nextPageNum; // 下一页

    // 每页显示5个页码
    private int startPage;
    private int endPage;

    public PageModel(int currentPageNum, int pageSize, int totalRecords) {
        super();
        this.currentPageNum = currentPageNum;
        this.pageSize = pageSize;
        this.totalRecords = totalRecords;
        // 设置起始的条数
        startIndex = (currentPageNum - 1) * pageSize;
        // 计算总页数。避免出现页数不一致
        totalPageNum = (totalRecords % pageSize == 0) ? (totalRecords / pageSize) : (totalRecords / pageSize + 1);
        // 计算前一页 下一页
        if (currentPageNum == 1) {
            prePageNum = 1;
        } else {
            prePageNum = currentPageNum - 1;
        }
        if (currentPageNum == totalPageNum) {
            nextPageNum = totalPageNum;
        } else {
            nextPageNum = currentPageNum + 1;
        }
        // 计算开始页码结束页码
        startPage = currentPageNum - 2;
        endPage = currentPageNum + 2;

        // 如果总页数大于5页
        if (totalPageNum > 5) {
            // 如果总页数50页
            // 当前页:第3页 startPage=1 endPage=5
            // 当前页:第2页 startPage=1 endPage=5
            // 当前页:第10页 startPage=8 endPage=12
            // 当前页:第13页 startPage=11 endPage=15
            // 当前页:第22页 startPage=20 endPage=24
            // 当前页:第50页 startPage=46 endPage=50
            if (startPage <= 0) {
                startPage = 1;
                endPage = startPage + 4;
            }
            if (endPage > totalPageNum) {
                endPage = totalPageNum;
                startPage = totalPageNum - 4;
            }
        } else {
            // 如果总页数小于5页
            startPage = 1;
            endPage = totalPageNum;
        }

    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public int getCurrentPageNum() {
        return currentPageNum;
    }

    public void setCurrentPageNum(int currentPageNum) {
        this.currentPageNum = currentPageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalRecords() {
        return totalRecords;
    }

    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;
    }

    public int getTotalPageNum() {
        return totalPageNum;
    }

    public void setTotalPageNum(int totalPageNum) {
        this.totalPageNum = totalPageNum;
    }

    public int getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(int startIndex) {
        this.startIndex = startIndex;
    }

    public int getPrePageNum() {
        return prePageNum;
    }

    public void setPrePageNum(int prePageNum) {
        this.prePageNum = prePageNum;
    }

    public int getNextPageNum() {
        return nextPageNum;
    }

    public void setNextPageNum(int nextPageNum) {
        this.nextPageNum = nextPageNum;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
}
