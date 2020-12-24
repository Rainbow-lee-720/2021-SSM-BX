package com.stu.util;

/**
 * @ClassName HiChartsParams
 * @Description //charts参数
 * @Author BX
 * @Date 2020/12/10 0010 20:57
 * @Version 1.0
 **/
public class HiChartsParams {
    //名称
    private String kind;
    //数值
    private Integer number;

    public HiChartsParams() {
    }

    public HiChartsParams(String kind, Integer number) {
        this.kind = kind;
        this.number = number;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "HiChartsParams{" +
                "kind='" + kind + '\'' +
                ", number=" + number +
                '}';
    }
}
