package com.stu.util;

import java.util.List;

/**
 * @ClassName PageModel
 * @Description 分页模型
 * @Author BX
 * @Date 2020/12/12 0012 15:50
 * @Version 1.0
 **/
public class PageModel<T> {
    private int pageSize;//每条显示的条数
    private int pageNo;//当前页码
    private long cnt;//总条数
    private List<T> dataList;//存储的分页数据
    private String dateInfo;//转换后的日期

    /**
     *首页
     */
    public long getFirstPage(){
        return 1;
    }

    /**
     * 上一页
     */
    public long getPrePage(){
        if(pageNo <= 1){
            return 1;
        }
        return pageNo - 1;
    }

    /**
     * 下一页
     * @return
     */
    public long getNextPage(){
        if(pageNo >= getTotalPage()){
            return getTotalPage();
        }
        return pageNo + 1;
    }

    /**
     * 尾页
     * @return
     */
    public long getLastPage(){
        return getTotalPage();
    }

    /**
     * 总页码
     * @return
     */
    public long getTotalPage(){
        return cnt%pageSize==0? cnt/pageSize : cnt/pageSize + 1;
    }

    /**
     * 从浏览器获取传入的PageNo
     */
    public static int getPageNoFromIE(String pageNoStr){
        int pageNo = 0;
        if(null == pageNoStr){
            pageNo = 1;
        }else{
            pageNo = Integer.valueOf(pageNoStr);
        }
        return pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        if(pageNo < 1){
            this.pageNo = 1;
        }else{
            this.pageNo = pageNo;
        }
    }

    public long getCnt() {
        return cnt;
    }

    public void setCnt(long cnt) {
        this.cnt = cnt;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    public String getDateInfo() {
        return dateInfo;
    }

    public void setDateInfo(String dateInfo) {
        this.dateInfo = dateInfo;
    }
}
