package com.stu.util;

import java.util.List;

/**
 * @ClassName EmployAnalyse
 * @Description //前端eCharts数据封装 JSON
 * @Author BX
 * @Date 2020/12/8 0008 18:08
 * @Version 1.0
 **/
public class EmployAnalyse {

    //图表标题封装
    private List<String> title;
    //图表标题封装对象
    private List<HiChartsParams> result;
    //图表数量封装
    private List<Integer> count;
    //k-V数据封装
    private List<List<Object>> numbers;

    public List<String> getTitle() {
        return title;
    }
    public void setTitle(List<String> title) {
        this.title = title;
    }
    public List<List<Object>> getNumber() {
        return numbers;
    }
    public void setNumber(List<List<Object>> numbers) {
        this.numbers = numbers;
    }
    public List<Integer> getCount() {
        return count;
    }
    public void setCount(List<Integer> count) {
        this.count = count;
    }

    public List<HiChartsParams> getResult() {
        return result;
    }

    public void setResult(List<HiChartsParams> result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return "EmployAnalyse{" +
                "title=" + title +
                ", result=" + result +
                ", count=" + count +
                ", number=" + numbers +
                '}';
    }
}
